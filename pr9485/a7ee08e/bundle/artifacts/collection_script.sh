#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

HEAD_SHA="$(git rev-parse HEAD)"
EXPECTED_HEAD="a7ee08ed586fe3801eae7db0de5ed1ca530cd4b0"
test "$HEAD_SHA" = "$EXPECTED_HEAD"

set -x
git status --porcelain
git branch --show-current
git merge-base HEAD origin/main
git log --oneline origin/main..HEAD
git diff --stat origin/main...HEAD
git diff --name-status origin/main...HEAD
./run_tests.sh .claude/commands/tests/test_compose_commands.py
python3 scripts/sync_codex_claude_skills.py --scope project --dry-run
set +x

for COMMAND_PATH in \
  .claude_reference/commands/planexec.md \
  "$HOME/.claude/commands/planexec.md"
do
  grep -Fq '(`~/.claude/skills/solid/SKILL.md`)' "$COMMAND_PATH"
  if grep -Fq '(`.claude/skills/solid/SKILL.md`)' "$COMMAND_PATH"; then
    printf "%s\tFAIL stale project-relative SOLID path\n" "$COMMAND_PATH"
    exit 1
  fi
  printf "%s\t~/.claude/skills/solid/SKILL.md\tPASS\n" "$COMMAND_PATH"
done
printf "PLANEXEC_SOLID_REFS: PASS 2/2\n"

printf "source\tcanonical_sha256\tbase_blob_sha256\tresult\n"
COUNT=0
for REL in \
  commands/_shared/header.md \
  commands/spec-kit/clarify.md \
  commands/spec-kit/implement-spec.md \
  commands/spec-kit/plan-spec.md \
  commands/spec-kit/spec.md \
  commands/spec-kit/tasks-spec.md \
  skills/generalized-testing/SKILL.md \
  skills/solid/SKILL.md \
  skills/solid/references/architecture.md \
  skills/solid/references/clean-code.md \
  skills/solid/references/code-smells.md \
  skills/solid/references/complexity.md \
  skills/solid/references/design-patterns.md \
  skills/solid/references/object-design.md \
  skills/solid/references/solid-principles.md \
  skills/solid/references/tdd.md \
  skills/solid/references/testing.md
do
  CANONICAL_SHA="$(sha256sum "$HOME/.claude/$REL" | awk '{print $1}')"
  BASE_SHA="$(git show "origin/main:.claude/$REL" | sha256sum | awk '{print $1}')"
  test "$CANONICAL_SHA" = "$BASE_SHA"
  printf "%s\t%s\t%s\tPASS\n" "$REL" "$CANONICAL_SHA" "$BASE_SHA"
  COUNT=$((COUNT + 1))
done
printf "CANONICAL_BYTES: PASS %s/17\n" "$COUNT"

for COMMAND in header ralph_benchmark_parallel ralph_iteration ralph_pair_iteration; do
  TOML=".gemini/commands/$COMMAND.toml"
  TARGET="../../.claude/commands/$COMMAND.md"
  test -f "$TOML"
  grep -Fq "@{$TARGET}" "$TOML"
  test -f ".claude/commands/$COMMAND.md"
  printf "%s\t%s\tPASS\n" "$TOML" "$TARGET"
done
printf "GEMINI_WRAPPERS: PASS 4/4\n"

for SKILL in generalized-testing solid; do
  LINK="$HOME/.codex/skills/$SKILL"
  test -L "$LINK"
  test "$(readlink "$LINK")" = "../../.claude/skills/$SKILL"
  test -s "$LINK/SKILL.md"
  printf "%s\t../../.claude/skills/%s\tPASS\n" "$SKILL" "$SKILL"
done
printf "GLOBAL_CODEX_DISCOVERY: PASS 2/2\n"

CATALOG_SHA="41ce34ba240f4d5e8ff5c479907db4887598ce00"
CATALOG_SOURCE_ROOT="$(mktemp -d /tmp/pr9485-catalog-source.XXXXXX)"
CATALOG_INSTALL_PARENT="$(mktemp -d /tmp/pr9485-catalog-home.XXXXXX)"
git clone --quiet --filter=blob:none \
  https://github.com/jleechanorg/jleechan-skills.git "$CATALOG_SOURCE_ROOT"
git -C "$CATALOG_SOURCE_ROOT" checkout --quiet --detach "$CATALOG_SHA"
test "$(git -C "$CATALOG_SOURCE_ROOT" rev-parse HEAD)" = "$CATALOG_SHA"
HOME="$CATALOG_INSTALL_PARENT" \
CLAUDE_HOME="$CATALOG_INSTALL_PARENT/.claude" \
  bash "$CATALOG_SOURCE_ROOT/install-claude-commands.sh"

CATALOG_COUNT=0
for REL in \
  commands/_shared/header.md \
  commands/spec-kit/clarify.md \
  commands/spec-kit/implement-spec.md \
  commands/spec-kit/plan-spec.md \
  commands/spec-kit/spec.md \
  commands/spec-kit/tasks-spec.md \
  skills/generalized-testing/SKILL.md \
  skills/solid/SKILL.md \
  skills/solid/references/architecture.md \
  skills/solid/references/clean-code.md \
  skills/solid/references/code-smells.md \
  skills/solid/references/complexity.md \
  skills/solid/references/design-patterns.md \
  skills/solid/references/object-design.md \
  skills/solid/references/solid-principles.md \
  skills/solid/references/tdd.md \
  skills/solid/references/testing.md
do
  INSTALLED_SHA="$(sha256sum "$CATALOG_INSTALL_PARENT/.claude/$REL" | awk '{print $1}')"
  SOURCE_SHA="$(sha256sum "$CATALOG_SOURCE_ROOT/.claude/$REL" | awk '{print $1}')"
  BASE_SHA="$(git show "origin/main:.claude/$REL" | sha256sum | awk '{print $1}')"
  test "$INSTALLED_SHA" = "$SOURCE_SHA"
  test "$INSTALLED_SHA" = "$BASE_SHA"
  printf "%s\t%s\t%s\tPASS\n" "$REL" "$INSTALLED_SHA" "$CATALOG_SHA"
  CATALOG_COUNT=$((CATALOG_COUNT + 1))
done
printf "CATALOG_INSTALL_BYTES: PASS %s/17\n" "$CATALOG_COUNT"

DISCOVERY_RAW="$(mktemp /tmp/pr9485-host-init.XXXXXX.jsonl)"
set +e
(
  cd "$CATALOG_INSTALL_PARENT"
  CLAUDE_CONFIG_DIR="$CATALOG_INSTALL_PARENT/.claude" \
    claude -p --output-format stream-json --verbose --model haiku \
      --max-turns 1 --max-budget-usd 0.01 --no-session-persistence \
      'Reply only OK.'
) > "$DISCOVERY_RAW"
DISCOVERY_STATUS=$?
set -e
test "$DISCOVERY_STATUS" -eq 1
grep -Fq '"error":"authentication_failed"' "$DISCOVERY_RAW"
DISCOVERY_JSON="$(
  jq -c 'select(.type == "system" and .subtype == "init") |
      {commands: [.slash_commands[] |
        select(. == "spec-kit:clarify" or
               . == "spec-kit:implement-spec" or
               . == "spec-kit:plan-spec" or
               . == "spec-kit:spec" or
               . == "spec-kit:tasks-spec")],
       skills: [.skills[] |
        select(. == "generalized-testing" or . == "solid")]}' \
    "$DISCOVERY_RAW"
)"
test "$(printf "%s" "$DISCOVERY_JSON" | jq '.commands | length')" -eq 5
test "$(printf "%s" "$DISCOVERY_JSON" | jq '.skills | length')" -eq 2
printf "%s\n" "$DISCOVERY_JSON"
printf "CATALOG_HOST_DISCOVERY: PASS commands=5/5 skills=2/2 auth=expected-isolated-home-failure\n"

POST_SHA="$(git rev-parse HEAD)"
test "$POST_SHA" = "$EXPECTED_HEAD"
test -z "$(git status --porcelain)"
printf "PRE=%s\nPOST=%s\nSHA MATCH\nWORKTREE_STATUS: CLEAN\n" "$HEAD_SHA" "$POST_SHA"

# PR #9485 exact-head evidence

This bundle verifies the non-production command/skill ownership cleanup at
`a7ee08ed586fe3801eae7db0de5ed1ca530cd4b0`.

## Scope note

In scope: deleted WorldAI command/skill copies, the retained `code-quality`
cross-reference, project Codex skill-sync behavior, and user-scope canonical
copy/discovery checks, plus an isolated install from pinned `jleechan-skills`
revision `41ce34ba240f4d5e8ff5c479907db4887598ce00`. Application runtime,
production deployment, UI behavior, and general portability beyond that pinned
catalog installation are out of scope.

## Clean-computer reproduction

Requirements: authenticated GitHub access to the private repository, network
access to GitHub for the pinned public `jleechan-skills` catalog clone, Git,
Bash, and CPython 3.12.11 (the captured environment). No service account,
Firebase credential, API key, Node runtime, application server, or model
provider call is used by these non-production checks.

```bash
git clone git@github.com:jleechanorg/worldarchitect.ai.git
cd worldarchitect.ai
git checkout chore/dedupe-global-commands-skills-20260828
test "$(git rev-parse HEAD)" = "a7ee08ed586fe3801eae7db0de5ed1ca530cd4b0"
python3.12 -m venv venv
./venv/bin/python -m pip install --upgrade pip
./venv/bin/python -m pip install -r requirements.txt -r mvp_site/requirements.txt -r genesis/requirements.txt
./run_tests.sh .claude/commands/tests/test_compose_commands.py
python3 scripts/sync_codex_claude_skills.py --scope project --dry-run
```

Expected: `test_compose_commands.py` passes 1/1; the active `planexec`
dependency assertion is part of that focused file. The sync dry run emits no
line beginning with `linked` or `error:`. The
published collection log also records the 17/17 canonical byte comparisons,
four retained Gemini wrapper mappings, the two repaired `planexec` references,
two global Codex pointers, a 17/17 isolated catalog install, host discovery of
five commands and two skills, and clean pre/post SHA identity.

## Artifacts

- [`terminal.gif`](https://jleechan2015.github.io/worldarchitect-pr-evidence/pr9485/a7ee08e/terminal.gif) — browser-friendly preview of provenance, diff, tests, sync, dependency repair, byte-preservation, discovery, and post-run SHA.
- [`terminal.mp4`](https://jleechan2015.github.io/worldarchitect-pr-evidence/pr9485/a7ee08e/terminal.mp4) — downloadable high-fidelity terminal video, served as `video/mp4`.
- [`terminal.vtt`](https://jleechan2015.github.io/worldarchitect-pr-evidence/pr9485/a7ee08e/terminal.vtt) — captions naming the test, result, and key assertions, served as `text/vtt`.
- `terminal.cast` — asciinema presentation of key raw log lines.
- `terminal-transcript.txt` — authoritative non-TTY command transcript.
- `artifacts/collection_script.sh` — exact collection commands.
- `artifacts/collection_log.txt` — sanitized raw output from that script,
  including per-file SHA-256 comparisons and retained Gemini mappings.
- `metadata.json`, `run.json`, `methodology.md`, `evidence.md` — provenance and
  claim mapping.
- `checksums.sha256` — integrity manifest for every substantive artifact.

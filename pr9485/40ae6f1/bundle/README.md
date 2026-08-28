# PR #9485 exact-head evidence

This bundle verifies the non-production command/skill ownership cleanup at
`40ae6f15fb3a7144928017591d30a6f7ec1a7c67`.

## Scope note

In scope: deleted WorldAI command/skill copies, the retained `code-quality`
cross-reference, project Codex skill-sync behavior, and user-scope canonical
copy/discovery checks. Application runtime, production deployment, UI behavior,
LLM behavior, and portability to machines without the user's global skill
catalog are out of scope.

## Clean-computer reproduction

Requirements: authenticated GitHub access to the private repository, Git,
Bash, and CPython 3.12.11 (the captured environment). No service account,
Firebase credential, API key, Node runtime, server, or external service is
used by these non-production checks.

```bash
git clone git@github.com:jleechanorg/worldarchitect.ai.git
cd worldarchitect.ai
git checkout chore/dedupe-global-commands-skills-20260828
test "$(git rev-parse HEAD)" = "40ae6f15fb3a7144928017591d30a6f7ec1a7c67"
python3.12 -m venv venv
./venv/bin/python -m pip install --upgrade pip
./venv/bin/python -m pip install -r requirements.txt -r mvp_site/requirements.txt -r genesis/requirements.txt
./run_tests.sh .claude/commands/tests/test_compose_commands.py
python3 scripts/sync_codex_claude_skills.py --scope project --dry-run
```

Expected: `test_compose_commands.py` passes 1/1 (its internal runner reports
eight passing cases, including the active `planexec` dependency regression);
the sync dry run emits no line beginning with `linked` or `error:`. The
published collection log also records the 17/17 canonical byte comparisons,
four retained Gemini wrapper mappings, the two repaired `planexec` references,
two global Codex pointers, and clean pre/post SHA identity. Those
user-scope checks describe the capture machine; cross-machine installation of
the user's global catalog is deliberately not claimed.

## Artifacts

- [`terminal.gif`](https://jleechan2015.github.io/worldarchitect-pr-evidence/pr9485/40ae6f1/terminal.gif) — browser-friendly preview of provenance, diff, tests, sync, dependency repair, byte-preservation, discovery, and post-run SHA.
- [`terminal.mp4`](https://jleechan2015.github.io/worldarchitect-pr-evidence/pr9485/40ae6f1/terminal.mp4) — downloadable high-fidelity terminal video, served as `video/mp4`.
- [`terminal.vtt`](https://jleechan2015.github.io/worldarchitect-pr-evidence/pr9485/40ae6f1/terminal.vtt) — captions naming the test, result, and key assertions, served as `text/vtt`.
- `terminal.cast` — raw asciinema capture.
- `terminal-transcript.txt` — sanitized raw command transcript.
- `artifacts/collection_script.sh` — exact collection commands.
- `artifacts/collection_log.txt` — sanitized raw output from that script,
  including per-file SHA-256 comparisons and retained Gemini mappings.
- `metadata.json`, `run.json`, `methodology.md`, `evidence.md` — provenance and
  claim mapping.
- `checksums.sha256` — integrity manifest for every substantive artifact.

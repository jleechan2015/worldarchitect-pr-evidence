# Evidence review map

## Claim to artifact map

| Claim | Primary artifact | Key field or text |
|---|---|---|
| Exact head and clean capture | `terminal-transcript.txt` | `HEAD`, `WORKTREE_STATUS: CLEAN`, `SHA MATCH` |
| Focused command test passes | `terminal-transcript.txt` | `Passed: 1`, `Failed: 0` |
| Active planexec dependency regression passes | `artifacts/collection_log.txt` | two bounded pointer rows and `PLANEXEC_SOLID_REFS: PASS 2/2` |
| Project skill mirror remains synchronized | `artifacts/collection_log.txt` | `PROJECT_SKILL_SYNC: PASS linked_or_error_lines=0` |
| Deleted regular files match canonical copies | `artifacts/collection_log.txt` | 17 per-file canonical/base SHA-256 rows plus `CANONICAL_BYTES: PASS 17/17` |
| Four repo-local commands remain because Gemini wrappers point to them | `artifacts/collection_log.txt` | four `.gemini/commands/*.toml` mapping rows plus `GEMINI_WRAPPERS: PASS 4/4` |
| Global Codex discovery remains available | `artifacts/collection_log.txt` | two bounded pointer rows plus `GLOBAL_CODEX_DISCOVERY: PASS 2/2` |
| Pinned catalog provisions every removed asset | `artifacts/collection_log.txt` | installer manifest 790 files plus `CATALOG_INSTALL_BYTES: PASS 17/17` |
| Real host discovers catalog commands and skills | `artifacts/claude-init.sanitized.jsonl`, `artifacts/collection_log.txt` | complete sanitized three-event JSONL, `CLAUDE_INIT_RAW: PASS`, and `CATALOG_HOST_DISCOVERY: PASS commands=5/5 skills=2/2 auth=expected-isolated-home-failure` |
| Exact collection commands and raw output are published | `artifacts/collection_script.sh`, `artifacts/collection_log.txt` | script commands, shell trace, raw runner output |

## What this evidence proves

- The named non-production checks passed on the clean PR head.
- The active repo-reference and canonical home `planexec` commands both point
  at the user-scope SOLID skill, and the regression rejects dangling
  project-relative skill dependencies.
- The deleted regular files were byte-identical to the current user-scope
  canonical copies at capture time.
- The four retained command definitions are the exact targets of four
  repo-local Gemini pointer files.
- The two intended global Codex pointers resolved at capture time.
- Pinned `jleechan-skills` revision `41ce34b` installed all removed assets into
  an isolated home with exact matching bytes, and a real Claude host discovered
  the five Spec Kit commands plus both shared skills before the expected
  authentication failure of that clean isolated home. No provider call was
  required for discovery.
- The published sanitized JSONL preserves the complete init, synthetic
  authentication-error assistant event, and result event while removing only
  ephemeral paths and identifiers.

## What this evidence does not prove

- Production deployment or application runtime behavior.
- UI, LLM, Firebase, BigQuery, or cross-browser behavior.
- Availability on machines that do not install the pinned compatible catalog.
- General compatibility with future mutable catalog revisions.
- Future global-copy contents after this timestamp.

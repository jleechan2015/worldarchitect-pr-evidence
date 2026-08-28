# Evidence review map

## Claim to artifact map

| Claim | Primary artifact | Key field or text |
|---|---|---|
| Exact head and clean capture | `terminal-transcript.txt` | `HEAD`, `WORKTREE_STATUS: CLEAN`, `SHA MATCH` |
| Focused command test passes | `terminal-transcript.txt` | `Passed: 1`, `Failed: 0` |
| Project skill mirror remains synchronized | `terminal-transcript.txt` | `LINKED_OR_ERROR_LINES: 0`, `PROJECT_SKILL_SYNC: PASS` |
| Deleted regular files match canonical copies | `artifacts/collection_log.txt` | 17 per-file canonical/base SHA-256 rows plus `CANONICAL_BYTES: PASS 17/17` |
| Four repo-local commands remain because Gemini wrappers point to them | `artifacts/collection_log.txt` | four `.gemini/commands/*.toml` mapping rows plus `GEMINI_WRAPPERS: PASS 4/4` |
| Global Codex discovery remains available | `artifacts/collection_log.txt` | two bounded pointer rows plus `GLOBAL_CODEX_DISCOVERY: PASS 2/2` |
| Exact collection commands and raw output are published | `artifacts/collection_script.sh`, `artifacts/collection_log.txt` | script commands, shell trace, raw runner output |

## What this evidence proves

- The named non-production checks passed on the clean PR head.
- The deleted regular files were byte-identical to the current user-scope
  canonical copies at capture time.
- The four retained command definitions are the exact targets of four
  repo-local Gemini pointer files.
- The two intended global Codex pointers resolved at capture time.

## What this evidence does not prove

- Production deployment or application runtime behavior.
- UI, LLM, Firebase, BigQuery, or cross-browser behavior.
- Availability on a different machine that has not installed the user's
  canonical command/skill catalog.
- Future global-copy contents after this timestamp.

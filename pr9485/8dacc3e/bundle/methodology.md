# Methodology

1. Resolve PR #9485 and record the exact live head.
2. Assert a clean worktree and record branch, merge base, commit log, unified
   diff for the retained cross-reference, and deletion summary.
3. Run `./run_tests.sh .claude/commands/tests/test_compose_commands.py`.
4. Run the project Codex skill synchronizer in dry-run mode and fail if any
   output line starts with `linked` or `error:`.
5. Compare each of the 17 deleted regular files from `origin/main` byte-for-byte
   against its canonical `~/.claude` counterpart, recording both SHA-256 values.
6. Verify the four retained command definitions are direct targets of the
   repo-local `.gemini/commands/*.toml` pointer files.
7. Verify the two bounded global Codex symlinks resolve to readable canonical
   skill entrypoints.
8. Re-read HEAD after all checks and require it to equal the pre-run SHA.
9. Record with asciinema, render GIF and MP4, sanitize the transcript, and
   checksum every published artifact.

Pass criteria are exact: focused test 1/1, sync problem count 0, byte matches
17/17, Gemini wrapper mappings 4/4, discovery 2/2, clean worktree, and
identical pre/post SHA.

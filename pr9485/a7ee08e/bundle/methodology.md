# Methodology

1. Resolve PR #9485 and record the exact live head.
2. Assert a clean worktree and record branch, merge base, commit log, unified
   diff for the retained cross-reference, and deletion summary.
3. Run `./run_tests.sh .claude/commands/tests/test_compose_commands.py`.
4. Verify both active `planexec` copies target the user-scope SOLID skill and
   neither retains the deleted project-relative target.
5. Run the project Codex skill synchronizer in dry-run mode and fail if any
   output line starts with `linked` or `error:`.
6. Compare each of the 17 deleted regular files from `origin/main` byte-for-byte
   against its canonical `~/.claude` counterpart, recording both SHA-256 values.
7. Verify the four retained command definitions are direct targets of the
   repo-local `.gemini/commands/*.toml` pointer files.
8. Verify the two bounded global Codex symlinks resolve to readable canonical
   skill entrypoints.
9. Clone pinned `jleechan-skills` revision `41ce34b`, install it into an
   isolated `CLAUDE_HOME`, and verify all 17 removed assets against both the
   catalog and PR base bytes.
10. Start a real Claude host with the unauthenticated isolated catalog, publish
    its complete three-event JSONL after removing ephemeral paths and
    identifiers, and verify discovery of all five Spec Kit commands plus
    `generalized-testing` and SOLID before the expected auth failure. This
    performs no provider call.
11. Re-read HEAD after all checks and require it to equal the pre-run SHA.
12. Capture the actual collection-script execution with asciinema, retain its
    ANSI-stripped transcript as the authoritative raw log, render GIF and MP4
    from that real execution, and checksum every published artifact.

Pass criteria are exact: focused test 1/1, planexec references 2/2, sync
problem count 0, byte matches 17/17, Gemini wrapper
mappings 4/4, global discovery 2/2, catalog install bytes 17/17, catalog host
discovery 5/5 commands and 2/2 skills, clean worktree, and identical pre/post
SHA.

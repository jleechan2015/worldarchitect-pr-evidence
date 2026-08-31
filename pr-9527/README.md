# WorldArchitect PR #9527 terminal verifier evidence

This directory contains the terminal proof required by the WorldArchitect
evidence-review contract for private PR #9527.

- Evidence-only PR head: `5199061f1d0e50b5b1febc9719ddf6c66967cc6b`
- Functional browser evidence SHA: `5a1c19d58173c6c3cbf9508ed3829ca299471541`
- Command recorded: the published v2 bundle's real `./verify.sh`
- Result: `ALL PR #9527 BUNDLE CHECKS PASSED`, exit code 0

The GIF and MP4 show the real verifier recomputing bundle checksums and checking
raw telemetry, Firestore readback lines, media readability, canonical terminal
writes, and the browser PASS marker. The `.cast` is the source terminal capture.

## SHA-256

```text
2a8b8f7756f5507d27d2a97a7fec2c8d624cc8783adb0e98cce0b9a2a9ef55ef  terminal-bundle-verifier-5199061f.cast
cb1e0c273ed407256709e3054a37cf8807e293393e76358c6aa510de6512fa20  terminal-bundle-verifier-5199061f.gif
ba43d683c88488071ccbd945dcdf1ee51199259dedfa7d490bf2110b13cf69fc  terminal-bundle-verifier-5199061f.mp4
```

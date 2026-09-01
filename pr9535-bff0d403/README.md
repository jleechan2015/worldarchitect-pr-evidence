# PR #9535 exact-head preview UI evidence

This directory is an immutable, public evidence bundle for PR #9535 HEAD
`bff0d403b62614e86b836c9eb5d5ea218b57d23f`.

## What was tested

- Preview: `https://mvp-site-app-s5-i6xf2p72ka-uc.a.run.app`
- Health provenance: `/health` returned `git_commit` equal to the exact PR HEAD
- Route: `/game/8AKkyXsv0RHRrebycvBk`
- Browser: Aside Chromium, signed-in `jleechan@gmail.com` (`u0`)
- Viewport: 393 x 852 CSS pixels
- Flow: real campaign story at top, midpoint scroll action, and bottom scroll
- Result: sticky HUD remained visible above the narrative with 0px overlap in all states

## Media

- `pr9535-hud-scroll-captioned.gif` — browser-viewable 393 x 852 flow
- `pr9535-hud-scroll-captioned.mp4` — high-fidelity captioned flow
- `pr9535_hud_scroll.srt` — matching sidecar captions
- `00.png`, `01.png`, `02.png` — captioned BEFORE/ACTION/AFTER frames
- `metadata.json` — preview, browser, measurement, and assertion provenance
- `checksums.sha256` — SHA-256 checksums for every retained artifact

The burned-in captions identify the route, exact HEAD, authenticated account,
viewport, state, and measured overlap. The first MP4 frame was extracted and
visually inspected before publication; it shows the rendered initial campaign
state rather than a blank/loading frame.

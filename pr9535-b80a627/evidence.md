# PR #9535 exact-head mobile HUD evidence

## Claim

At source head `b80a6276ae2ec629e39e5b2a785c22506872db04`, the mobile game HUD remains fully visible and does not cover story content while the real campaign story scrolls from top to bottom.

## Provenance

- Source repository: `jleechanorg/worldarchitect.ai`
- Source branch: `fix/mobile-back-icon-and-sticky-hud`
- Source commit: `b80a6276ae2ec629e39e5b2a785c22506872db04`
- Exact-head preview: `https://mvp-site-app-s5-i6xf2p72ka-uc.a.run.app`
- Route: `/game/8AKkyXsv0RHRrebycvBk`
- Browser mode: `aside-cli`
- Viewport: `393x852`, device scale factor 2
- Account: real signed-in `jleechan@gmail.com`
- Campaign: real campaign `8AKkyXsv0RHRrebycvBk`
- Synthetic UI state: **no** (`test_mode` was not used; DOM was not replaced or forced visible)

## Claim-to-artifact map

| Claim | Primary artifact | Direct observation |
|---|---|---|
| Story begins below the variable-height HUD | [captioned browser MP4](./hud-scroll-captioned.mp4) / [GIF](./hud-scroll-captioned.gif) | At top, midpoint, and bottom: HUD 45–213.18px; story top 217.18px; overlap 0px |
| HUD stays visible during scrolling | [captioned browser MP4](./hud-scroll-captioned.mp4) | Real 71k-pixel story is traversed while header remains in frame |
| Focused regression contracts pass | [terminal MP4](./mobile-hud-tests-captioned.mp4) / [GIF](./mobile-hud-tests-captioned.gif) / `pytest-output.txt` | `7 passed in 0.23s` |
| Artifact bytes are unchanged | `checksums.sha256` | Recompute with `shasum -a 256 -c checksums.sha256` |

## Browser media

- [Captioned GIF](./hud-scroll-captioned.gif)
- [Captioned MP4](./hud-scroll-captioned.mp4)
- [Downloadable MP4 ZIP](./hud-scroll-captioned.mp4.zip)
- [Caption sidecar](./hud-scroll.srt)

## Terminal media

- [Captioned GIF](./mobile-hud-tests-captioned.gif)
- [Captioned MP4](./mobile-hud-tests-captioned.mp4)
- [Downloadable MP4 ZIP](./mobile-hud-tests-captioned.mp4.zip)
- [Caption sidecar](./mobile-hud-tests.srt)
- Raw recording: `mobile-hud-tests.cast`
- Raw pytest output: `pytest-output.txt`

## Clean-computer reproduction

Prerequisites: Git, Python 3.12, and repository dependencies installed by the repository bootstrap. Firebase credentials are **not** needed for the focused static regression tests. Real browser reproduction requires a permitted WorldAI Google account and access to the PR preview.

```bash
git clone https://github.com/jleechanorg/worldarchitect.ai.git
cd worldarchitect.ai
git checkout b80a6276ae2ec629e39e5b2a785c22506872db04
./vpython -m pytest -q \
  mvp_site/tests/test_mobile_game_view_hud_header.py \
  mvp_site/tests/test_mobile_back_icon.py
```

Expected output:

```text
.......                                                                  [100%]
7 passed
```

For browser reproduction, open the exact preview route at a 393×852 viewport, sign in, and scroll `#story-content` from top to bottom. Expected computed geometry at this capture: header top/bottom `45/213.1796875`, story top `217.1796875`, overlap `0`.

## Scope boundary

This proves the real signed-in mobile layout and the focused static contracts at the exact PR head. It does **not** claim cross-browser coverage beyond Chromium/Aside, backend behavior, or unrelated desktop layout behavior.

First frames of both videos were extracted and manually verified non-blank.

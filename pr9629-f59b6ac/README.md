# PR 9629 exact-head mobile HUD evidence

- PR: https://github.com/jleechanorg/worldarchitect.ai/pull/9629
- Tested head: `f59b6ac2fa3a81abb8f2986ad1126b2cbe974100`
- Preview: `https://mvp-site-app-s12-i6xf2p72ka-uc.a.run.app`
- Browser path: signed-in real campaign `8AKkyXsv0RHRrebycvBk`
- Browser: Aside CLI, authenticated as the existing real test account
- Viewport: 393 x 852 CSS pixels
- Synthetic UI/DOM: none

## Claims demonstrated

1. The HUD remains in one row at the mobile viewport with no horizontal overflow.
2. The title truncates with an ellipsis instead of displacing controls.
3. Campaign Details remains visible and measures 28 x 28 CSS pixels.
4. Spicy remains visibly identified and has the accessible name `Spicy mode`.
5. The sticky HUD does not overlap the story at the top or after deep story scrolling.

The measured header bottom was 97.5859375 px, story top was 101.5859375 px,
and overlap was 0 px. `measurements.json` contains the raw values.

## Artifacts

- `browser-captioned.mp4` and `.gif`: captioned real-browser proof at two story positions.
- `browser-top.png`, `browser-deep-scroll.png`: source browser frames.
- `measurements.json`: runtime DOM geometry and accessibility values.
- `terminal-captioned.mp4` and `.gif`: exact-head focused test recording.
- `terminal.cast`: raw terminal recording.
- `tests.txt`: fresh exact-head test, lint, and diff-check output.
- `SHA256SUMS`: integrity manifest.

## Reproduce

1. Check out `f59b6ac2fa3a81abb8f2986ad1126b2cbe974100`.
2. Run the commands recorded in `tests.txt`.
3. Open the preview URL, sign in through the normal UI, and open campaign
   `8AKkyXsv0RHRrebycvBk` at a 393 x 852 viewport.
4. Inspect the HUD at multiple story scroll positions and compare the geometry
   with `measurements.json`.

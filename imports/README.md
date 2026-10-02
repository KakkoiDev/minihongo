# Compact Echo starter library

Download [jp-echo.json](https://raw.githubusercontent.com/KakkoiDev/minihongo/master/imports/jp-echo.json), or choose **Settings → Your sentences → Import Mini Hongo starter library** in Echo.

Version 2 contains only the main vocabulary list (`data/words.csv`, 231 entries) and all 43 grammar points. Vocabulary uses one word/gloss card per entry. Grammar uses one short authored example per point. Identical targets share one card and retain all links. Advanced vocabulary, compounds, expressions, stories and extra examples are excluded.

Echo repairs the oversized version-1 import on startup, keeping existing personal sentences and reviews and retaining an undo copy. The compact starter is imported separately when wanted; cleanup does not add it automatically. Repeated compact imports do not duplicate cards.

Regenerate: `node scripts/export_echo.mjs`. Validate: `node --test scripts/test_echo_export.mjs` (Node 18+). `imports/jp-core.mjs` remains copied unchanged from JP Core revision ee9bfdb8a5b3fc38903ef6fcbcd50fa65d75bdf3.

Source: Minihongo, https://minihongo.com. CC BY-SA 4.0. The export retains attribution and license. No text, readings or examples are invented.

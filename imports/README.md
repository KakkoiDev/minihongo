# Echo starter library

Download [jp-echo.json](https://raw.githubusercontent.com/KakkoiDev/minihongo/master/imports/jp-echo.json), or use **Settings → Your sentences → Import Mini Hongo starter library** in [Echo](https://echo.kakkoi.dev).

The JSON contains all entries from words, compounds, advanced vocabulary and expressions, their authored examples (where supplied), and every grammar point and grammar example. Entries without source examples retain their original phrase and gloss; no examples or readings are invented. Imports merge with existing sentences and keep review progress. Reimporting does not duplicate identical Japanese sentences.

Regenerate from repository root with `node scripts/export_echo.mjs`. Node 18 or later is required. `jp-core.mjs` is an unchanged copy of JP Core's canonical browser module. Source content: Minihongo (https://minihongo.com), CC BY-SA 4.0. This exported adaptation retains that license and attribution.

Verify with `node --test scripts/test_echo_export.mjs`.

JP Core browser revision: ee9bfdb8a5b3fc38903ef6fcbcd50fa65d75bdf3.

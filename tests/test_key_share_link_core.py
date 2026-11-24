"""Kaiwa invites go through link-core, vendored as site/static/link-core.js.

key-share.js keeps only Kaiwa's choices (the associated data, '#key=', what an
invite must carry). The copy names its source commit and is never edited here:
change KakkoiDev/link-core and bring it over. A link sealed before the switch
must keep opening, and a link sealed for Echo must never open in Kaiwa.
"""
import re
import shutil
import subprocess
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parent.parent
STATIC = ROOT / "site" / "static"

# Sealed by Minihongo's own key-share.js before link-core (24 Nov 2026).
OLD_KAIWA = ("v1.JOuslNBiyepNr7dhrVhJpA.a-Rt4axUVoUkQEFw.u8kgyK5VDpFkyuZC4dGpSi8RS5xqa6AMGsn20Ri51QU3TUlFasaeotjG-anjzW2EWwzC014oR9_-eLUlWCU", "ME8S-TYVQ-HT8T")
# Sealed by Echo: same scheme, another app.
ECHO = ("v1.YoYcqjWDmYHjQiQiOlJlkw.re_mK8lFXNgsWW-2.onbhnLcPu0OIFS3hij3CA4y6wknllAnrcFtBamnvw46OVcNwGgzEKcRuRirycXe220vtM0pNxKav9-XLSsNNmDFGP1rNbwlaGipJlo1_rXxlHHe4n2Ueow", "30KE-7SH2-MRED")


def test_link_core_is_vendored_with_its_source_commit():
    vendored = (STATIC / "link-core.js").read_text()
    assert re.match(r"// Vendored from KakkoiDev/link-core v\d+\.\d+\.\d+ \(commit [0-9a-f]{40}\)", vendored)
    key_share = (STATIC / "key-share.js").read_text()
    assert "const APP = 'minihongo-kaiwa-key-v1'" in key_share, "Kaiwa's associated data never changes"
    assert "./link-core.js?v={{CACHE_HASH}}" in key_share, "versioned like every other module"
    assert "'static/link-core.js'" in (ROOT / "site" / "build.py").read_text(), "precached for offline"


@pytest.mark.skipif(not shutil.which("node"), reason="needs node")
def test_old_kaiwa_invites_open_and_echo_links_do_not(tmp_path):
    for name in ("link-core.js", "key-share.js"):
        (tmp_path / name).write_text((STATIC / name).read_text().replace("{{CACHE_HASH}}", "test"))
    script = f"""
globalThis.window = globalThis; globalThis.location = {{hash: ''}};
await import({str(tmp_path / 'key-share.js')!r});
const ks = window.MinihongoKeyShare;
const old = await ks.openKey({OLD_KAIWA[0]!r}, {OLD_KAIWA[1]!r});
const fresh = await ks.sealKey({{provider: 'anthropic', key: 'k'}}, 7);
const opened = await ks.openKey(fresh.token, fresh.code.toLowerCase());
const echo = await ks.openKey({ECHO[0]!r}, {ECHO[1]!r}).then(() => 'opened', e => e.code);
console.log(JSON.stringify([old.key, opened.key, echo]));
"""
    out = subprocess.run(["node", "--input-type=module", "-e", script], capture_output=True, text=True, check=True)
    assert out.stdout.strip() == '["mh-fixture","k","wrong-code"]'

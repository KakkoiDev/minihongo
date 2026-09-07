"""Regression guards for the dependency-free mobile Kaiwa microphone UI."""
from pathlib import Path


KAIWA = (Path(__file__).parent.parent / "site/static/kaiwa.js").read_text()


def test_speech_support_uses_capability_detection_not_browser_brand():
    assert "window.SpeechRecognition || window.webkitSpeechRecognition" in KAIWA
    assert "isBraveBrowser" not in KAIWA


def test_transcription_service_error_does_not_remove_microphone():
    error_branch = KAIWA.split("event.error === 'network'", 1)[1].split(
        "} else {", 1
    )[0]
    assert "micBtn.hidden = true" not in error_branch
    assert "textForm.hidden = false" in error_branch


def test_mobile_microphone_remains_the_primary_full_width_control():
    css = (Path(__file__).parent.parent / "site/static/style.css").read_text()
    mobile = css.split("@media (max-width: 600px)", 1)[1]
    mic_rule = mobile.split(".kaiwa-composer #kaiwa-mic", 1)[1].split("}", 1)[0]
    assert "width: 100%" in mic_rule


def test_mobile_speak_explicitly_requests_microphone_permission():
    assert "navigator.mediaDevices?.getUserMedia" in KAIWA
    assert "getUserMedia({ audio: true })" in KAIWA
    assert "stream.getTracks().forEach(track => track.stop())" in KAIWA
    assert "await requestMicPermission()" in KAIWA


def test_permission_help_button_is_shown_when_microphone_is_not_granted():
    assert 'id="kaiwa-permission"' in KAIWA
    assert "${opts.hasRecognition ? '' : 'hidden'}>Enable microphone" in KAIWA
    assert "permissionBtn.hidden = false" in KAIWA
    assert "navigator.permissions?.query({ name: 'microphone' })" in KAIWA
    assert "permissionBtn.addEventListener('click', () => beginListening())" in KAIWA


def test_permission_query_does_not_skip_real_microphone_check():
    permission_ui = KAIWA.split("const updatePermissionUi = () =>", 1)[1].split("}", 1)[0]
    assert "micPermissionReady = permission.state === 'granted'" not in permission_ui
    assert "if (permission.state !== 'granted') micPermissionReady = false" in permission_ui

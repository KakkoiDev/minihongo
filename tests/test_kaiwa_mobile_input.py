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


def test_microphone_failures_show_device_help_and_keyboard_fallback():
    assert 'id="kaiwa-mic-help"' in KAIWA
    assert "Android Settings → Apps → Chrome → Permissions" in KAIWA
    assert "Google Speech Services" in KAIWA
    assert 'id="kaiwa-text-form">' in KAIWA
    assert "Type, or use your keyboard microphone" in KAIWA


def test_permission_control_is_available_before_permissions_api_resolves():
    button = KAIWA.split('id="kaiwa-permission"', 1)[1].split("</button>", 1)[0]
    assert "opts.hasRecognition" in button
    assert "Enable microphone" in button


def test_successful_device_check_releases_stream_and_hides_permission_control():
    success = KAIWA.split("getUserMedia({ audio: true })", 1)[1].split("} catch", 1)[0]
    assert "stream.getTracks().forEach(track => track.stop())" in success
    assert "micPermissionReady = true" in success
    assert "permissionBtn.hidden = true" in success


def test_failed_device_check_keeps_recovery_controls_visible():
    failure = KAIWA.split("} catch (error) {", 1)[1].split("} finally", 1)[0]
    assert "permissionBtn.hidden = false" in failure
    assert "micHelp.hidden = false" in failure
    assert "micHelp.open = true" in failure
    assert "retryBtn.hidden = false" in failure


def test_device_errors_have_actionable_diagnostics():
    for error_name in (
        "NotAllowedError",
        "NotFoundError",
        "NotReadableError",
        "SecurityError",
    ):
        assert error_name in KAIWA


def test_recognition_permission_failure_opens_help():
    branch = KAIWA.split("event.error === 'not-allowed'", 1)[1].split(
        "} else if", 1
    )[0]
    assert "permissionBtn.hidden = false" in branch
    assert "micHelp.hidden = false" in branch
    assert "micHelp.open = true" in branch


def test_speech_service_failure_preserves_both_input_methods():
    branch = KAIWA.split("event.error === 'network'", 1)[1].split(
        "} else {", 1
    )[0]
    assert "micBtn.hidden = true" not in branch
    assert "textForm.hidden = false" in branch
    assert "micHelp.hidden = false" in branch
    assert "keyboard microphone" in branch


def test_permissions_api_is_optional_and_cannot_break_session_setup():
    assert "navigator.permissions?.query" in KAIWA
    assert ").catch(() => {})" in KAIWA


def test_text_input_is_never_hidden_when_speech_recognition_exists():
    form = KAIWA.split('<form id="kaiwa-text-form"', 1)[1].split(">", 1)[0]
    assert "opts.hasRecognition" not in form
    assert "hidden" not in form

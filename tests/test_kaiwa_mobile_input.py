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
    assert "await requestMicPermission(true)" in KAIWA


def test_permission_help_button_is_shown_when_microphone_is_not_granted():
    assert 'id="kaiwa-permission"' in KAIWA
    assert "opts.hasRecognition || (opts.hasRecording && opts.speechApiKey)" in KAIWA
    assert "permissionBtn.hidden = false" in KAIWA
    assert "navigator.permissions?.query({ name: 'microphone' })" in KAIWA
    assert "permissionBtn.addEventListener('click', () =>" in KAIWA


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
    permission_request = KAIWA.split("const requestMicPermission", 1)[1]
    success = permission_request.split("getUserMedia({ audio: true })", 1)[1].split("} catch", 1)[0]
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


def test_reliable_voice_uses_media_recorder_instead_of_browser_recognition():
    assert "new MediaRecorder(recordingStream)" in KAIWA
    assert "mediaRecorder.start()" in KAIWA
    assert "useApiRecording = !!opts.speechApiKey && 'MediaRecorder' in window" in KAIWA
    reliable_branch = KAIWA.split("if (useApiRecording)", 1)[1]
    assert "await beginApiRecording(permission)" in reliable_branch


def test_recording_is_sent_to_groq_whisper_as_japanese():
    assert "https://api.groq.com/openai/v1/audio/transcriptions" in KAIWA
    assert "whisper-large-v3-turbo" in KAIWA
    assert "form.append('language', 'ja')" in KAIWA
    assert "form.append('file', blob" in KAIWA


def test_audio_stream_is_stopped_after_recording():
    finish = KAIWA.split("const finishListening", 1)[1].split(
        "const transcribeRecording", 1
    )[0]
    assert "recordingStream?.getTracks().forEach(track => track.stop())" in finish


def test_recording_has_a_maximum_duration():
    assert "if (mediaRecorder?.state === 'recording') mediaRecorder.stop()" in KAIWA
    assert "}, LISTEN_WINDOW_MS)" in KAIWA


def test_stop_button_stops_media_recorder_before_browser_recognizer():
    click = KAIWA.split("micBtn?.addEventListener('click'", 1)[1].split(
        "permissionBtn.addEventListener", 1
    )[0]
    assert click.index("mediaRecorder.stop()") < click.index("recognizer?.stop()")


def test_groq_speech_key_is_device_local_and_independent_from_chat_provider():
    assert "KAIWA_SPEECH_KEY_STORAGE = 'kaiwa_key_groq_speech'" in KAIWA
    assert 'id="kaiwa-speech-key"' in KAIWA
    assert "localStorage.setItem(KAIWA_SPEECH_KEY_STORAGE, speechApiKey)" in KAIWA
    assert "providerId, apiKey, speechApiKey" in KAIWA


def test_media_recorder_allows_voice_when_web_speech_is_missing():
    assert "hasRecording = !!navigator.mediaDevices?.getUserMedia && 'MediaRecorder' in window" in KAIWA
    mic_button = KAIWA.split('id="kaiwa-mic"', 1)[1].split("</button>", 1)[0]
    assert "opts.hasRecording && opts.speechApiKey" in mic_button


def test_transcription_failures_keep_retry_and_help_available():
    stop_handler = KAIWA.split("mediaRecorder.addEventListener('stop'", 1)[1].split(
        "}, { once: true })", 1
    )[0]
    assert "retryBtn.hidden = false" in stop_handler
    assert "micHelp.hidden = false" in stop_handler


def test_recording_reuses_permission_stream_without_green_mic_flash():
    assert "const requestMicPermission = async (keepStream = false)" in KAIWA
    assert "return keepStream ? stream : true" in KAIWA
    recorder_start = KAIWA.split("const beginApiRecording", 1)[1].split(
        "const startRecognizer", 1
    )[0]
    assert "recordingStream = openStream" in recorder_start
    assert "getUserMedia({ audio: true })" not in recorder_start


def test_recording_stream_stays_open_until_media_recorder_stops():
    permission_success = KAIWA.split("const requestMicPermission", 1)[1].split(
        "} catch (error)", 1
    )[0]
    assert "if (!keepStream) stream.getTracks().forEach(track => track.stop())" in permission_success
    stop_handler = KAIWA.split("mediaRecorder.addEventListener('stop'", 1)[1].split(
        "}, { once: true })", 1
    )[0]
    assert "finishListening()" in stop_handler


def test_browser_speech_path_keeps_permission_stream_for_whole_turn():
    begin = KAIWA.split("const beginListening", 1)[1].split(
        "const setupRecognition", 1
    )[0]
    assert "await requestMicPermission(true)" in begin
    assert "recordingStream = permission" in begin
    assert begin.index("recordingStream = permission") < begin.index("startRecognizer()")


def test_chrome_receives_the_open_microphone_track_directly():
    start = KAIWA.split("const startRecognizer", 1)[1].split(
        "const requestMicPermission", 1
    )[0]
    assert "recordingStream?.getAudioTracks?.()[0]" in start
    assert "recognizer.start(audioTrack)" in start


def test_older_chrome_falls_back_when_track_argument_is_unsupported():
    start = KAIWA.split("const startRecognizer", 1)[1].split(
        "const requestMicPermission", 1
    )[0]
    assert "trackError?.name !== 'TypeError'" in start
    assert start.count("recognizer.start()") >= 2


def test_mobile_chrome_recognition_stays_continuous_until_explicit_stop():
    setup = KAIWA.split("const setupRecognition", 1)[1].split(
        "r.onresult", 1
    )[0]
    assert "r.continuous = true" in setup
    result = KAIWA.split("r.onresult", 1)[1].split("r.onerror", 1)[0]
    assert "if (finalText)" in result
    assert "r.stop()" in result


def test_denied_permission_button_opens_help_instead_of_reprompting():
    click = KAIWA.split("permissionBtn.addEventListener('click'", 1)[1].split(
        "navigator.permissions?.query", 1
    )[0]
    assert "micPermissionState === 'denied'" in click
    assert "micHelp.open = true" in click
    assert "micHelp.scrollIntoView" in click
    assert click.index("return") < click.index("beginListening()")


def test_denied_permission_has_clear_recovery_label():
    assert "Microphone blocked — how to allow" in KAIWA
    assert "Chrome will not ask again after Block was selected" in KAIWA


def test_permission_state_changes_update_recovery_button():
    permission_ui = KAIWA.split("const updatePermissionUi = () =>", 1)[1].split(
        "permission.addEventListener", 1
    )[0]
    assert "micPermissionState = permission.state" in permission_ui
    assert "permission.state === 'denied'" in permission_ui
    assert "permissionBtn.hidden = permission.state === 'granted'" in permission_ui

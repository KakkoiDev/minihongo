.PHONY: build serve watch _rebuild lint-haiku lint-vocab audio audio-download audio-release anki anki-download anki-release

PORT ?= 3000

build:
	python3 generate_pages.py
	python3 site/build.py

serve: build
	python3 -m http.server $(PORT) -d docs

watch: build
	@python3 -m http.server $(PORT) -d docs & \
	SERVER_PID=$$!; \
	cleanup() { kill $$SERVER_PID 2>/dev/null; rm -f .server.pid; exit 0; }; \
	trap cleanup INT TERM; \
	echo $$SERVER_PID > .server.pid; \
	echo "Server running on http://localhost:$(PORT) (PID $$SERVER_PID)"; \
	while find site data \( -name '*.html' -o -name '*.css' -o -name '*.js' -o -name '*.csv' -o -name '*.py' \) | entr -d $(MAKE) _rebuild; do :; done; \
	cleanup

_rebuild:
	python3 generate_pages.py
	python3 site/build.py

# -- Lint --------------------------------------------------------------------

lint-haiku:
	python3 validate_haiku.py

lint-vocab:
	python3 validate_vocab.py

# -- Audio -------------------------------------------------------------------

# Generate all audio (requires edge-tts + ffmpeg)
audio:
	python3 generate_audio.py

# Download audio from GitHub release into audio/
audio-download:
	@mkdir -p audio
	gh release download audio --pattern '*.tar.gz' --dir /tmp --clobber
	tar xzf /tmp/minihongo-audio*.tar.gz -C audio/
	@echo "Audio downloaded to audio/"

# Package and upload audio (single release, replaces previous)
audio-release:
	@test -d audio || { echo "No audio/ directory. Run 'make audio' first."; exit 1; }
	cd audio && tar czf /tmp/minihongo-audio.tar.gz .
	@echo "Packaged $$(find audio -name '*.mp3' | wc -l) files ($$(du -sh /tmp/minihongo-audio.tar.gz | cut -f1))"
	-gh release delete audio --yes --cleanup-tag 2>/dev/null
	gh release create audio /tmp/minihongo-audio.tar.gz \
		--title "Audio" \
		--notes "$$(git log -5 --oneline)"

# -- Anki -------------------------------------------------------------------

# Download Anki decks from GitHub release
anki-download:
	gh release download anki --pattern '*.apkg' --dir . --clobber
	@echo "Anki decks downloaded"

# Build Anki decks for all languages (requires genanki + audio/)
anki:
	python3 generate_anki.py

# Upload Anki decks (single release, replaces previous)
anki-release: anki
	@echo "Decks: $$(du -sh minihongo-*.apkg | cut -f1 | paste -sd+ | bc)B total"
	-gh release delete anki --yes --cleanup-tag 2>/dev/null
	gh release create anki minihongo-*.apkg \
		--title "Anki" \
		--notes "$$(git log -5 --oneline)"

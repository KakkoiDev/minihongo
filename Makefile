.PHONY: build serve watch _rebuild audio audio-download audio-release anki anki-release

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

# -- Audio -------------------------------------------------------------------

# Generate all audio (requires edge-tts + ffmpeg)
audio:
	python3 generate_audio.py

# Download audio from latest audio-v* GitHub release into audio/
audio-download:
	$(eval TAG := $(shell gh release list --json tagName -q '[.[].tagName | select(startswith("audio-v"))] | first'))
	@echo "Downloading audio from release: $(TAG)"
	@mkdir -p audio
	gh release download $(TAG) -p '*.tar.gz' -D /tmp --clobber
	tar xzf /tmp/minihongo-audio*.tar.gz -C audio/
	@echo "Audio downloaded to audio/"

# Package and upload audio as a new GitHub release
audio-release:
	@test -d audio || { echo "No audio/ directory. Run 'make audio' first."; exit 1; }
	cd audio && tar czf /tmp/minihongo-audio.tar.gz .
	@echo "Packaged $$(ls audio/**/*.mp3 | wc -l) files ($$(du -sh /tmp/minihongo-audio.tar.gz | cut -f1))"
	@echo "Upload with: gh release create audio-vN /tmp/minihongo-audio.tar.gz --title 'Audio vN'"

# -- Anki -------------------------------------------------------------------

# Build Anki decks for all languages (requires genanki + audio/)
anki:
	python3 generate_anki.py

# Upload Anki decks as a new GitHub release
anki-release: anki
	@echo "Decks: $$(du -sh minihongo-*.apkg | cut -f1 | paste -sd+ | bc)B total"
	@echo "Upload with: gh release create anki-vN minihongo-*.apkg --title 'Anki vN'"

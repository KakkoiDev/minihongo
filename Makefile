.PHONY: build serve watch _rebuild audio audio-download audio-release

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

# Download audio from latest GitHub release into audio/
audio-download:
	@mkdir -p audio
	gh release download audio-v2 -R KakkoiDev/minihongo -p '*.tar.gz' -D /tmp --clobber
	tar xzf /tmp/minihongo-audio-*.tar.gz -C audio/
	@echo "Audio downloaded to audio/"

# Package and upload audio as a new GitHub release
audio-release:
	@test -d audio || { echo "No audio/ directory. Run 'make audio' first."; exit 1; }
	cd audio && tar czf /tmp/minihongo-audio.tar.gz .
	@echo "Packaged $$(ls audio/**/*.mp3 | wc -l) files ($$(du -sh /tmp/minihongo-audio.tar.gz | cut -f1))"
	@echo "Upload with: gh release create audio-vN /tmp/minihongo-audio.tar.gz --title 'Audio vN'"

.PHONY: build serve watch _rebuild lint-haiku lint-vocab freshness audio audio-download audio-release anki anki-restyle anki-download anki-release pdf pdf-download pdf-release pdf-print deploy

PORT ?= 3000

build: lint-vocab
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

# Fail if a published release (Anki/PDF) no longer matches its source CSVs.
# validate_vocab.py also reports this non-fatally on every build.
freshness:
	python3 validate_vocab.py --check-freshness

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
	sh scripts/publish-release.sh audio "Audio" /tmp/minihongo-audio.tar.gz
	python3 validate_vocab.py --write-manifest audio

# -- Anki -------------------------------------------------------------------

# Download Anki decks from GitHub release
anki-download:
	gh release download anki --pattern '*.apkg' --dir . --clobber
	@echo "Anki decks downloaded"

# Core decks only. The expressions deck is FROZEN (see BUILD_EXPRESSION_DECKS in
# generate_anki.py) - release targets list the 3 core decks explicitly so a stale
# on-disk minihongo-*-expressions.apkg can never be re-globbed and re-uploaded.
CORE_DECKS = minihongo-en.apkg minihongo-ja.apkg minihongo-mh.apkg

# Build Anki decks for all languages (requires genanki + audio/)
anki:
	python3 generate_anki.py

# Build with forced new model IDs and release (use when CSS changes, resets progress)
anki-restyle:
	python3 generate_anki.py --force-style
	@echo "Decks: $$(du -sh $(CORE_DECKS) | cut -f1 | paste -sd+ | bc)B total"
	sh scripts/publish-release.sh anki "Anki" $(CORE_DECKS)
	python3 validate_vocab.py --write-manifest anki

# Upload Anki decks (single release, replaces previous)
anki-release: anki
	@echo "Decks: $$(du -sh $(CORE_DECKS) | cut -f1 | paste -sd+ | bc)B total"
	sh scripts/publish-release.sh anki "Anki" $(CORE_DECKS)
	python3 validate_vocab.py --write-manifest anki

# -- PDF Books ---------------------------------------------------------------

# Generate PDF books for all languages (requires typst + uv)
# Word Building chapter is on by default (WORD_BUILDING in generate_pdf.py)
pdf:
	uv run generate_pdf.py

# Generate print-ready PDFs: interior + wraparound cover (for Lulu)
pdf-print:
	uv run generate_pdf.py --print

# Download PDF books from GitHub release
pdf-download:
	gh release download pdf --pattern '*.zip' --dir /tmp --clobber
	unzip -o /tmp/minihongo-books.zip -d .
	@echo "PDF books downloaded"

# Build, zip, and upload PDFs (single release, replaces previous)
pdf-release: pdf
	zip minihongo-books.zip minihongo-en.pdf minihongo-ja.pdf minihongo-mh.pdf
	@echo "Books: $$(du -sh minihongo-books.zip | cut -f1)"
	sh scripts/publish-release.sh pdf "PDF Books" minihongo-books.zip
	python3 validate_vocab.py --write-manifest pdf

# -- Deploy ------------------------------------------------------------------

deploy:
	gh workflow run deploy.yml
	@echo "Deploy triggered. Watch: gh run watch"

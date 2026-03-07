.PHONY: build serve watch _rebuild

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

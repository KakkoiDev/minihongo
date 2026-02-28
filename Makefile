.PHONY: build serve watch

build:
	python3 generate_pages.py
	python3 site/build.py

serve: build
	python3 -m http.server 3000 -d docs

watch: build
	python3 -m http.server 3000 -d docs & echo $$! > .server.pid; \
	trap 'kill $$(cat .server.pid) 2>/dev/null; rm -f .server.pid' EXIT; \
	while find site data -name '*.html' -o -name '*.css' -o -name '*.js' -o -name '*.csv' | entr -d $(MAKE) _rebuild; do :; done

_rebuild:
	python3 generate_pages.py
	python3 site/build.py

.PHONY: build serve watch

build:
	python3 site/build.py

serve: build
	python3 -m http.server 3000 -d docs

watch: build
	python3 -m http.server 3000 -d docs &
	while find site -name '*.html' -o -name '*.css' -o -name '*.js' | entr -d python3 site/build.py; do :; done

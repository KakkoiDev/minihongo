.PHONY: build serve watch

build:
	python3 generate_pages.py
	python3 site/build.py

serve: build
	python3 -m http.server 3000 -d docs

watch: build
	python3 -m http.server 3000 -d docs &
	while find site data -name '*.html' -o -name '*.css' -o -name '*.js' -o -name '*.csv' | entr -d make build; do :; done

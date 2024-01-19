install:
	cargo install mdbook

sync:
	chmod +x sync.sh
    ./sync.sh

serve:
	mdbook serve -p 8000 -n 127.0.0.1

build:
	mdbook build



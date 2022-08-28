clean:
	@rm -rf ./src
	@rm -rf ./pkg/
	@rm -f honeygain-manager*.zst

compile: clean
	@makepkg -fc

uninstall:
	@sudo pacman -Rdc honeygain-manager --noconfirm

install: clean compile
	@sudo pacman -U honeygain-manager*.zst --noconfirm

.PHONY: clean compile uninstall install

uninstall:
	@sudo pacman -Rdc honeygain-manager

install:
	@makepkg -fc
	@sudo pacman -U honeygain-manager*.zst --noconfirm
	@rm -f honeygain-manager*.zst

.PHONY: install uninstall

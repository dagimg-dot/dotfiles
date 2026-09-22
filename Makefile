HOST := $(shell uname -n)

# Map hostname to machine variant for host-specific packages
ifeq ($(HOST),alarm)
MACHINE := asahi
else
MACHINE := x86
endif

USER_PKGS := atuin fish ghostty kitty niri noctalia nvim starship tmux vscodium

.PHONY: install stow keyd restow

install: stow keyd

stow:
	stow -d . -t $(HOME) $(USER_PKGS)

restow:
	stow -d . -t $(HOME) -R $(USER_PKGS)

# keyd needs root and a machine-specific package; clear a plain-file
# install from before stow ownership so the symlink can be created
keyd:
	@if [ -e /etc/keyd/default.conf ] && [ ! -L /etc/keyd/default.conf ]; then \
		sudo rm /etc/keyd/default.conf; \
	fi
	sudo stow -d . -t / keyd-$(MACHINE)

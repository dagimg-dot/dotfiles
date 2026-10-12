HOST := $(shell uname -n)

# Map hostname to machine variant for host-specific packages
ifeq ($(HOST),alarm)
MACHINE := asahi
else
MACHINE := x86
endif

USER_PKGS := atuin fish ghostty kitty niri noctalia nvim starship tmux vscodium

.PHONY: install stow keyd restow vscodium-ext-dump vscodium-ext-install

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

# Snapshot installed extensions (id@version, sorted) into the repo
vscodium-ext-dump:
	codium --list-extensions --show-versions | sort > vscodium/extensions.txt

# Idempotent install: vendored vsix first, then Open VSX by id@version.
# Missing-only by default; FORCE=1 updates everything already installed.
vscodium-ext-install:
	@installed=$$(codium --list-extensions); \
	while IFS= read -r line; do \
		[ -z "$$line" ] && continue; \
		id=$${line%@*}; \
		if echo "$$installed" | grep -qxF "$$id"; then \
			[ -n "$$FORCE" ] && echo "update $$line" || continue; \
		fi; \
		vsix=$$(ls vscodium/vsix/$$id-*.vsix 2>/dev/null | head -1); \
		if [ -n "$$vsix" ]; then \
			echo "install (vsix) $$id"; \
			codium --install-extension "$$vsix" $(if $(FORCE),--force,) || exit 1; \
		else \
			echo "install $$line"; \
			codium --install-extension "$$line" $(if $(FORCE),--force,) || exit 1; \
		fi; \
	done < vscodium/extensions.txt

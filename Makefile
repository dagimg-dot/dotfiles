HOST := $(shell uname -n)

# Map hostname to machine variant for host-specific packages
ifeq ($(HOST),alarm)
MACHINE := asahi
else
MACHINE := x86
endif

OS := $(shell uname -s)

# VSCodium on macOS reads its User dir from Application Support, not ~/.config
VSCODIUM_USER := $(HOME)/Library/Application Support/VSCodium/User
FISH := /opt/homebrew/bin/fish

ifeq ($(OS),Darwin)
# A fresh Mac has no brew shellenv yet, so put Homebrew on PATH for recipes
export PATH := /opt/homebrew/bin:/opt/homebrew/sbin:$(PATH)
USER_PKGS := atuin fish ghostty nvim starship tmux
# fisher rewrites the plugin files it installs, which would replace the
# symlinks with plain files, so leave those to fisher instead of stow
STOW_FLAGS := --ignore='fisher\.fish' --ignore='nr\.fish'
else
USER_PKGS := atuin fish ghostty kitty niri noctalia nvim starship tmux vscodium
endif

.PHONY: install stow keyd restow brew docker vscodium vscodium-ext-dump vscodium-ext-install shell

ifeq ($(OS),Darwin)
install: brew stow docker vscodium vscodium-ext-install shell
else
install: stow keyd
endif

brew:
	@command -v brew >/dev/null || { echo "Install Homebrew first: https://brew.sh"; exit 1; }
	brew bundle --no-upgrade --file=Brewfile

stow:
	stow -d . -t $(HOME) $(STOW_FLAGS) $(USER_PKGS)

restow:
	stow -d . -t $(HOME) $(STOW_FLAGS) -R $(USER_PKGS)

# keyd needs root and a machine-specific package; clear a plain-file
# install from before stow ownership so the symlink can be created
keyd:
	@if [ -e /etc/keyd/default.conf ] && [ ! -L /etc/keyd/default.conf ]; then \
		sudo rm /etc/keyd/default.conf; \
	fi
	sudo stow -d . -t / keyd-$(MACHINE)

# Docker runs on colima; point the CLI at Homebrew's compose and buildx
# plugins, which brew installs outside the CLI's default plugin dir
docker:
	@mkdir -p $(HOME)/.docker/cli-plugins
	@for p in docker-compose docker-buildx; do \
		ln -sfn /opt/homebrew/lib/docker/cli-plugins/$$p $(HOME)/.docker/cli-plugins/$$p; \
	done
	@echo "linked docker-compose and docker-buildx"

# Link settings and keybindings into VSCodium's macOS User dir, moving any
# plain files there to the Trash first
vscodium:
	@mkdir -p "$(VSCODIUM_USER)"
	@for f in settings.json keybindings.json; do \
		dst="$(VSCODIUM_USER)/$$f"; \
		if [ -e "$$dst" ] && [ ! -L "$$dst" ]; then /usr/bin/trash "$$dst"; fi; \
		ln -sfn "$(CURDIR)/vscodium/.config/VSCodium/User/$$f" "$$dst"; \
		echo "link $$dst"; \
	done

# Make Homebrew fish the login shell and install fisher plugins
shell:
	@grep -qxF "$(FISH)" /etc/shells || echo "$(FISH)" | sudo tee -a /etc/shells >/dev/null
	@[ "$$(dscl . -read $(HOME) UserShell | awk '{print $$2}')" = "$(FISH)" ] || chsh -s "$(FISH)"
	$(FISH) -c "source $(CURDIR)/fish/.config/fish/functions/fisher.fish; fisher update"

# Snapshot installed extensions (id@version, sorted) into the repo
vscodium-ext-dump:
	codium --list-extensions --show-versions | sort > vscodium/extensions.txt

# Idempotent install: vendored vsix first, then Open VSX by id@version.
# Missing-only by default; FORCE=1 updates everything already installed.
# A failed extension is reported at the end instead of stopping the rest.
vscodium-ext-install:
	@installed=$$(codium --list-extensions); failed=""; \
	while IFS= read -r line; do \
		[ -z "$$line" ] && continue; \
		id=$${line%@*}; \
		if echo "$$installed" | grep -qxF "$$id"; then \
			[ -n "$$FORCE" ] && echo "update $$line" || continue; \
		fi; \
		vsix=$$(ls vscodium/vsix/$$id-*.vsix 2>/dev/null | head -1); \
		if [ -n "$$vsix" ]; then \
			echo "install (vsix) $$id"; \
			codium --install-extension "$$vsix" $(if $(FORCE),--force,) || failed="$$failed $$id"; \
		else \
			echo "install $$line"; \
			codium --install-extension "$$line" $(if $(FORCE),--force,) || failed="$$failed $$id"; \
		fi; \
	done < vscodium/extensions.txt; \
	if [ -n "$$failed" ]; then echo "failed:$$failed"; exit 1; fi

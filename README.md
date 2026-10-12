# My Dotfiles

Configs are [GNU Stow](https://www.gnu.org/software/stow/) packages: each
top-level directory mirrors `$HOME`. The `main` branch is the Linux setup and
the `macos` branch carries the macOS versions of fish, ghostty and tmux.

## New Mac

1. Install Homebrew from https://brew.sh. This also installs the Xcode command
   line tools, which provide `git` and `make`.
2. Clone the `macos` branch and run the installer:

   ```sh
   git clone -b macos https://github.com/dagimg-dot/dotfiles ~/dotfiles
   cd ~/dotfiles
   make install
   ```

`make install` on macOS:

- installs everything in `Brewfile`
- stows `atuin fish ghostty nvim starship tmux` into `$HOME`
- links VSCodium's `settings.json` and `keybindings.json` into
  `~/Library/Application Support/VSCodium/User`
- installs the VSCodium extensions pinned in `vscodium/extensions.txt`
- makes Homebrew fish the login shell (asks for your password) and runs
  `fisher update`

Every step can be run again safely. tmux plugins install themselves on the
first tmux start.

Docker runs on colima. Create the VM once; the settings are saved for later
starts. Public DNS is needed because colima's built-in resolver fails on some
registry hosts, and Rosetta runs amd64 images far faster than QEMU emulation:

```sh
colima start --vm-type vz --vz-rosetta --memory 6 --dns 1.1.1.1 --dns 8.8.8.8
```

## Linux

```sh
git clone https://github.com/dagimg-dot/dotfiles ~/dotfiles
cd ~/dotfiles
make install
```

This stows the user packages and the keyd package for the current machine.

## Pulling Linux changes into macOS

On the `macos` branch:

```sh
git pull --no-rebase origin main
```

Conflicts in fish, ghostty and tmux are expected; keep the macOS side.

## Other targets

| Target | What it does |
| --- | --- |
| `make restow` | Re-link all user packages |
| `make vscodium-ext-dump` | Write installed VSCodium extensions to `extensions.txt` |
| `make vscodium-ext-install` | Install missing extensions; `FORCE=1` updates all |
| `make brew` | Install the `Brewfile` (macOS) |

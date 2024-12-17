# damacus/dotfiles-nix

## First run

```bash
sh <(curl -L https://nixos.org/nix/install)
echo "experimental-features = nix-command flakes">~/.config/nix/nix.conf
```

On macOS, install homebrew too:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Also make sure the terminal being used has full disk access, otherwise you might
get errors like `Could not write domain`.

## Layout

Support for Linux and MacOS is provided. See the `modules` folder for the
configuration files.

User name is `damacus` for MacOS and `u.7862791-1` for Linux.

Home-manager is for managing the configuration of the system.

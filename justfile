build:
  sudo nixos-rebuild switch --flake .#linux

build-wsl:
  sudo nixos-rebuild switch --flake .#wsl

build:
  nix flake update && sudo nixos-rebuild switch --flake .#linux

build-wsl:
  nix flake update && sudo nixos-rebuild switch --flake .#wsl

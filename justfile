build-loq:
  sudo nixos-rebuild switch --flake .#loqnux

build-wsl:
  sudo nixos-rebuild switch --flake .#wsl

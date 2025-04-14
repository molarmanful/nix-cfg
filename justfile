build-loq:
  sudo nixos-rebuild switch --flake .#loqnux

build-loq-boot:
  sudo nixos-rebuild boot --flake .#loqnux

build-wsl:
  sudo nixos-rebuild switch --flake .#wsl

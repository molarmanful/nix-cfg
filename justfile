build-loq:
  sudo nixos-rebuild switch --flake .#loqnux

build-loq-boot:
  sudo nixos-rebuild boot --flake .#loqnux

build-ifw:
  sudo nixos-rebuild switch --flake .#ifwit

build-ifw-boot:
  sudo nixos-rebuild boot --flake .#ifwit

build-wsl:
  sudo nixos-rebuild switch --flake .#wsl

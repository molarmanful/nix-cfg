build-ifw:
  sudo nixos-rebuild switch --flake .#ifwit

build-ifw-boot:
  sudo nixos-rebuild boot --flake .#ifwit

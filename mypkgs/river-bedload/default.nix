{
  stdenv,
  fetchFromSourcehut,
  callPackage,
  zig_0_14,
  wayland,
  wayland-protocols,
  wayland-scanner,
  pkg-config,
  tree,
  ...
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "river-bedload";
  version = "4a2855ca2669372c346975dd6e1f612ca563b131";

  src = fetchFromSourcehut {
    owner = "~novakane";
    repo = "river-bedload";
    rev = finalAttrs.version;
    fetchSubmodules = true;
    hash = "sha256-CQH2LQi2ga4YDD2ZYb998ExDJHK4TGHq5h3z94703Dc=";
  };

  deps = callPackage ./build.zig.zon.nix { zig = zig_0_14; };

  nativeBuildInputs = [
    pkg-config
    wayland
    wayland-protocols
    wayland-scanner
    zig_0_14.hook
  ];

  zigBuildFlags = [
    "--system"
    "${finalAttrs.deps}"
  ];

  postInstall = ''
    ${tree}/bin/tree
  '';
})

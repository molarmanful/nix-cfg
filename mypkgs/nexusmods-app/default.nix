{
  appimageTools,
  fetchurl,
  _7zz-rar,
}:
let
  pname = "nexusmods-app";
  version = "0.20.2";
in
appimageTools.wrapType2 {
  inherit pname version;
  src = fetchurl {
    url = "https://github.com/Nexus-Mods/NexusMods.App/releases/download/v${version}/NexusMods.App.x86_64.AppImage";
    hash = "sha256-4f4qEI94uSgMolNyPudCklyZMTe4ZFWpYfITrgTvfic=";
  };
  runtimeInputs = [ _7zz-rar ];
  extraPkgs =
    pkgs: with pkgs; [
      autoPatchelfHook
      icu
    ];
}

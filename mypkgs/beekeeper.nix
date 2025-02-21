{
  appimageTools,
  fetchurl,
  makeWrapper,
  ...
}:

let
  pname = "beekeeper-studio";
  version = "5.0.8";
  src = fetchurl {
    url = "https://github.com/beekeeper-studio/ultimate-releases/releases/download/v${version}/Beekeeper-Studio-${version}.AppImage";
    hash = "sha256-dFVQBZHu+Fn7oLvldyzYWPTEkndncLBIbBlNs+w2RG0=";
  };
  appimageX = appimageTools.extractType2 { inherit pname version src; };
in

appimageTools.wrapType2 {
  inherit pname version src;
  nativeBuildInputs = [ makeWrapper ];

  extraInstallCommands = ''
    wrapProgram $out/bin/${pname} \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
    install -Dm444 ${appimageX}/${pname}.desktop -t $out/share/applications/
    install -Dm444 ${appimageX}/${pname}.png -t $out/share/pixmaps/
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=${pname}'
  '';
}

{
  pkgs,
  wlib,
  ...
}:

{
  imports = [
    wlib.wrapperModules.alacritty
  ];

  config.overrides = [
    {
      type = "overrideAttrs";
      data = finalAttrs: _prevAttrs: {
        version = "0.16.1";
        src = pkgs.fetchFromGitHub {
          owner = "ayosec";
          repo = "alacritty";
          rev = "v${finalAttrs.version}-graphics";
          hash = "sha256-e+o0GLy05qXEY4T57dCuqhukTKBSm1WIHzPUV8uswRI=";
        };
        cargoHash = "sha256-VR+URXqsB9zCOSow/f/aWXUlrp6j2XeK0zKESQGzMek=";
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit (finalAttrs) pname src version;
          hash = finalAttrs.cargoHash;
        };
      };
    }
  ];
}

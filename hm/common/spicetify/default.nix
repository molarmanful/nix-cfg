{ inputs, spicePkgs, ... }:
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;

    experimentalFeatures = true;

    enabledExtensions = with spicePkgs.extensions; [ shuffle ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      reddit
    ];

  };
}

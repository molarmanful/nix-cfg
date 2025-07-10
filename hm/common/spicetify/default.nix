{
  inputs,
  lib,
  spicePkgs,
  scheme,
  ...
}:
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;

    alwaysEnableDevTools = true;
    experimentalFeatures = true;

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      addToQueueTop
      skipStats
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      reddit
    ];

    customColorScheme =
      with scheme;
      lib.mapAttrs (_: builtins.substring 1 (-1)) {
        text = base09;
        subtext = base04;
        main = base00;
        main-elevated = base01;
        highlight = base02;
        highlight-elevated = base03;
        sidebar = base00;
        player = base00;
        card = base00;
        shadow = base00;
        selected-row = base02;
        button = base04;
        button-active = base0C;
        button-disabled = base03;
        tab-active = base02;
        notification = base02;
        notification-error = base08;
        equalizer = base0C;
        misc = base02;
      };
  };
}

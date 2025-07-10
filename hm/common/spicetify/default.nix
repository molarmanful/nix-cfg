{
  inputs,
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

    colorScheme = "custom";
    customColorScheme = with scheme; {
      text = base05;
      subtext = base04;
      main = base00;
      main-elevated = base01;
      highlight = base02;
      highlight-elevated = base03;
      sidebar = base00;
      player = base02;
      card = base02;
      shadow = base00;
      selected-row = base02;
      button = base04;
      button-active = base0B;
      button-disabled = base03;
      tab-active = base02;
      notification = base02;
      notification-error = base08;
      equalizer = base0B;
      misc = base02;
    };
  };
}

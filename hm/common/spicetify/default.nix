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

    theme = spicePkgs.themes.sleek;
    colorScheme = "custom";
    customColorScheme = with scheme; {
      text = base05;
      subtext = base04;
      nav-active-text = base0B;
      main = base00;
      sidebar = base00;
      player = base00;
      card = base00;
      shadow = base00;
      main-secondary = base01;
      button = base04;
      button-secondary = base04;
      button-active = base0B;
      button-disabled = base03;
      nav-active = base02;
      play-button = base0B;
      tab-active = base02;
      notification = base02;
      notification-error = base08;
      playback-bar = base0B;
      misc = base02;
    };
  };
}

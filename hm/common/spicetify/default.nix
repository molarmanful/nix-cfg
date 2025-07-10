{
  inputs,
  config,
  spicePkgs,
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
    customColorScheme = with config.lib.stylix.colors; {
      text = base05;
      subtext = base04;
      nav-active-text = base0F;
      main = base00;
      sidebar = base00;
      player = base00;
      card = base00;
      shadow = base00;
      main-secondary = base01;
      button = base0F;
      button-secondary = base09;
      button-active = base0B;
      button-disabled = base03;
      nav-active = base01;
      tab-active = base01;
      notification = base01;
      notification-error = base08;
      playback-bar = base0F;
      misc = base01;
    };
  };
}

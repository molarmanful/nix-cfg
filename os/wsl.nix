{

  imports = [
    ./.
  ];

  networking.hostName = "wsl";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "ben";
    startMenuLaunchers = true;
    docker-desktop.enable = false;
  };
}

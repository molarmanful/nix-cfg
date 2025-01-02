{pkgs, ...}: {

  imports = [
    ../.
  ];

  networking.hostName = "jimbo-wsl";
  
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "ben";
    startMenuLaunchers = true;
    docker-desktop.enable = false;
  };
}

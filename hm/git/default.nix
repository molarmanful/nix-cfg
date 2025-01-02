{ config, pkgs, ... }: {

  programs.git = {
    enable = true;
    userName = "molarmanful";
    userEmail = "ben@benpa.ng";
  };

  programs.gh.enable = true;

}

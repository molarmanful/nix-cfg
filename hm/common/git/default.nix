{ inputs, ... }:

{
  programs.git = {
    inherit (inputs.secrets.git) userName userEmail;
    enable = true;
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}

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
      user.signingkey = inputs.secrets.public_keys.github_sign;
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}

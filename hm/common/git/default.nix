{ upkgs, inputs, ... }:
{

  programs.git = {
    inherit (inputs.secrets.git) userName userEmail;
    enable = true;
    package = upkgs.git;
    lfs.enable = true;
    ignores = [ ".jj" ];
    extraConfig = {
      init.defaultBranch = "main";
      commit.gpgsign = true;
      tag.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = inputs.secrets.public_keys.molarmanful;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

}

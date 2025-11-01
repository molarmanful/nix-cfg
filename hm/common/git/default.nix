{ upkgs, inputs, ... }:
{

  programs = {
    git = {
      enable = true;
      package = upkgs.git;
      lfs.enable = true;
      ignores = [ ".jj" ];
      settings = {
        user = {
          name = inputs.secrets.git.userName;
          email = inputs.secrets.git.userEmail;
        };
        init.defaultBranch = "main";
        commit.gpgsign = true;
        tag.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = inputs.secrets.public_keys.molarmanful;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}

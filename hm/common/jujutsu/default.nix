{ inputs, upkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    package = upkgs.jujutsu;
    settings = {
      user = {
        name = inputs.secrets.git.userName;
        email = inputs.secrets.git.userEmail;
      };
      signing = {
        behavior = "drop";
        backend = "ssh";
        key = inputs.secrets.public_keys.molarmanful;
      };
      git = {
        sign-on-push = true;
      };
      ui = {
        merge-editor = [
          "meld"
          "$left"
          "$base"
          "$right"
          "-o"
          "$output"
        ];
      };
      aliases = {
        sync = [
          "git"
          "fetch"
          "--all-remotes"
        ];
        evolve = [
          "rebase"
          "--skip-empty"
          "-d"
        ];
      };
    };
  };

  home = {
    packages = with upkgs; [
      lazyjj
      meld
    ];
    shellAliases = {
      lj = "lazyjj";
    };
  };
}

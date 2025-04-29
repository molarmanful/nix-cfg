{
  inputs,
  upkgs,
  jjui,
  ...
}:
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
          "nvim"
          "-c"
          "DiffEditor $left $right $output"
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
          "--skip-emptied"
          "-d"
        ];
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];
      };
    };
  };

  home = {
    packages = with upkgs; [
      lazyjj
      meld
      jjui
    ];
    shellAliases = {
      lj = "lazyjj";
      ju = "jjui";
    };
  };
}

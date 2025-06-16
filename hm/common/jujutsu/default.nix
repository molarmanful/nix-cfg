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
        diff-editor = [
          "nvim"
          "-c"
          "DiffEditor $left $right $output"
        ];
        merge-editor = "dc";
      };
      merge-tools = {
        dc = {
          program = "nvim";
          merge-args = [
            "-c"
            "let g:jj_diffconflicts_marker_length=$marker_length"
            "-c"
            "JJDiffConflicts!"
            "$output"
            "$base"
            "$left"
            "$right"
          ];
          merge-tool-edits-conflict-markers = true;
        };
        meld = {
          merge-args = [
            "$left"
            "$base"
            "$right"
            "-o"
            "$output"
            "--auto-merge"
          ];
        };
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
      meld
      jjui
    ];
    shellAliases = {
      ju = "jjui";
    };
  };
}

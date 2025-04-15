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
    };
  };

  home.packages = with upkgs; [
    lazyjj
  ];
}

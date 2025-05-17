{
  callPackage,
  fetchFromGitLab,
  fetchFromGitea,
  river,
  ...
}:

(river.override (old: {
  wlroots_0_18 =
    let
      version = "0.19.0";
    in
    old.wlroots_0_18.overrideAttrs {
      inherit version;
      src = fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "wlroots";
        repo = "wlroots";
        rev = version;
        hash = "sha256-I8z50yA/ukvXEC5TksG84+GrQpfC4drBJDRGw0R8RLk=";
      };
    };
})).overrideAttrs
  {
    src = fetchFromGitea {
      domain = "codeberg.org";
      owner = "river";
      repo = "river";
      rev = "ee1e36ca7ee0913282833e0324450fbc06e47a79";
      fetchSubmodules = true;
      hash = "sha256-a7nel5UktXLqJGR70SxqrSluqXXJdJm7YSaRDqb1UCI=";
    };
    deps = callPackage ./build.zig.zon.nix { };
  }

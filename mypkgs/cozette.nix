{
  fetchzip,
  cozette,
  ...
}:

let
  version = "1.26.0";
in

cozette.overrideAttrs {
  inherit version;
  src = fetchzip {
    url = "https://github.com/slavfox/Cozette/releases/download/v.${version}/CozetteFonts-v-${
      builtins.replaceStrings [ "." ] [ "-" ] version
    }.zip";
    hash = "sha256-FOgRz9amVmJSBYPa0HEwzXWsdcc53td9g3tY3sQbs9c=";
  };
}

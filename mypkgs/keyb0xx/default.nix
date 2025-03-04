{
  stdenv,
  fetchFromGitLab,
  libevdev,
}:

stdenv.mkDerivation {
  pname = "keyb0xx";
  version = "git";
  src = fetchFromGitLab {
    owner = "liamjen";
    repo = "keyb0xx";
    rev = "b2e53a2c5bca808c08b235327ffd76494ad23b32";
    sha256 = "bWHddDxUPDMU+Y9c+RYZxCPnPruU1Cx86ASYBVDrulM=";
  };

  buildInputs = [ libevdev ];
  NIX_CFLAGS_COMPILE = [ "-I${libevdev}/include/libevdev-1.0" ];

  patchPhase = ''
    cp ${./config.h} config.h
  '';

  installPhase = ''
    install -Dm 644 * -t $out/libexec
    chmod 755 $out/libexec/keyb0xx
    install -dm 755 $out/bin
    ln -s $out/keyb0xx $out/bin/keyb0xx
  '';

}

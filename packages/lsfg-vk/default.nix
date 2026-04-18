{
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  pkg-config,
  clang,
  llvmPackages,
  vulkan-headers,
  vulkan-loader,
  qt6,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "lsfg-vk";
  version = "218820e8dc2d69c21a7a0775b5c47f2c447ed31a";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = finalAttrs.version;
    hash = "sha256-Qb3vufCzNpM1r+vgo8M9nnA7CENgGTithWG0oXqLKbI=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    clang
    llvmPackages.clang-tools
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    vulkan-headers
    vulkan-loader
    qt6.qtbase
    qt6.qtdeclarative
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DCMAKE_CXX_COMPILER=clang++"
    "-DLSFGVK_BUILD_VK_LAYER=On"
    "-DLSFGVK_BUILD_UI=On"
    "-DLSFGVK_BUILD_CLI=On"
    "-DLSFGVK_INSTALL_DEVELOP=Off"
    "-DLSFGVK_INSTALL_XDG_FILES=On"
  ];
})

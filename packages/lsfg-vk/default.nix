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
  version = "997bc665f7f0f229c8d89a59cf3567ee3930927c";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = finalAttrs.version;
    hash = "sha256-HQWUxyOMxvT91azl44Z4uNWLq1oX/pKmjVcWB86xMrA=";
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

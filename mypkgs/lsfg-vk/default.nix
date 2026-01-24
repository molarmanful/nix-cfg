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
  version = "14904b9f3d78aea692bff0d330ce403ae0e74766";

  src = fetchFromGitHub {
    owner = "PancakeTAS";
    repo = "lsfg-vk";
    rev = finalAttrs.version;
    hash = "sha256-yF8GuclZ5WaFvQkXH6iJmUuj5cgFglh9Ttre/DrD5Yg=";
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

{
  lib,
  stdenv,
  fetchFromGitLab,
  ninja,
  pkg-config,
  wrapGAppsHook,
  fontconfig,
  freetype,
  libpng,
  libwebp,
  libheif,
  libtiff,
  libX11,
  libXext,
  libXcursor,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "azcomicv";
  version = "2.0.6";

  src = fetchFromGitLab {
    owner = "azelpg";
    repo = "azcomicv";
    rev = "v${finalAttrs.version}";
    hash = "sha256-ChcR8Gf3AdM4YuSt2ip7SUdsd7l3lgCXmnPXGul5rIg=";
  };

  nativeBuildInputs = [
    ninja
    pkg-config
    wrapGAppsHook
  ];

  buildInputs = [
    fontconfig
    freetype
    libpng
    libwebp
    libheif
    libtiff
    libX11
    libXext
    libXcursor
  ];

  buildPhase = ''
    cd build
    ninja
    ninja install
  '';

  meta = {
    description = "Simple comic reader";
    homepage = "http://azsky2.html.xdomain.jp/soft/index.html";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ zendo ];
  };
})

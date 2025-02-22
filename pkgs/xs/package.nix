{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  wrapGAppsHook,
  autoPatchelfHook,
  udev,
  mesa, # for libgbm
  cups,
  nss,
  nspr,
  alsa-lib,
  libdrm,
  xorg,
  mpv-unwrapped,
}:

stdenv.mkDerivation rec {
  pname = "xs";
  version = "1.0.19";

  src = fetchurl {
    url = "https://github.com/Sle2p/xs.cx/releases/download/${version}/xs-${version}+1-linux.deb";
    hash = "sha256-i2GlA6YScWDpvYEAOfjLxNkKpU5X+pJ9cFTVbnsELkg=";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    mesa # for libgbm
    cups
    nss
    nspr
    alsa-lib
    libdrm
    xorg.libXv
    mpv-unwrapped
    (lib.getLib stdenv.cc.cc)
  ];

  runtimeDependencies = [ (lib.getLib udev) ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r usr/share $out
    ln -s $out/share/xs/xs $out/bin
  '';

  meta = {
    description = "像宿：在线动漫弹幕APP";
    homepage = "https://github.com/Sle2p/xs.cx";
    license = lib.licenses.mit; # unknown
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ zendo ];
  };
}

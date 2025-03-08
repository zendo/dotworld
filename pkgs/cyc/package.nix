{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  wrapGAppsHook,
  autoPatchelfHook,
  udev,
  libgbm,
  cups,
  nss,
  nspr,
  libdrm,
  alsa-lib,
  mpv-unwrapped,
}:

stdenv.mkDerivation rec {
  pname = "cyc";
  version = "1.0.8";

  src = fetchurl {
    url = "https://alist.idti.cn/d/Public/Program/Linux/cyc-desktop_${version}_amd64.deb";
    hash = "sha256-lJnt/LBAbuuhIsrHgAhRM1jiRviakysdWk9dV6Rw/BI=";
  };

  nativeBuildInputs = [
    dpkg
    wrapGAppsHook
    autoPatchelfHook
  ];

  buildInputs = [
    libgbm
    cups
    nss
    nspr
    libdrm
    alsa-lib
    mpv-unwrapped
    (lib.getLib stdenv.cc.cc)
  ];

  runtimeDependencies = [ (lib.getLib udev) ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r opt/cyc-desktop $out
    cp -r usr/share $out
    ln -s $out/cyc-desktop/cyc-desktop $out/bin/cyc

    substituteInPlace $out/share/applications/cyc-desktop.desktop \
      --replace-fail '/opt/cyc-desktop/cyc-desktop' 'cyc'
  '';

  meta = {
    description = "次元城动画";
    homepage = "https://www.cycani.org/label/app.html";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ zendo ];
  };
}

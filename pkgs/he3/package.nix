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
  libdrm,
  alsa-lib,
}:

stdenv.mkDerivation rec {
  pname = "he3";
  version = "2.0.20";

  src = fetchurl {
    url = "https://he3-1309519128.cos.accelerate.myqcloud.com/${version}/He3_linux_amd64_${version}.deb";
    hash = "sha256-gHiPqchgbLZkeZLnjM6xxOUp1KZddkvhLMRvqJd9OMM=";
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
    libdrm
    alsa-lib
    (lib.getLib stdenv.cc.cc)
  ];

  runtimeDependencies = [ (lib.getLib udev) ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r opt/He3 $out
    cp -r usr/share $out
    ln -s $out/He3/${pname} $out/bin/${pname}

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail '/opt/He3/he3' 'he3'
  '';

  meta = {
    description = "Free, Modern, Productive, Developer Toolbox";
    homepage = "https://he3.app";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ zendo ];
  };
}

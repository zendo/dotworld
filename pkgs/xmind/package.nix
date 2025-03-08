{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  alsa-lib,
  mesa,
  nss,
  nspr,
  systemd,
  xorg,
  autoPatchelfHook,
  makeWrapper,
  makeDesktopItem,
  wrapGAppsHook,
  udev,
}:

stdenv.mkDerivation rec {
  pname = "xmind";
  version = "24.04.10311-202405240010";

  src = fetchurl {
    url = "https://dl3.xmind.net/Xmind-for-Linux-amd64bit-${version}.deb";
    hash = "sha256-54nNI4LoujcllUfqY9nqa6oshIeRmj4ObHvsUSozz+s=";
  };

  desktopItem = makeDesktopItem {
    name = "Xmind";
    icon = "net.xmind.XMind";
    exec = "xmind %U";
    categories = [ "Office" ];
    comment = "Xmind - The most popular mind mapping software";
    desktopName = "Xmind";
    startupNotify = true;
    # StartupWMClass= "Xmind";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
    makeWrapper
    wrapGAppsHook
  ];

  buildInputs = [
    alsa-lib
    mesa
    nss
    nspr
    xorg.libxkbfile
    systemd
  ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp -R "opt" "$out"
    cp -R "usr/share" "$out/share"
    chmod -R g-w "$out"

    mkdir -p "$out/share/applications"
    # cp -r ./* "$out/share/applications" # for test
    cp "${desktopItem}/share/applications/"* "$out/share/applications"
  '';

  runtimeDependencies = [ (lib.getLib udev) ];

  postFixup = ''
    makeWrapper $out/opt/Xmind/${pname} $out/bin/${pname} \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ stdenv.cc.cc ]}" \
      "''${gappsWrapperArgs[@]}"
  '';

  meta = {
    description = "Mind Mapping & Brainstorming";
    homepage = "https://xmind.app";
    license = lib.licenses.bsd3;
    # license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ zendo ];
  };
}

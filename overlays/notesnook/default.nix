{ lib, fetchurl, appimageTools }:

let
  pname = "notesnook";
  version = "2.2.3";

  src = fetchurl {
    url = "https://github.com/streetwriters/${pname}/releases/download/v${version}/notesnook_linux_x86_64.AppImage";
    hash = "sha256-1m3Xl7oGYorJnc4ZQ7TQKlP8itkyoqf9ILU0iFAFJ14=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    mv $out/bin/${pname}-${version} $out/bin/${pname}

    install -Dm 444 ${appimageContents}/${pname}.desktop -t $out/share/applications
    cp -a ${appimageContents}/usr/share/icons $out/share/

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
  '';

    meta = with lib; {
    description = "A simple music player capable of playing local audio or from Youtube or Spotify";
    homepage = "https://notesnook.com/";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ zendo ];
  };
}

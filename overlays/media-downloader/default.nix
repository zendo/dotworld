{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  qt5,
  aria2,
  yt-dlp,
  ffmpeg-full,
  python3,
}:
stdenv.mkDerivation rec {
  pname = "media-downloader";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "mhogomchungu";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-EyfhomwBtdAt6HGRwnpiijm2D1LfaCAoG5qk3orDG98=";
  };

  nativeBuildInputs = [
    cmake
    qt5.wrapQtAppsHook
  ];

  preFixup = ''
    qtWrapperArgs+=(
       --prefix PATH : "${lib.makeBinPath [ffmpeg-full aria2 yt-dlp python3]}"
    )
  '';

  meta = with lib; {
    description = "A Qt/C++ GUI front end to youtube-dl";
    homepage = "https://github.com/mhogomchungu/media-downloader";
    license = with licenses; [gpl2 gpl3];
    maintainers = with maintainers; [zendo];
  };
}

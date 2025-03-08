{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rime-ice";
  version = "2024.12.12-unstable-2025-03-05";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "16974a6688426b954bbb42d233edb6337280434c";
    hash = "sha256-6SC49QB/jO2fFO5XjK9Q8tttPeoS5syF/tqSaaKVRTo=";
  };

  installPhase = ''
    mkdir -p $out/share/rime-data
    rm -r ./others
    cp -r ./* $out/share/rime-data
  '';

  meta = {
    description = "雾凇拼音，功能齐全，词库体验良好，长期更新修订";
    homepage = "https://github.com/iDvel/rime-ice";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ zendo ];
  };
})

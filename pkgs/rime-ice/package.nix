{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rime-ice";
  version = "2024.12.12-unstable-2025-02-20";

  src = fetchFromGitHub {
    owner = "iDvel";
    repo = "rime-ice";
    rev = "65f915247295ca8097d29f36afa2927740558c7a";
    hash = "sha256-xzAPMRVBjR+0S7nGO9TBJmf5ZaFB49nB0Od9gU1jsh4=";
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

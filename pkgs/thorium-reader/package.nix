{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  electron,
}:
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=thorium-reader
buildNpmPackage {
  pname = "thorium-reader";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "edrlab";
    repo = "thorium-reader";
    rev = "latest-linux";
    hash = "sha256-qpZPIB8FgnXbILkooC8A+0HG1PUWz08S93izcITJFnc=";
  };

  npmDepsHash = "sha256-ZegRmxI1Wbeb7L/JB51sTqBoJsmItarLK400o0l2OJI=";

  # dontNpmBuild = true;

  # postPatch = ''
  #   substituteInPlace package.json --replace '"version": "0.0.0"' '"version": "${version}"'
  # '';

  # nativeBuildInputs = [ pkg-config python3 ];

  # buildInputs = [ libsecret electron];

  makeCacheWritable = true;
  npmFlags = [
    "--legacy-peer-deps"
    "--ignore-scripts"
  ];

  # npmBuild = ''
  #   npm run package:linux
  # '';

  # The prepack script runs the build script, which we'd rather do in the build phase.
  # npmPackFlags = [ "--ignore-scripts" ];

  env.ELECTRON_SKIP_BINARY_DOWNLOAD = "1";

  dontNpmBuild = true;

  postBuild = ''
    npm install --no-audit --no-fund --prefer-offline
    npm run package:build
    npm exec electron-builder -- \
      --dir \
      -c.electronDist=${electron.dist} \
      -c.electronVersion=${electron.version}
  '';

  installPhase = ''
    runHook preInstall

    # mkdir -p $out/opt
    # cp -r ./* $_

    mkdir -p $out $out/opt/thorium-reader
    cp -r release/linux-unpacked/{locales,resources{,.pak}} $out/opt/thorium-reader

    makeWrapper ${lib.getExe electron} $out/bin/thorium-reader \
      --add-flags $out/thorium-reader/resources/app.asar \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}" \
      --set-default ELECTRON_IS_DEV 0 \
      --inherit-argv0

    runHook postInstall
  '';

  meta = {
    description = "Cross platform desktop reading app, based on the Readium Desktop toolkit";
    homepage = "https://github.com/edrlab/thorium-reader";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ zendo ];
  };
}

{
  lib,
  flutter324,
  fetchFromGitHub,
  copyDesktopItems,
  makeDesktopItem,
  pkg-config,
  gtk3,
  webkitgtk_4_1,
  glib-networking,
  libayatana-appindicator,
}:

flutter324.buildFlutterApplication rec {
  pname = "picacomic";
  version = "4.2.2";

  src = fetchFromGitHub {
    owner = "Pacalini";
    repo = "PicaComic";
    rev = "v${version}";
    hash = "sha256-UOxt0ZShoRhKcZLUYbocnevFf81+4TstL1A4NHdFAn0=";
  };

  # nix run n#yq . pubspec.lock > pubspec.lock.json
  pubspecLock = lib.importJSON ./pubspec.lock.json;

  gitHashes = {
    "desktop_webview_window" = "sha256-fPC5NeyN/yBAm3ERApQ42bWN8QJ/s7iQUJkQMBv4cdo=";
    "flutter_inappwebview_android" = "sha256-u8K0r08d02UfVBoW6HSTupFPibKizqK6IHqQX0uB2fg=";
    "flutter_qjs" = "sha256-IeOuw2oh3WpuYQgfE77BoPU8Qukp4l8SSmZtHebKU4M=";
    "flutter_to_arch" = "sha256-DdP82Bdl58XW/BxMyWV3Vh4JYC2DNTjZcQB0fvw72fA=";
    "image_gallery_saver" = "sha256-Axw6aHcPExnkXk2gEhxTwL6e3tzpKGb8ejL6wL1Re0k=";
    "photo_view" = "sha256-Z+9xgvk8YS+bgCbBW7BBY72tV6JUq2kCX5OwKFK4YPE=";
    "webdav_client" = "sha256-WMw0GIpRyF6E//sxAPpQfwTJstc5j7In+aV6/6xo95M=";
    "workmanager" = "sha256-iFr1RJ0VWVlPpInwDZU6vbPGwMShrad5JTJFvLGfwTA=";
    "zip_flutter" = "sha256-hf+jkZBiDCN1ENUuFpnk+rPdnXmAdl+TSDM5iX/+ofY=";
  };

  # https://github.com/NixOS/nixpkgs/pull/326367
  # customSourceBuilders = {
  #   sqlite3_flutter_libs = callPackage ./sqlite3_flutter_libs { };
  # };

  nativeBuildInputs = [
    pkg-config
    copyDesktopItems
  ];

  buildInputs = [
    gtk3
    webkitgtk_4_1
    glib-networking
    libayatana-appindicator
  ];

  postInstall = ''
    mkdir -p $out/share/{icons,applications}
    install -Dm644 $src/debian/gui/pica-comic.png $out/share/icons/
  '';

  extraWrapProgramArgs = ''
    --prefix LD_LIBRARY_PATH : "$out/picacomic/app/lib"
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "PicaComic";
      desktopName = "PicaComic";
      exec = meta.mainProgram;
      icon = "pica-comic";
      comment = meta.description;
      categories = [ "Graphics" ];
    })
  ];

  meta = {
    description = "Comic app built with Flutter, supporting multiple comic sources";
    homepage = "https://github.com/Pacalini/PicaComic";
    mainProgram = "pica_comic";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ zendo ];
  };
}

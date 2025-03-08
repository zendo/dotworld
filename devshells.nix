{ pkgs }:
{
  default = pkgs.mkShell {
    buildInputs = with pkgs; [
      git
      just
      age
      sops
      ssh-to-age
      home-manager
      nixfmt-rfc-style
    ];
    name = "bootstrap";
    shellHook = ''
      zsh && exit
    '';
  };

  ###############################################
  ## GCC
  ###############################################
  gcc = pkgs.mkShell {
    buildInputs = with pkgs; [
      gcc
      gnumake
      cmake
      meson
      ninja
      pkg-config
      boost

      # qt5.qtbase
      # qt5.qttools
      # qt5.qtx11extras
      # qt5.wrapQtAppsHook
      # qt5.qtsvg
      # protobuf
      # libyamlcpp
      # zxing-cpp
      # zxing
      # xorg.libX11
      # xorg.libXi
      # xorg.libXinerama
    ];
    name = "gcc";
    shellHook = ''
      zsh && exit
    '';
  };

  ###############################################
  ## QT6
  ###############################################
  qt6 = pkgs.mkShell {
    buildInputs = with pkgs; [
      qt6.qmake
      pkg-config
      qt6.wrapQtAppsHook

      qt6.qtbase
      qt6.qttools
      qt6.qtsvg
      qt6.qtwayland
      qt6.qt5compat
      qt6.qtmultimedia
      qt6.qtimageformats
      libGLU
      libunarr
      qt6Packages.poppler
    ];
  };

  ###############################################
  ##  NodeJS
  ###############################################
  nodejs = pkgs.mkShell {
    buildInputs = with pkgs; [
      yarn
      nodejs
      electron
      python3

      ## cargo-tauri
      # cargo
      # rustc
      # openssl
      # pkg-config
      # gobject-introspection
      # atk
      # libsoup
      # glib
      # gtk3
      # webkitgtk
      # quickjs
      # libappindicator-gtk3
      # libayatana-appindicator
    ];
    # ELECTRON_OVERRIDE_DIST_PATH = "${pkgs.electron_20}/bin";
  };

  ###############################################
  ##  Golang
  ###############################################
  go = pkgs.mkShell {
    buildInputs = with pkgs; [
      go
      gotools
      gccgo
      delve
      pkg-config
      alsa-lib
      flac
    ];
  };

  ###############################################
  ##  Rust
  ###############################################
  # https://github.com/BKSalman/ytdlp-gui/blob/main/flake.nix
  rust = pkgs.mkShell {
    doCheck = false;
    buildType = "debug";
    # OPENSSL_NO_VENDOR = 1;
    buildInputs = with pkgs; [
      cargo
      rustc
      meson
      ninja
      clang
      openssl
      pkg-config
      curl
      cmake

      gtk4
      glib
      libadwaita
      wrapGAppsHook4
      appstream-glib
      desktop-file-utils
      libxml2
      dbus

      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly

      alsa-lib
      lame
      # libxkbcommon
      # xorg.libX11
      # xorg.libxcb
      # xorg.xcbutil
      # xorg.xcbutilwm
      # xorg.xcbutilimage
      # xorg.xcbutilkeysyms
      # freetype
      # fontconfig
    ];
  };

  ###############################################
  ##  Python
  ###############################################
  # python setup.py install --root=/home/iab/devs/
  python = pkgs.mkShell {
    buildInputs = with pkgs; [
      (python3.withPackages (
        p: with p; [
          numpy
          requests
          pandas
        ]
      ))
      python3
      virtualenv
      python3Packages.pip
    ];
    propagatedBuildInputs = with pkgs.python3.pkgs; [
      requests
      chardet
      docutils
      markdown
      markups
      pyenchant
      pygments
      # pyqt5
      # pyqt6
    ];
    env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
      pkgs.libz
    ];
  };

  ###############################################
  ##  Ruby
  ###############################################
  # bundix -l   # generates gemset.nix & Gemfile.lock
  # cp Gemfile Gemfile.lock gemset.nix
  ruby = pkgs.mkShell {
    buildInputs = with pkgs; [
      # ruby.devEnv
      ruby
      bundix
      gnumake
      pkg-config
      git
      sqlite
      postgresql
      libpcap
      libxml2
      libxslt
    ];
  };

  ###############################################
  ##  Java
  ###############################################
  java = pkgs.mkShell {
    buildInputs = with pkgs; [
      jdk
      gradle
      xorg.libXrender
    ];
  };

  ###############################################
  ##  Android
  ###############################################
  # https://discourse.nixos.org/t/building-expo-react-native-android-app-on-nixos/38194/3
  apk =
    let
      pinnedJDK = pkgs.jdk17;
      buildToolsVersion = "34.0.0";
      ndkVersion = "25.1.8937393";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [
          buildToolsVersion
          "33.0.1"
        ];
        platformVersions = [
          "34"
          "33"
          "32"
          "31"
        ];
        # armeabi-v7a (ARM 32-bit), arm64-v8a (ARM 64-bit), and x86-64 (x86 64-bit)
        abiVersions = [ "arm64-v8a" ];
        cmakeVersions = [
          "3.10.2"
          "3.22.1"
        ];
        includeEmulator = true;
        emulatorVersion = "34.1.9";
        includeNDK = true;
        ndkVersions = [ ndkVersion ];
      };
    in
    pkgs.mkShell rec {
      buildInputs = with pkgs; [
        pinnedJDK
        androidComposition.androidsdk
        pkg-config
        flutter
      ];

      JAVA_HOME = pinnedJDK;
      ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
      ANDROID_NDK_ROOT = "${ANDROID_SDK_ROOT}/ndk-bundle";

      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/${buildToolsVersion}/aapt2";
    };
  /*
    # Flutter
    keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
    cp key.jks android/app

    micro android/key.properties
    storePassword=123456
    keyPassword=123456
    keyAlias=key
    storeFile=./key.jks
  */

  ###############################################
  ##  Haskell
  ###############################################
  haskell = pkgs.mkShell {
    buildInputs = with pkgs; [
      ghc
      stack
      cabal-install
      haskell-language-server
    ];
  };
}

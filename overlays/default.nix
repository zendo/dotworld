final: prev: {
  /*
   (pkgs.google-chrome.override {
      commandLineArgs = "--ozone-platform-hint=auto --enable-features=VaapiVideoDecoder --use-gl=egl";
   })
   */

  # scripts
  nix-whereis = prev.callPackage ./nix-whereis {};

  # trivial
  harmonyos-sans = prev.callPackage ./harmonyos-sans {};
  misans = prev.callPackage ./misans {};

  # rust
  zee = prev.callPackage ./zee {};

  # go
  v2raya = prev.callPackage ./v2raya {};

  # python
  frog = prev.callPackage ./frog {};

  # nodejs

  # gtk
  dippi = prev.callPackage ./dippi {};
  app-icon-preview = prev.callPackage ./app-icon-preview {};

  # Override
  # fix .desktop missing
  wl-color-picker =
    prev.wl-color-picker.overrideAttrs
    (oldAttrs: {
      postFixup = ''
        cp -r $out/usr/share $out/share '';
    });

  # mutter hover bug
  gnome = prev.gnome.overrideScope' (gfinal: gprev: {
    mutter = gprev.mutter.overrideAttrs (oldAttrs: {
      src = prev.fetchurl {
        url = "https://gitlab.gnome.org/GNOME/mutter/-/archive/42.1/mutter-42.1.tar.gz";
        sha256 = "sha256-tInOmRrdt1CPWhZZlwqEwb3Iqb/xiJGzIEHmoKQxflk=";
      };
    });
  });

  # sddm-git
  # libsForQt5 = prev.libsForQt5.overrideScope' (finay: prevy: {
  #   sddm =
  #     prevy.sddm.overrideAttrs
  #     (oldAttrs: {
  #       src = prev.fetchFromGitHub {
  #         owner = "sddm";
  #         repo = "sddm";
  #         rev = "e67307e4103a8606d57a0c2fd48a378e40fcef06";
  #         sha256 = "sha256-FfbYQrHndU7rtI8CKK7wtn3pdufBSiXUgefozCja4Do=";
  #       };
  #       patches = [];
  #     });
  # });
}

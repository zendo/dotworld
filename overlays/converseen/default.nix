{ lib
, stdenv
, fetchFromGitHub
, qt5
, cmake
, pkg-config
, imagemagick
, nix-update-script
}:

stdenv.mkDerivation rec {
  pname = "converseen";
  version = "0.9.9.7";

  src = fetchFromGitHub {
    owner = "Faster3ck";
    repo = "Converseen";
    rev = "v${version}";
    hash = "sha256-DZuyAKeSndsPd796t9KqYMo+g7tOp64PQ+mJFBaZMao=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    qt5.qttools
    qt5.wrapQtAppsHook
  ];

  buildInputs = [
    imagemagick
  ];

  # postPatch = ''
  #   substituteInPlace src/whereiam.cpp \
  #     --replace "/usr" "Sout"
  # '';

  passthru.updateScript = nix-update-script {
    attrPath = pname;
  };

  meta = with lib; {
    description = "Batch image converter and resizer";
    homepage = "https://github.com/Faster3ck/Converseen";
    changelog = "https://github.com/Faster3ck/Converseen/releases/tag/${src.rev}";
    platforms = platforms.linux;
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ zendo ];
  };
}

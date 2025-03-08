{ stdenv }:
stdenv.mkDerivation {
  name = "hello";

  src = ./hello.c;

  dontUnpack = true;

  buildPhase = ''
    gcc -o hello $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -t $out/bin hello
  '';
}

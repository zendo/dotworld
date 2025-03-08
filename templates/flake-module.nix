{
  flake.templates = {
    # nix flake init -t github:zendo/nsworld#mkiso
    mkiso = {
      description = ''
        Contains the bare minimum to migrate your existing legacy configs to flakes.
      '';
      path = ./mkiso;
    };

    hello = {
      description = ''
        Hello world!
      '';
      path = ./hello;
    };

    hello-parts = {
      description = ''
        Hello parts!
      '';
      path = ./hello-parts;
    };
  };
}

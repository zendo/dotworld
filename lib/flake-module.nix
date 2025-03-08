{ inputs, ... }:
{
  flake.lib = inputs.nixpkgs.lib.extend (
    final: prev:
    import ./attrsets.nix { inherit (inputs.nixpkgs) lib; }
    // import ./umport.nix { inherit (inputs.nixpkgs) lib; }
  );
}

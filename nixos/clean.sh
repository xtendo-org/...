nix-env --delete-generations old
nix-collect-garbage
nix-collect-garbage -d
nix-store --optimise

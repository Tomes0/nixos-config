.PHONY: update
update:
        home-manager switch --flake .#tomi

.PHONY: update-system
update-system:
        sudo nixos-rebuild switch --flake .#nixos

.PHONY: clean
clean:
        nix-collect-garbage -d

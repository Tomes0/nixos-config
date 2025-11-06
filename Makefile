.PHONY: update
update:
		sudo nixos-rebuild switch --flake .#nixos

.PHONY: clean
clean:
	nix-collect-garbage -d

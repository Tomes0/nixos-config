.PHONY: update
update:
		sudo nixos-rebuild switch --flake .#nixos ; notify-send "NixOS" "System updated successfully!"

.PONY: boot
boot:
		sudo nixos-rebuild boot --flake .#nixos ; notify-send "NixOS" "System will boot into the new configuration on next reboot!"

.PHONY: gc
gc:
	nix-collect-garbage -d

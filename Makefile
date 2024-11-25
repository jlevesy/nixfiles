HOST?=vmcell

.PHONY: all
all: rebuild

.PHONY: rebuild
rebuild: 
	sudo nixos-rebuild switch --flake .#$(HOST)

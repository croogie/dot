DOTFILES=${HOME}/.dotfiles
SHELL := /bin/zsh
MAC_DIRS = bin nvim tmux karabiner skhd yabai

all: brew 

mac: $(MAC_DIRS)

%:
	echo "test $<"

macosx:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" bin
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" nvim
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" tmux
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" karabiner
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" skhd
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" yabai

unix:
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" bin
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" nvim
	stow --restow --ignore ".DS_Store" --target="$(HOME)" --dir="$(DOTFILES)" tmux

#brew:
#	brew bundle --file="$(DOTFILES)/homebrew/Brewfile"


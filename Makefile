all: emacs zsh tmux git alacritty karabiner hammerspoon

emacs:
	ln -s -f ${PWD}/.emacs.d/early-init.el ${HOME}/.emacs.d/early-init.el
	ln -s -f ${PWD}/.emacs.d/init.el ${HOME}/.emacs.d/init.el

	emacs -Q --batch -f batch-byte-compile ${HOME}/.emacs.d/early-init.el
	emacs -Q --batch -l ${HOME}/.emacs.d/early-init.el -f batch-byte-compile ${HOME}/.emacs.d/init.el

zsh:
	ln -sf ${PWD}/.zshenv ${HOME}/.zshenv
	mkdir -p ${HOME}/.zsh
	ln -sf ${PWD}/.zsh/.zshenv ${HOME}/.zsh/.zshenv
	if [ ! -e ${HOME}/.zsh/.zshenv.local ]; then cp ${PWD}/.zsh/.zshenv.local ${HOME}/.zsh/.zshenv.local; fi
	ln -sf ${PWD}/.zsh/.zprofile ${HOME}/.zsh/.zprofile
	if [ ! -e ${HOME}/.zsh/.zprofile.local ]; then cp ${PWD}/.zsh/.zprofile.local ${HOME}/.zsh/.zprofile.local; fi
	ln -sf ${PWD}/.zsh/.zshrc ${HOME}/.zsh/.zshrc
	if [ ! -e ${HOME}/.zsh/.zshrc.local ]; then cp ${PWD}/.zsh/.zshrc.local ${HOME}/.zsh/.zshrc.local; fi
	ln -sfn ${PWD}/.zsh/.zshenv.d ${HOME}/.zsh/.zshenv.d

tmux:
	ln -s -f ${PWD}/.tmux.conf ${HOME}/.tmux.conf

git:
	ln -s -f ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -s -f ${PWD}/.gitignore_ ${HOME}/.gitignore
	touch ${HOME}/.gitconfig.local

alacritty:
	mkdir -p ${HOME}/.config/alacritty
	ln -s -f ${PWD}/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml

karabiner:
	mkdir -p ${HOME}/.config/karabiner
	ln -s -f ${PWD}/.config/karabiner/karabiner.json ${HOME}/.config/karabiner/karabiner.json

hammerspoon:
	mkdir -p ${HOME}/.hammerspoon
	ln -s -f ${PWD}/.hammerspoon/init.lua ${HOME}/.hammerspoon/init.lua

.PHONY: all emacs zsh tmux git alacritty karabiner hammerspoon

all: emacs zsh tmux git alacritty

emacs:
	ln -s -f ${PWD}/.emacs ${HOME}/.emacs

	mkdir -p ${HOME}/.emacs.d/inits
	ln -s -f ${PWD}/.emacs.d/inits/* ${HOME}/.emacs.d/inits

	mkdir -p ${HOME}/.emacs.d/themes
	ln -s -f ${PWD}/.emacs.d/themes/dark-laptop-theme.el ${HOME}/.emacs.d/themes/dark-laptop-theme.el

	mkdir -p ${HOME}/.emacs.d/elisp

	ln -s -f ${PWD}/.emacs.d/custom.el ${HOME}/.emacs.d/custom.el

	@echo "You should run"
	@echo "  M-x package-install-selected-packages"

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
	if [ $(shell which tmux 2>&1 > /dev/null; echo $$?) -eq 0 ]; then \
		if [ $(shell bash -c '[[ `tmux -V` == *3.* ]]'; echo $$?) -eq 0 ]; then \
			ln -s -f ${PWD}/.tmux29.conf ${HOME}/.tmux.conf; \
		else \
			ln -s -f ${PWD}/.tmux2.conf ${HOME}/.tmux.conf; \
		fi \
	fi

git:
	ln -s -f ${PWD}/.gitconfig ${HOME}/.gitconfig
	ln -s -f ${PWD}/.gitignore_ ${HOME}/.gitignore
	touch ${HOME}/.gitconfig.local

alacritty:
	mkdir -p ${HOME}/.config/alacritty
	ln -s -f ${PWD}/.config/alacritty/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml

.PHONY: all emacs zsh tmux git alacritty

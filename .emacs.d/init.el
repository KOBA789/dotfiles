(defconst my/saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-init-file (or load-file-name byte-compile-current-file (buffer-file-name)))
    (setq user-emacs-directory (file-name-directory user-init-file))))

(eval-and-compile
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (add-hook 'kill-emacs-hook (lambda () (delete-file custom-file))))

(eval-when-compile
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :config
    (leaf-keywords-init)))

(eval-and-compile
  (leaf *keybindings
    :init
    (global-set-key (kbd "C-c C-l") 'toggle-truncate-lines)
    (global-set-key (kbd "C-h") 'delete-backward-char))

  (leaf color-theme-modern
    :ensure t
    :config
    (load-theme 'dark-laptop t t)
    (enable-theme 'dark-laptop))

  (leaf custom
    :setq-default
    (tab-width . 2)
    (indent-tabs-mode . nil)
    (large-file-warning-threshold . nil)
    (transient-mark-mode . t)
    (scroll-conservatively . 1)
    (show-trailing-whitespace . t)
    (vc-handled-backends . nil)
    (enable-local-variables . nil))

  (leaf ido
    :require t
    :global-minor-mode ido-mode)

  (leaf uniquify :require t)

  (leaf zlc
    :ensure t
    :global-minor-mode zlc-mode)

  (leaf sudo-edit :ensure t)

  (leaf ggtags :ensure t)

  (leaf auto-complete :ensure t)

  (leaf rust-mode :ensure t)

  (leaf enh-ruby-mode
    :ensure t
    :mode
    "\\.\\(?:rb\\|ru\\|rake\\|gemspec\\|iam\\)\\'"
    "/\\(?:Gem\\|Rake\\|Cap\\|Vagrant\\)file\\'"
    :interpreter "ruby"
    :magic "ruby"
    :mode-hook
    (auto-complete-mode))

  (leaf *js-lang
    :config
    (leaf js-mode :setq-default (js-indent-level . 2))
    (leaf js2-mode :ensure t :mode "\\.js$")
    (leaf js2-refactor :ensure t))

  (leaf c-mode
    :defvar (c-basic-offset)
    :mode-hook
    (c-mode-hook . ((c-set-style "linux")
                    (setq c-basic-offset 8
                          indent-tabs-mode t
                          tab-width 8))))

  (leaf css-mode
    :setq-default (css-indent-offset . 2))

  (leaf scss-mode :ensure t)

  (leaf web-mode :ensure t)

  (leaf haml-mode :ensure t)

  (leaf go-mode :ensure t)

  (leaf yaml-mode :ensure t)

  (leaf dockerfile-mode :ensure t)

  (leaf earthfile-mode :ensure t)

  (leaf jsonnet-mode :ensure t)

  (leaf terraform-mode :ensure t)

  (leaf nftables-mode :ensure t)

  (leaf nginx-mode :ensure t)

  (leaf markdown-mode :ensure t))

(leaf *powerline
  :setq-default
  (line-number-mode . t)
  (column-number-mode . t)
  (mode-line-format . '((:propertize " %b " face mode-line-buffer-name)
                        (:propertize "%+ "  face mode-line-buffer-status)
                        (:propertize
                         (" " (:eval (format-mode-line mode-name))
                          minor-mode-alist " ")
                         face mode-line-modes)
                        (:propertize " %l:%c "       face mode-line-info)))
  :defun
  make/set-face
  :init

  (set-face-attribute 'mode-line nil
                      :foreground "color-231"
                      :background "color-236" :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :foreground "color-231"
                      :background "color-234" :box nil)
  (defun make/set-face (face-name fg-color bg-color weight)
    (make-face face-name)
    (set-face-attribute face-name nil
                        :foreground fg-color
                        :background bg-color
                        :box nil
                        :weight weight))

  (defconst theme-color-light (concat "color-" (getenv "COLOR_LIGHT")))
  (defconst theme-color-dark  (concat "color-" (getenv "COLOR_DARK")))

  (make/set-face 'mode-line-buffer-status
                 "color-231"
                 theme-color-dark
                 'normal)
  (make/set-face 'mode-line-buffer-name
                 "color-231"
                 theme-color-dark
                 'bold)
  (make/set-face 'mode-line-modes
                 "color-231"
                 "color-236"
                 'normal)
  (make/set-face 'mode-line-info
                 "color-231"
                 theme-color-light
                 'normal))

(setq file-name-handler-alist my/saved-file-name-handler-alist)

(provide 'init)

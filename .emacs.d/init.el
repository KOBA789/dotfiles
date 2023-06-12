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
  (package-initialize)
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
    (auto-save-default . nil)
    (make-backup-files . nil)
    (tab-width . 2)
    (indent-tabs-mode . nil)
    (large-file-warning-threshold . nil)
    (transient-mark-mode . t)
    (scroll-conservatively . 1)
    (show-trailing-whitespace . t)
    (vc-handled-backends . nil)

    (line-number-mode . t)
    (column-number-mode . t))

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

  (leaf *ruby-lang
    :config
    (leaf enh-ruby-mode
      :ensure t
      :mode
      "\\.\\(?:rb\\|ru\\|rake\\|gemspec\\|iam\\)\\'"
      "/\\(?:Gem\\|Rake\\|Cap\\|Vagrant\\)file\\'"
      :interpreter "ruby"
      :mode-hook
      (robe-mode))
    (leaf robe
      :ensure t
      :hook robe-mode-hook
      (ac-robe-setup)))

  (leaf *js-lang
    :config
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

  (leaf less-css-mode :ensure t)

  (leaf haml-mode :ensure t)

  (leaf go-mode :ensure t)

  (leaf yaml-mode :ensure t)

  (leaf dockerfile-mode :ensure t)

  (leaf jsonnet-mode :ensure t)

  (leaf terraform-mode :ensure t)

  (leaf nftables-mode :ensure t)

  (leaf nginx-mode :ensure t)

  (leaf markdown-mode :ensure t))

(setq file-name-handler-alist my/saved-file-name-handler-alist)

(provide 'init)

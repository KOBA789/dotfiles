(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(when (require 'init-loader nil t)
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load (expand-file-name "inits" user-emacs-directory)))

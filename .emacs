(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/.emacs.d/inits")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(cssm-indent-function (function cssm-c-style-indenter))
 '(cssm-indent-level 2)
 '(direx:closed-icon "+ ")
 '(direx:leaf-icon "  ")
 '(direx:open-icon "- ")
 '(enh-ruby-add-encoding-comment-on-save nil)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-include-node-externs t)
 '(js2-strict-trailing-comma-warning nil)
 '(large-file-warning-threshold nil)
 '(make-backup-files nil)
 '(package-selected-packages
   (quote
    (jsonnet-mode terraform-mode apache-mode swift3-mode js2-mode ggtags elscreen elscreen-separate-buffer-list groovy-mode puppet-mode dockerfile-mode zlc yaml-mode yagist web-mode w3m tss sws-mode slim-mode scss-mode robe popwin ox-gfm nginx-mode markdown-mode+ less-css-mode js2-refactor jade-mode init-loader haml-mode go-mode go-autocomplete gist esup erlang enh-ruby-mode direx coffee-mode actionscript-mode)))
 '(safe-local-variable-values
   (quote
    ((whitespace-line-column . 80)
     (eval add-hook
           (quote write-file-hooks)
           (quote time-stamp)))))
 '(scroll-conservatively 1)
 '(show-trailing-whitespace t)
 '(tab-width 2)
 '(transient-mark-mode t)
 '(vc-handled-backends nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(setq gc-cons-threshold (* 50 gc-cons-threshold))

(setq frame-background-mode 'dark)
(setq truncate-partial-width-windows nil)
(custom-set-variables
 ;; highlight region
 '(transient-mark-mode t)

 ;; indent
 '(tab-width 2)
 '(indent-tabs-mode nil)
 '(cssm-indent-level 2)
 '(cssm-indent-function #'cssm-c-style-indenter)

 ;; open big file
 '(large-file-warning-threshold nil)

 ;; ignore the warnings of local variable values
 '(safe-local-variable-values (quote ((eval add-hook (quote write-file-hooks) (quote time-stamp)))))

 ;; js2-mode
 '(js2-basic-offset 2)
 '(js2-include-node-externs t)

 ;; json
 '(js-indent-level 2)

  ;; disable backup
 '(make-backup-files nil)

 ;; disable auto save
 '(auto-save-default nil)

 ;; disable git
 '(vc-handled-backends ()))

;; -Keybindings
;; --ToggleTruncateLines
(global-set-key (kbd "C-c C-l") 'toggle-truncate-lines)

;; --BackwardChar
(global-set-key "\C-h" 'delete-backward-char)

;; -Powerline
(defun git-branch-mode-line ()
  (let* ((branch (replace-regexp-in-string
                  "[\r\n]+\\'" ""
                  (shell-command-to-string "git symbolic-ref -q HEAD")))
         (mode-line-str (if (string-match "^refs/heads/" branch)
                            (format " [%s]" (substring branch 11)) "")))
    (propertize mode-line-str 'face 'mode-line-info)))

(line-number-mode t)
(column-number-mode t)
(setq-default mode-line-format
              '((:propertize " %m :"           face mode-line-modes)
                (:propertize minor-mode-alist  face mode-line-modes)
                (:propertize " "               face mode-line-modes)
                (:propertize " %b "            face mode-line-buffer-name)
                (:propertize " %+ %Z %p %l:%c "       face mode-line-info)))

(set-face-attribute 'mode-line nil
                    :foreground "color-231"
                    :background "color-234" :box nil)
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

(make/set-face 'mode-line-modes
               (concat "color-" (getenv "COLOR_DARK"))
               "color-231"
               'bold)
(make/set-face 'mode-line-info
               "color-231"
               (concat "color-" (getenv "COLOR_LIGHT"))
               'normal)
(make/set-face 'mode-line-buffer-name
               "color-231"
               (concat "color-" (getenv "COLOR_DARK"))
               'bold)

;; Other plugins

;; -popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; -direx
(require 'direx)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx-project:jump-to-project-root-other-window)

;; -zlc
(require 'zlc)
(zlc-mode t)

;; -ido
(require 'ido)
(ido-mode t)

;; -uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; -auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
(ac-config-default)
(setq ac-ignore-case nil)

;; -color-theme
(load-theme 'dark-laptop t t)
(enable-theme 'dark-laptop)

;; -js2-refactor
(js2r-add-keybindings-with-prefix "C-c C-m")

;; -js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; -typescript-mode
(autoload 'typescript-mode "typescript-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))

;; -html-mode
;; --Config
(add-hook 'html-mode-hook
          '(lambda ()
             (setq auto-coding-functions nil)))

;; -gaml
(add-to-list 'auto-mode-alist '("\\.gaml" . xml-mode))

;; -go-mode
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go" . go-mode))
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)))

;; -nginx-mode
(autoload 'nginx-mode "nginx-mode" nil t)

;; -less-css-mode
(autoload 'less-css-mode "less-css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))

;; -coffee-mode
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-to-list 'ac-modes 'coffee-mode)

;; -c-mode
(defun linux-style ()
  (setq c-default-style "linux"
        c-basic-offset 8
        indent-tabs-mode t
        tab-width 8))
(add-hook 'c-mode-hook 'linux-style)

;; -menu-bar
(menu-bar-mode 0)

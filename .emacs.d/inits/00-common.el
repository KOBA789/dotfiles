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

;; -web-mode
(defun my-web-mode-hook ()
  "Hooks for web-mode"
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset 2)
  (setq web-mode-html-offset 2)
  (setq web-mode-style-padding 2)
  (setq web-mode-script-padding 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

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

;; -scss-mode
(add-hook 'scss-mode-hook
          '(lambda ()
             (and
              (set (make-local-variable 'css-indent-offset) 2)
              (set (make-local-variable 'scss-compile-at-save) nil))))

;; -ruby-mode
(setq ruby-insert-encoding-magic-comment nil)

;; -menu-bar
(menu-bar-mode 0)

;; -ambiguous width
(defun set-east-asian-ambiguous-width (width)
  (while (char-table-parent char-width-table)
    (setq char-width-table (char-table-parent char-width-table)))
  (let ((table (make-char-table nil)))
    (dolist (range
             '(#x00A1 #x00A4 (#x00A7 . #x00A8) #x00AA (#x00AD . #x00AE)
                      (#x00B0 . #x00B4) (#x00B6 . #x00BA) (#x00BC . #x00BF)
                      #x00C6 #x00D0 (#x00D7 . #x00D8) (#x00DE . #x00E1) #x00E6
                      (#x00E8 . #x00EA) (#x00EC . #x00ED) #x00F0
                      (#x00F2 . #x00F3) (#x00F7 . #x00FA) #x00FC #x00FE
                      #x0101 #x0111 #x0113 #x011B (#x0126 . #x0127) #x012B
                      (#x0131 . #x0133) #x0138 (#x013F . #x0142) #x0144
                      (#x0148 . #x014B) #x014D (#x0152 . #x0153)
                      (#x0166 . #x0167) #x016B #x01CE #x01D0 #x01D2 #x01D4
                      #x01D6 #x01D8 #x01DA #x01DC #x0251 #x0261 #x02C4 #x02C7
                      (#x02C9 . #x02CB) #x02CD #x02D0 (#x02D8 . #x02DB) #x02DD
                      #x02DF (#x0300 . #x036F) (#x0391 . #x03A9)
                      (#x03B1 . #x03C1) (#x03C3 . #x03C9) #x0401
                      (#x0410 . #x044F) #x0451 #x2010 (#x2013 . #x2016)
                      (#x2018 . #x2019) (#x201C . #x201D) (#x2020 . #x2022)
                      (#x2024 . #x2027) #x2030 (#x2032 . #x2033) #x2035 #x203B
                      #x203E #x2074 #x207F (#x2081 . #x2084) #x20AC #x2103
                      #x2105 #x2109 #x2113 #x2116 (#x2121 . #x2122) #x2126
                      #x212B (#x2153 . #x2154) (#x215B . #x215E)
                      (#x2160 . #x216B) (#x2170 . #x2179) (#x2190 . #x2199)
                      (#x21B8 . #x21B9) #x21D2 #x21D4 #x21E7 #x2200
                      (#x2202 . #x2203) (#x2207 . #x2208) #x220B #x220F #x2211
                      #x2215 #x221A (#x221D . #x2220) #x2223 #x2225
                      (#x2227 . #x222C) #x222E (#x2234 . #x2237)
                      (#x223C . #x223D) #x2248 #x224C #x2252 (#x2260 . #x2261)
                      (#x2264 . #x2267) (#x226A . #x226B) (#x226E . #x226F)
                      (#x2282 . #x2283) (#x2286 . #x2287) #x2295 #x2299 #x22A5
                      #x22BF #x2312 (#x2460 . #x24E9) (#x24EB . #x254B)
                      (#x2550 . #x2573) (#x2580 . #x258F) (#x2592 . #x2595)
                      (#x25A0 . #x25A1) (#x25A3 . #x25A9) (#x25B2 . #x25B3)
                      (#x25B6 . #x25B7) (#x25BC . #x25BD) (#x25C0 . #x25C1)
                      (#x25C6 . #x25C8) #x25CB (#x25CE . #x25D1)
                      (#x25E2 . #x25E5) #x25EF (#x2605 . #x2606) #x2609
                      (#x260E . #x260F) (#x2614 . #x2615) #x261C #x261E #x2640
                      #x2642 (#x2660 . #x2661) (#x2663 . #x2665)
                      (#x2667 . #x266A) (#x266C . #x266D) #x266F #x273D
                      (#x2776 . #x277F) (#xE000 . #xF8FF) (#xFE00 . #xFE0F)
                      #xFFFD
                      ))
      (set-char-table-range table range width))
    (optimize-char-table table)
    (set-char-table-parent table char-width-table)
    (setq char-width-table table)))
(set-east-asian-ambiguous-width 2)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(defvar bundle-package-list
  '(
    actionscript-mode
    auto-complete
    coffee-mode
    dash
    direx
    erlang
    esup
    gh
    gist
    go-autocomplete
    go-mode
    init-loader
    js2-mode
    js2-refactor
    json-mode
    json-reformat
    json-snatcher
    less-css-mode
    logito
    markdown-mode
    markdown-mode+
    multiple-cursors
    nginx-mode
    pcache
    popup
    popwin
    s
    scss-mode
    w3m
    yagist
    yasnippet
    zlc
    ))

(defun bundle-install ()
  "package install from list"
  (interactive)
  (package-refresh-contents)
  (dolist (package bundle-package-list)
    (when (not (package-installed-p package))
      (package-install package))))

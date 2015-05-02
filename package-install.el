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
    haml-mode
    init-loader
    jade-mode
    js2-mode
    js2-refactor
    json-mode
    json-reformat
    json-snatcher
    less-css-mode
    log4e
    logito
    markdown-mode
    markdown-mode+
    multiple-cursors
    nginx-mode
    org
    ox-gfm
    pcache
    popup
    popwin
    s
    scss-mode
    slim-mode
    sws-mode
    tss
    w3m
    web-mode
    yagist
    yaml-mode
    yaxception
    zlc
    enh-ruby-mode
    ))

(defun bundle-install ()
  "package install from list"
  (interactive)
  (package-refresh-contents)
  (dolist (package bundle-package-list)
    (when (not (package-installed-p package))
      (package-install package))))

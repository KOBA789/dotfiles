(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(custom-set-variables '(enh-ruby-add-encoding-comment-on-save nil))
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-hook
 'enh-ruby-mode-hook
 '(lambda ()
    (setq ruby-block-highlight-toggle t)
    (setq enh-ruby-deep-indent-paren nil)))

(add-hook 'enh-ruby-mode-hook 'robe-mode)

(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
(add-hook 'robe-mode-hook 'ac-robe-setup)

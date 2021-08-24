(defun auto-y-or-n-p (prompt)
  "auto yes"
  t)
(defalias 'y-or-n-p 'auto-y-or-n-p)
(package-refresh-contents)
(package-install-selected-packages)

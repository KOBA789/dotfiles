(defun coffee-custom ()
  "coffee-mode-hook"
  (defun coffee-indent-line ()
    "Indent current line as CoffeeScript."
    (interactive)
    (let* ((curindent (current-indentation))
           (limit (+ (line-beginning-position) curindent))
           (type (coffee--block-type))
           indent-size
           begin-indents)
      (cond ((< (point) limit)
             (goto-char limit))
            (t
             (if (and type (setq begin-indents (coffee--find-indents type limit '<)))
                 (setq indent-size (coffee--decide-indent curindent begin-indents '>))
               (let ((prev-indent (coffee-previous-indent))
                     (next-indent-size (+ curindent coffee-tab-width)))
                 (if (> (- next-indent-size prev-indent) coffee-tab-width)
                     (setq indent-size 0)
                   (setq indent-size (+ curindent coffee-tab-width)))))
             (coffee--indent-insert-spaces indent-size)))
      ))
  (local-set-key (kbd "C-a")
                 (lambda ()
                   ""
                   (interactive)
                   (if (bolp)
                       (back-to-indentation)
                     (beginning-of-line)))))

(add-hook 'coffee-mode-hook
          '(lambda() (coffee-custom)))

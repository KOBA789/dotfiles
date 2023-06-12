(setq gc-cons-threshold (* 50 gc-cons-threshold))

(defconst my/before-load-init-time (current-time))
(defun my/load-init-time ()
  "Loading time of user init files including time for `after-init-hook'."
  (let ((time1 (float-time
                (time-subtract after-init-time my/before-load-init-time)))
        (time2 (float-time
                (time-subtract (current-time) my/before-load-init-time))))
    (message (concat "Loading init files: %.0f [msec], "
                     "of which %.f [msec] for `after-init-hook'.")
             (* 1000 time1) (* 1000 (- time2 time1)))))
(add-hook 'after-init-hook #'my/load-init-time t)

(defun my/emacs-init-time ()
  "Emacs booting time in msec."
  (interactive)
  (message "Emacs booting time: %.0f [msec] = `emacs-init-time'."
           (* 1000
              (float-time (time-subtract
                           after-init-time
                           before-init-time)))))
(add-hook 'after-init-hook #'my/emacs-init-time)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)

(defvar warning-minimum-level)
(setq warning-minimum-level :error)
(setq inhibit-startup-screen t)
(setq max-lisp-eval-depth 10000)

(setq auto-save-default nil)
(setq make-backup-files nil)

(setq package-enable-at-startup nil)

(setq-default mode-line-format (list))

(eval-and-compile
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-activate-all))

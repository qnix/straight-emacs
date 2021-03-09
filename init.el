(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(defvar qnix/frame-alist '((font . "Monaco-13")
			   (width . 102) (height . 38)))
(setq initial-frame-alist qnix/frame-alist)
(setq default-frame-alist qnix/frame-alist)

(add-to-list 'display-buffer-alist '("." nil (reusable-frames . t)))

(setq inhibit-startup-message t
      initial-scratch-message nil)

(straight-use-package 'better-defaults)

(straight-use-package 'evil)
(straight-use-package 'evil-collection)

(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(evil-mode 1)
(evil-collection-init)

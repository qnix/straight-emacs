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

(setq tab-width 2
      indent-tabs-mode nil)

(straight-use-package 'use-package)
(straight-use-package 'better-defaults)


(use-package evil
  :straight t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package general
  :straight t
  :after evil
  :config
  (general-create-definer qnix/leader-keys
			  :keymaps '(normal insert visual emacs)
			  :prefix "SPC"
			  :global-prefix "C-SPC")

  (qnix/leader-keys
   "fe" '(lambda () (interactive) (find-file (expand-file-name "init.el" user-emacs-directory)))))

(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))


(use-package magit
  :straight t
  :commands (magit-status)
  :bind (("C-x C-g" . magit-status))
  :config
  (defadvice magit-status (around magit-fullscreen activate)
    "Make magit-status run alone in a frame."
    (window-configuration-to-register :magit-fullscreen)
    ad-do-it
    (delete-other-window))

  (defun magit-quit-session ()
    "Restore the previous window configuration and kill the magit buffer."
    (interactive)
    (kill-buffer)
    (jump-to-register :magit-fullscreen)))

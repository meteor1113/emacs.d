;;; -*- mode: emacs-lisp; coding: utf-8; -*-

;; Copyright (C) 2008- Liu Xin
;;
;; This code has been released into the Public Domain.
;; You may do whatever you like with it.
;;
;; @file
;; @author Liu Xin <meteor1113@qq.com>
;; @URL http://git.oschina.net/meteor1113/emacs.d

;;; Commentary:

;;; Code:

;; (let ((root-dir (file-name-directory (directory-file-name
;;                                       (file-name-directory (or load-file-name buffer-file-name))))))
;;   (setq package-user-dir (expand-file-name "elpa" root-dir)))

;; (setq package--init-file-ensured t)     ; Prevent package--ensure-init-file
;; (setq use-package-always-defer t)

(with-eval-after-load "package"
  ;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
  ;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/")))
;; (setq package-archives '(("gnu"    . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;                          ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;                          ("melpa"  . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; (defun my/compile-all-packages ()
;;   "Byte-compile all installed packages."
;;   (interactive)
;;   (dolist (elt package-alist)
;;     (package--compile (car (cdr elt)))))

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-delete-old-versions t)
  ;; (auto-package-update-prompt-before-update t)
  ;; (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

(use-package ace-jump-mode
  ;; :ensure t
  :defer t
  :commands (ace-jump-mode)
  :bind ("C-c SPC" . ace-jump-mode)
  :config (set-face-background 'ace-jump-face-foreground "yellow"))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-scope 'frame)
  (aw-dispatch-always t))

(use-package aggressive-indent
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode))

(use-package anzu
  :demand t
  :bind
  ("M-%" . anzu-query-replace)
  ("C-M-%" . anzu-query-replace-regexp)
  :custom
  (anzu-mode-lighter "")
  (anzu-search-threshold 1000)
  (anzu-replace-threshold 50)
  (anzu-replace-to-string-separator " => ")
  :config
  (global-anzu-mode +1))

(use-package ascii-table
  :commands (ascii-table))

(use-package colorful-mode
  ;; :diminish
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(use-package editorconfig
  :demand t
  :config (editorconfig-mode 1))

(use-package exec-path-from-shell
  :if (or (daemonp) (memq window-system '(x pgtk ns mac)))
  :custom
  (exec-path-from-shell-check-startup-files nil)
  :config
  (dolist (var '("PATH"
                 "MANPATH"
                 "LANG"
                 "LC_ALL"
                 "PYTHONPATH"
                 "VIRTUAL_ENV"
                 "GOPATH"
                 "GOROOT"
                 "GOMODCACHE"
                 "RUSTUP_HOME"
                 "CARGO_HOME"
                 "RUST_SRC_PATH"
                 "NODE_PATH"
                 "NVM_BIN"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(use-package envrc
  :commands (envrc-global-mode)
  :bind (:map envrc-mode-map
              ("C-c e" . envrc-command-map))
  :hook (after-init . envrc-global-mode))

(use-package eat
  :commands (eat eat-other-window)
  :preface
  (defun my/eat-cleanup-on-exit (process)
    "Kill finished Eat buffers and their window on successful exit."
    (when (zerop (process-exit-status process))
      (kill-buffer)
      (unless (eq (selected-window) (next-window))
        (delete-window))))

  (defun my/eat-project-other-window ()
    "Open Eat in the current project root using another window."
    (interactive)
    (let ((default-directory (if-let ((project (project-current)))
                                 (project-root project)
                               default-directory)))
      (call-interactively #'eat-other-window)))

  (define-prefix-command 'my/eat-prefix)
  (define-key my/eat-prefix (kbd "s") #'eat)
  (define-key my/eat-prefix (kbd "t") #'eat-other-window)
  (define-key my/eat-prefix (kbd "p") #'my/eat-project-other-window)

  :bind (("C-c t" . my/eat-prefix))
  :config
  (add-hook 'eat-exit-hook #'my/eat-cleanup-on-exit)
  (setq eat-term-scrollback-size (* 2 1024 1024)))

;; (use-package multi-term
;;   :commands (multi-term))

(use-package projectile
  :config
  (projectile-mode 1))

(use-package popper
  :bind (("C-`" . popper-toggle)
         ("M-`" . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :custom
  (popper-reference-buffers
   '("\\*Messages\\*"
     "\\*Warnings\\*"
     "\\*Backtrace\\*"
     "\\*Compile-Log\\*"
     "\\*Help\\*"
     "\\*Apropos\\*"
     "\\*grep\\*"
     "\\*rg\\*"
     "\\*Occur\\*"
     help-mode
     compilation-mode
    eat-mode
     grep-mode
     occur-mode))
  (popper-group-function #'popper-group-by-projectile)
  (popper-window-height 0.33)
  :init
  (popper-mode 1)
  (popper-echo-mode 1))

(use-package which-key
  :hook (after-init . which-key-mode)
  :custom
  (which-key-idle-delay 0.8)
  (which-key-max-description-length 32)
  (which-key-lighter nil)
  :config
  (dolist (map '(("C-c e" . "eglot/envrc")
                 ("C-c p" . "cape")
                 ("C-c t" . "terminal")
                 ("C-c y" . "yasnippet")
                 ("C-`" . "popper")
                 ("C-x t" . "tabs/treemacs")
                 ("M-s" . "search")
                 ("C-x v" . "vc")))
    (which-key-add-key-based-replacements (car map) (cdr map))))

(use-package smart-compile
  :bind ([C-f7] . smart-compile))

(use-package symon
  :config
  (setq symon-delay 2)
  ;; (symon-mode 1)
  )

(use-package undo-fu
  :config
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z")   'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package vlf
  :commands (vlf)
  :init
  (require 'vlf-setup))

(provide 'init-elpa)

;;; init-elpa.el ends here

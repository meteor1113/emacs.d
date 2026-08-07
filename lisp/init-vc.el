;;; -*- mode: emacs-lisp; coding: utf-8; -*-

;; Copyright (C) 2008- Liu Xin
;;
;; This code has been released into the Public Domain.
;; You may do whatever you like with it.
;;
;; @file
;; @author Liu Xin <meteor1113@qq.com>
;; @URL https://github.com/meteor1113/emacs.d

;;; Commentary:

;;; Code:

;; change-log-mode
(add-hook 'change-log-mode-hook 'turn-on-auto-fill)

(use-package grep
  :ensure nil
  :bind (:map grep-mode-map
              ("e" . wgrep-change-to-wgrep-mode)))

(use-package wgrep
  :after grep)

(use-package ibuffer-vc
  :hook (ibuffer . ibuffer-vc-set-filter-groups-by-vc-root)
  :config
  (setq ibuffer-show-empty-filter-groups nil))

(use-package git-link
  :commands (git-link git-link-commit))

(use-package magit
  :bind (("\C-x g" . magit-status)
         ("C-c v l" . git-link)
         ("C-c v c" . git-link-commit))
  :config
  (setq magit-diff-refine-hunk 'all))

(use-package magit-todos
  :after magit
  :config
  (magit-todos-mode 1))

(provide 'init-vc)

;;; init-vc.el ends here

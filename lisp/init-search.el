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

(defun my/consult-get-text ()
  "Get region contents or symbol at point."
  (if (use-region-p)
      (buffer-substring-no-properties (region-beginning) (region-end))
    (thing-at-point 'symbol t)))

(defun my/consult-line-with-symbol ()
  "Run `consult-line' with a sensible initial query."
  (interactive)
  (consult-line (my/consult-get-text)))

(defun my/consult-ripgrep-with-symbol ()
  "Run `consult-ripgrep' from the current project root."
  (interactive)
  (let ((root (if-let ((project (project-current)))
                  (project-root project)
                default-directory)))
    (consult-ripgrep root (my/consult-get-text))))

(defun my/consult-ripgrep-todo ()
  "Search common annotation keywords in the current project."
  (interactive)
  (let ((root (if-let ((project (project-current)))
                  (project-root project)
                default-directory)))
    (consult-ripgrep root
                     "\\(TODO\\|BUG\\|FIXME\\|HACK\\|XXX\\|NOTE\\|OPTIMIZE\\|REVIEW\\)")))

;; https://github.com/minad/consult
(use-package consult
  :bind
  (("C-s" . my/consult-line-with-symbol)
   ("C-x b" . consult-buffer)
   ("M-s l" . consult-line)
   ("M-s r" . my/consult-ripgrep-with-symbol)
   ([remap goto-line] . consult-goto-line))
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-theme :preview-key '("M-.")
   consult-buffer consult-recent-file :preview-key '("M-.")
   consult-line consult-ripgrep consult-grep :initial (my/consult-get-text)))

(use-package rg
  :if (executable-find "rg")
  :bind (("M-s ?" . rg-project)))

(use-package grep
  :ensure nil
  :bind (:map grep-mode-map
              ("e" . wgrep-change-to-wgrep-mode)))

(use-package wgrep
  :after grep)

(provide 'init-search)

;;; init-search.el ends here
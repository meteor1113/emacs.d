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

;; org
(defun init-org--setup ()
  (setq comment-start nil)
  (setq indent-tabs-mode nil)
  ;; (when (fboundp 'whitespace-mode)
  ;;   (whitespace-mode 1))
  ;; (auto-fill-mode t)
  (imenu-add-menubar-index)
  (when (featurep 'yasnippet)
    (let ((original-command (lookup-key org-mode-map [tab])))
      (setq yas-fallback-behavior `(apply ,original-command))
      (local-set-key [tab] 'yas-expand))))

(use-package org
  :custom
  (org-log-done 'time)
  (org-export-with-archived-trees t)
  (org-startup-truncated nil)
  (org-src-fontify-natively t)
  :hook (org-mode . init-org--setup)
  :bind
  (:map org-mode-map
        ([C-tab] . nil)
        ("<C-S-iso-lefttab>" . org-force-cycle-archived)
        ("<C-S-tab>" . org-force-cycle-archived)))

(provide 'init-org)

;;; init-org.el ends here

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

;; nxml-mode
(defun init-nxml--setup ()
  (set-syntax-table sgml-mode-syntax-table))

(use-package nxml
  :custom
  (nxml-bind-meta-tab-to-complete-flag t)
  :hook (nxml-mode . init-nxml--setup))

(provide 'init-xml)

;;; init-xml.el ends here

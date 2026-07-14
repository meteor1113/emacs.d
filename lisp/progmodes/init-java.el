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

;; (defun init-java--setup-style ()
;;    "Apply Java coding style for java-mode buffers."
;;    (c-set-style "java"))

;; (defun init-java--setup-jde ()
;;    "Enable JDE abbrev mode when JDE is available."
;;    (when (require 'jde nil 'noerror)
;;       (setq jde-enable-abbrev-mode t)))

;; (use-package cc-mode
;;    :hook (java-mode . init-java--setup-style))

;; (use-package jde
;;    :defer t
;;    :hook (java-mode . init-java--setup-jde))

(provide 'init-java)

;;; init-java.el ends here

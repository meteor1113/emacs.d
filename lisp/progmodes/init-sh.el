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

(use-package ansi-color
  :defer t
  :hook (shell-mode . ansi-color-for-comint-mode-on))

(provide 'init-sh)

;;; init-sh.el ends here

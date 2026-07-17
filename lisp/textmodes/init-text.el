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

;; text-mode
(defvar text-imenu-generic-expression
  `((nil ,"^ \\{0,4\\}\\([一二三四五六七八九十]+[、. )]\\)+ *[^,。，]+?$" 0)
    (nil ,"^ \\{0,4\\}\\([0-9]+[、. )]\\)+ *[^,。，]+?$" 0)))

(defun my/init-text--setup ()
  (setq imenu-generic-expression text-imenu-generic-expression)
  (imenu-add-menubar-index))

(use-package emacs
  :hook (text-mode . my/init-text--setup))

(provide 'init-text)

;;; init-text.el ends here

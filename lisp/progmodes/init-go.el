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

(use-package go-mode
  :hook (go-mode . (lambda ()
                     (add-hook 'before-save-hook #'gofmt-before-save nil t)))
  )

(provide 'init-go)

;;; init-go.el ends here

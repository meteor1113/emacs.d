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

(use-package php-mode
  :mode (("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode)
         ("\\.module\\'" . php-mode)
         ("\\.inc\\'" . php-mode)))

(provide 'init-php)

;;; init-php.el ends here

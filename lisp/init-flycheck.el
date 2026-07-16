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

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :bind (:map flycheck-mode-map
              ("C-c <f4>" . flycheck-next-error)
              ("C-c <S-f4>" . flycheck-previous-error)
              ("C-c <C-f4>" . flycheck-list-errors)))

(provide 'init-flycheck)

;;; init-flycheck.el ends here

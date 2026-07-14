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

;; flycheck
;; (add-hook 'after-init-hook
;;           '(lambda ()
;;              (ignore-errors (global-flycheck-mode t))))

(with-eval-after-load "flycheck"
  (define-key flycheck-mode-map (kbd "C-c <f4>") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-c <S-f4>") 'flycheck-previous-error)
  (define-key flycheck-mode-map (kbd "C-c <C-f4>") 'flycheck-list-errors))

;; flycheck-rust
(add-hook 'flycheck-mode-hook
          (lambda ()
            (ignore-errors (flycheck-rust-setup))))

(provide 'init-flycheck)

;;; init-flycheck.el ends here

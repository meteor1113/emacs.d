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

(use-package flymake
  :ensure nil
  :hook ((prog-mode . flymake-mode)
         (text-mode . flymake-mode))
  :bind (:map flymake-mode-map
              ("C-c <f4>" . flymake-goto-next-error)
              ("C-c <S-f4>" . flymake-goto-prev-error)
              ("C-c <C-f4>" . flymake-show-buffer-diagnostics)
              ("C-c ! l" . flymake-show-buffer-diagnostics)
              ("C-c ! n" . flymake-goto-next-error)
              ("C-c ! p" . flymake-goto-prev-error)
              ("C-c ! c" . flymake-start))
  :custom
  (flymake-no-changes-timeout nil)
  (flymake-fringe-indicator-position 'right-fringe)
  (flymake-margin-indicator-position 'right-margin))

(with-eval-after-load 'flymake
  (defun my/elisp-flymake-byte-compile (original-function &rest arguments)
    "Compile Emacs Lisp with the current configuration's load path."
    (let ((elisp-flymake-byte-compile-load-path
           (append elisp-flymake-byte-compile-load-path load-path)))
      (apply original-function arguments)))
  (advice-add 'elisp-flymake-byte-compile :around
              #'my/elisp-flymake-byte-compile))

(use-package flymake-ruff
  :hook (python-base-mode . flymake-ruff-load))

(provide 'init-flymake)

;;; init-flymake.el ends here
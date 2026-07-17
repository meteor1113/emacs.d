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

(defun my/init-prog--setup ()
  "Apply common defaults for programming buffers."
  (setq indent-tabs-mode nil)
  (ignore-errors (whitespace-mode t))
  (ignore-errors (imenu-add-menubar-index)))

(defun my/init-prog--make-executable-on-save ()
  "Make current file executable when it starts with a shebang."
  (let ((file-name (buffer-file-name)))
    (when (and file-name
               (save-excursion
                 (save-restriction
                   (widen)
                   (goto-char (point-min))
                   (looking-at "^#!")))
               (not (file-executable-p file-name)))
      (executable-make-executable file-name))))

(use-package emacs
  :hook ((prog-mode . my/init-prog--setup)
         (after-save . my/init-prog--make-executable-on-save)))

(use-package apheleia
  :hook (prog-mode . apheleia-mode)
  :config
  (setf (alist-get 'python-mode apheleia-formatters) '("black" "-"))
  (setf (alist-get 'rust-mode apheleia-formatters) '("rustfmt"))
  (setf (alist-get 'js-mode apheleia-formatters) '("prettier" "--stdin-filepath" filepath)))

(provide 'init-prog)

;;; init-prog.el ends here

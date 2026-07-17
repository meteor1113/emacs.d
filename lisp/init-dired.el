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

;; dired
(setq dired-dwim-target t)
;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;;             (define-key dired-mode-map (kbd "^")
;;               (lambda () (interactive) (find-alternate-file "..")))))

(defun my/init-dired--find-file-single-buffer (orig-fun &rest args)
  "Replace current buffer if file is a directory."
  (let ((orig (current-buffer))
        (filename (dired-get-file-for-visit)))
    (apply orig-fun args)
    (when (and (file-directory-p filename)
               (not (eq (current-buffer) orig)))
      (kill-buffer orig))))

(defun my/init-dired--up-directory-single-buffer (orig-fun &rest args)
  "Replace current buffer if file is a directory."
  (let ((orig (current-buffer)))
    (apply orig-fun args)
    (kill-buffer orig)))

(advice-add 'dired-find-file :around #'my/init-dired--find-file-single-buffer)
(advice-add 'dired-up-directory :around #'my/init-dired--up-directory-single-buffer)

;; dirvish

(provide 'init-dired)

;;; init-dired.el ends here

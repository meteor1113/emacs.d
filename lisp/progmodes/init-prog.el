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

;; prog-mode
(add-hook 'prog-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             ;; (set (make-local-variable 'whitespace-line-column) 120)
             ;; (add-to-list (make-local-variable 'whitespace-style) 'lines-tail 'append)
             ;; (set (make-local-variable 'whitespace-style) (append whitespace-style '(lines-tail)))
             (setq whitespace-style (remq 'space-mark whitespace-style))
             (ignore-errors (whitespace-mode t))
             ;; (or (ignore-errors (hideshowvis-minor-mode t)) (hs-minor-mode t))
             (hs-minor-mode t)
             (ignore-errors (imenu-add-menubar-index))))

(defun my/make-executable-on-save ()
  (let ((file-name (buffer-file-name)))
    (when (and file-name
               (save-excursion
                 (save-restriction
                   (widen)
                   (goto-char (point-min))
                   (looking-at "^#!")))
               (not (file-executable-p file-name)))
      (executable-make-executable file-name))))

(add-hook 'after-save-hook #'my/make-executable-on-save)

(provide 'init-prog)

;;; init-prog.el ends here

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

;; tab-line

(set-face-attribute 'tab-line nil :height 1.0)
;; (setq tab-line-close-tab-function 'kill-buffer)
(setq tab-line-close-tab-function
      (lambda (tab)
        (when (buffer-live-p tab)
          (if (buffer-file-name tab)
              (kill-buffer tab)
            (if (eq tab (current-buffer))
                (bury-buffer)
              (set-window-prev-buffers nil (assq-delete-all tab (window-prev-buffers)))
              (set-window-next-buffers nil (delq tab (window-next-buffers))))))))

(global-set-key [tab-line double-mouse-1]
                '(lambda ()
                   (interactive)
                   (let* ((i 1)
                          (name (format "new %d" i)))
                     (while (get-buffer name)
                       (setq i (1+ i))
                       (setq name (format "new %d" i)))
                     (switch-to-buffer name))))

(provide 'init-tabline)

;;; init-tabline.el ends here

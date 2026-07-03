;;; -*- mode: emacs-lisp; coding: utf-8; -*-

;; Copyright (C) 2008- Liu Xin
;;
;; This code has been released into the Public Domain.
;; You may do whatever you like with it.
;;
;; @file
;; @author Liu Xin <meteor1113@qq.com>
;; @URL https://github.com/meteor1113/dotemacs

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

;; (eval-after-load "tabbar-ruler"
;;   '(progn
;;      (defadvice tabbar-popup-menu (after add-menu-item activate)
;;        "Add customize menu item to tabbar popup menu."
;;        (setq ad-return-value
;;              (append ad-return-value
;;                      '("--"
;;                        ["Copy Buffer Name" (kill-new
;;                                             (buffer-name
;;                                              (tabbar-tab-value
;;                                               tabbar-last-tab)))]
;;                        ["Copy File Path" (kill-new
;;                                           (buffer-file-name
;;                                            (tabbar-tab-value
;;                                             tabbar-last-tab)))
;;                         :active (buffer-file-name
;;                                  (tabbar-tab-value tabbar-last-tab))]
;;                        ["Open Dired" dired-jump
;;                         :active (fboundp 'dired-jump)]
;;                        ["Open in Windows Explorer" (w32explore buffer-file-name)
;;                         :active (and buffer-file-name
;;                                      (eq system-type 'windows-nt)
;;                                      (require 'w32-browser nil 'noerror))]
;;                        "--"
;;                        ["Undo Close Tab" undo-kill-buffer
;;                         :active (fboundp 'undo-kill-buffer)]))))
;;      ))

(provide 'init-tabbar)

;;; init-tabbar.el ends here

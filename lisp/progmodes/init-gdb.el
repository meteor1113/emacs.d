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

;; gdb
;; (require 'gdb-ui nil 'noerror)
;; (require 'gdb-mi nil 'noerror)

(defun my/gud-break-or-remove (&optional force-remove)
  "Set/clear breakpoin."
  (interactive "P")
  (save-excursion
    (if (or force-remove
            (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint))
        (gud-remove nil)
      (gud-break nil))))

(defun my/gud-enable-or-disable ()
  "Enable/disable breakpoint."
  (interactive)
  (let ((obj))
    (save-excursion
      (move-beginning-of-line nil)
      (dolist (overlay (overlays-in (point) (point)))
        (when (overlay-get overlay 'put-break)
          (setq obj (overlay-get overlay 'before-string))))
      (if  (and obj (stringp obj))
          (cond ((featurep 'gdb-ui)
                 (let* ((bptno (get-text-property 0 'gdb-bptno obj)))
                   (string-match "\\([0-9+]\\)*" bptno)
                   (gdb-enqueue-input
                    (list
                     (concat gdb-server-prefix
                             (if (get-text-property 0 'gdb-enabled obj) "disable " "enable ")
                             (match-string 1 bptno) "\n")
                     'ignore))))
                ((featurep 'gdb-mi)
                 (gud-basic-call
                  (concat
                   (if (get-text-property 0 'gdb-enabled obj) "-break-disable " "-break-enable ")
                   (get-text-property 0 'gdb-bptno obj))))
                (t (error "No gud-ui or gui-mi?")))
        (message "May be there isn't have a breakpoint.")))))

(defun my/gud-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  ;; (set-process-query-on-exit-flag (get-buffer-process gud-comint-buffer) nil)
  ;; (kill-buffer gud-comint-buffer))
  (dolist (buffer '(gdba gdb-stack-buffer gdb-breakpoints-buffer
                         gdb-threads-buffer gdb-inferior-io
                         gdb-registers-buffer gdb-memory-buffer
                         gdb-locals-buffer gdb-assembler-buffer))
    (when (gdb-get-buffer buffer)
      (let ((proc (get-buffer-process (gdb-get-buffer buffer))))
        (when proc (set-process-query-on-exit-flag proc nil)))
      (kill-buffer (gdb-get-buffer buffer)))))

(defun my/init-gdb--deactivate-ecb-before-gdb (&rest _args)
  "If ECB is enabled, disable it before starting gdb."
  (when (and (boundp 'ecb-minor-mode) ecb-minor-mode)
    (ecb-deactivate)))

;; (defun my/gdb-tooltip-hook ()
;;   (gud-tooltip-mode 1)
;;   (let ((process (ignore-errors (get-buffer-process (current-buffer)))))
;;     (when process
;;       (set-process-sentinel process
;;                             (lambda (proc change)
;;                               (let ((status (process-status proc)))
;;                                 (when (or (eq status 'exit)
;;                                           (eq status 'signal))
;;                                   (gud-tooltip-mode -1))))))))
;; (add-hook 'gdb-mode-hook 'my/gdb-tooltip-hook)

(defun my/init-gdb--enable-tooltip ()
  "Enable tooltip support for gud in gdb buffers."
  (gud-tooltip-mode 1))

(defun my/init-gdb--disable-tooltip-after-kill (&rest _args)
  "Disable gud tooltip mode after gdb is terminated."
  (gud-tooltip-mode -1))

(defun my/init-gdb--gud-go-or-kill (&optional kill)
  "Continue program, or kill gdb when prefix argument KILL is non-nil."
  (interactive "P")
  (if kill (my/gud-kill) (gud-go)))

(advice-add 'gdb :before #'my/init-gdb--deactivate-ecb-before-gdb)
(advice-add 'gud-kill-buffer-hook :after #'my/init-gdb--disable-tooltip-after-kill)

(use-package gdb-mi
  :defer t
  :hook (gdb-mode . my/init-gdb--enable-tooltip)
  :custom
  (gdb-many-windows t)
  (gdb-use-separate-io-buffer t))

(use-package cc-mode
  :defer t
  :config
  (define-key c-mode-base-map [f5] 'gdb))

(use-package gud
  :defer t
  :config
  (define-key gud-minor-mode-map [f5] #'my/init-gdb--gud-go-or-kill)
  (define-key gud-minor-mode-map [S-f5] 'my/gud-kill)
  (define-key gud-minor-mode-map [f17] 'my/gud-kill) ; S-f5
  (define-key gud-minor-mode-map [f8] 'gud-print)
  (define-key gud-minor-mode-map [C-f8] 'gud-pstar)
  (define-key gud-minor-mode-map [f9] 'my/gud-break-or-remove)
  (define-key gud-minor-mode-map [C-f9] 'my/gud-enable-or-disable)
  (define-key gud-minor-mode-map [S-f9] 'gud-watch)
  (define-key gud-minor-mode-map [f10] 'gud-next)
  (define-key gud-minor-mode-map [C-f10] 'gud-until)
  (define-key gud-minor-mode-map [C-S-f10] 'gud-jump)
  (define-key gud-minor-mode-map [f11] 'gud-step)
  (define-key gud-minor-mode-map [C-f11] 'gud-finish))

(provide 'init-gdb)

;;; init-gdb.el ends here

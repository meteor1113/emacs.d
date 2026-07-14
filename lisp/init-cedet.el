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

;; semantic
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode
                                  global-semantic-decoration-mode
                                  ;; global-semantic-highlight-edits-mode
                                  global-semantic-show-unmatched-syntax-mode
                                  global-semantic-show-parser-state-mode))
;; (add-hook 'after-init-hook
;;           '(lambda ()
;;              (ignore-errors (semantic-mode t))))
;; (run-with-idle-timer 10 nil #'semantic-mode t)

(defun init-cedet-push-mark-semantic (orig-fun &rest args)
  "Push mark and add semantic bookmark entry."
  (semantic-mrub-push semantic-mru-bookmark-ring (point) 'mark)
  (apply orig-fun args))

(defun semantic-ia-fast-jump-back ()
  (interactive)
  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
      (error "Semantic Bookmark ring is currently empty"))
  (let* ((ring (oref semantic-mru-bookmark-ring ring))
         (alist (semantic-mrub-ring-to-assoc-list ring))
         (first (cdr (car alist))))
    ;; (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
    ;;     (setq first (cdr (car (cdr alist)))))
    (semantic-mrub-visit first)
    (ring-remove ring 0)))

(defun semantic-ia-fast-jump-or-back (&optional back)
  (interactive "P")
  (if back
      (semantic-ia-fast-jump-back)
    (semantic-ia-fast-jump (point))))

(with-eval-after-load "semantic"
  (require 'semantic/decorate/include nil 'noerror)
  (require 'semantic/bovine/el nil 'noerror)
  (require 'semantic/analyze/refs)
  (semantic-toggle-decoration-style "semantic-tag-boundary" -1)

  (when (executable-find "global")
    (semanticdb-enable-gnu-global-databases 'c-mode)
    (semanticdb-enable-gnu-global-databases 'c++-mode)
    (setq ede-locate-setup-options '(ede-locate-global ede-locate-base)))

  (when (and (eq system-type 'windows-nt)
             (executable-find "gcc"))
    (if (and (boundp 'semantic-mode) semantic-mode)
        (require 'semantic/bovine/c nil 'noerror)
      (require 'semantic-c nil 'noerror))
    (ignore-errors (semantic-gcc-setup)))

  (advice-add 'push-mark :around #'init-cedet-push-mark-semantic)
  (global-set-key [f12] 'semantic-ia-fast-jump-or-back)
  (global-set-key [C-f12] 'semantic-ia-fast-jump-or-back)
  (global-set-key [S-f12] 'semantic-ia-fast-jump-back)
  (global-set-key [mouse-2] 'semantic-ia-fast-mouse-jump)
  (global-set-key [S-mouse-2] 'semantic-ia-fast-jump-back)
  (global-set-key [double-mouse-2] 'semantic-ia-fast-jump-back)
  (global-set-key [M-S-f12] 'semantic-analyze-proto-impl-toggle))

;; pulse
(setq pulse-command-advice-flag t)    ; (if window-system 1 nil)
(add-hook 'after-init-hook
          (lambda ()
            (ignore-errors (require 'pulse nil 'noerror))))
(defun init-cedet-pulse-line-after (&rest _)
  (pulse-line-hook-function))

(defun init-cedet-pulse-line-after-interactive (&rest _)
  (when (called-interactively-p 'interactive)
    (pulse-line-hook-function)))

(defun init-cedet-pulse-line-after-distant-mark (&rest _)
  (when (and (called-interactively-p 'interactive)
             (> (abs (- (point) (mark))) 400))
    (pulse-line-hook-function)))

(with-eval-after-load "pulse"
  (add-hook 'next-error-hook 'pulse-line-hook-function)

  (dolist (fn '(switch-to-buffer previous-buffer next-buffer ido-switch-buffer))
    (advice-add fn :after #'init-cedet-pulse-line-after))

  (dolist (fn '(beginning-of-buffer goto-line find-tag tags-search
                                   tags-loop-continue pop-tag-mark
                                   imenu-default-goto-function))
    (advice-add fn :after #'init-cedet-pulse-line-after-interactive))

  (advice-add 'exchange-point-and-mark :after #'init-cedet-pulse-line-after-distant-mark)
  (advice-add 'cua-exchange-point-and-mark :after #'init-cedet-pulse-line-after-distant-mark))

(provide 'init-cedet)

;;; init-cedet.el ends here

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

;; double click highlight
(defface hl-double-click
  '((default (:inherit region))
    (((class color) (background light)) (:background "lawn green"))
    (((class color) (background dark)) (:background "green" :foreground "black")))
  "*Face used by double click highlight.")

(defun my/highlight-text (txt prop face)
  (let ((start (point-min))
        (end (point-max)))
    (remove-overlays start end prop t)
    (unless (or (not txt)
                (string= txt "")
                (string-match "^[\t\n\s]*$" txt)
                (string-match "\n" txt))
      (save-excursion
        (goto-char start)
        (while (re-search-forward txt end t)
          (let ((overlay (make-overlay (match-beginning 0) (match-end 0))))
            (overlay-put overlay 'face face)
            (overlay-put overlay prop t))
          (goto-char (match-end 0)))))))

(defun my/init-highlight--mouse-start-end (orig-fun start end mode &rest args)
  (let ((ret (apply orig-fun start end mode args)))
    (cond ((= mode 1)
           (my/highlight-text nil 'hl-double-click 'hl-double-click)
           (let* ((txt (buffer-substring-no-properties (nth 0 ret)
                                                       (nth 1 ret)))
                  (regexp (concat "\\_<" (regexp-quote txt) "\\_>")))
             (my/highlight-text regexp 'hl-double-click 'hl-double-click)))
          ((= mode 2)
           (my/highlight-text "" 'hl-double-click 'hl-double-click)))
    ret))

(advice-add 'mouse-start-end :around #'my/init-highlight--mouse-start-end)

;; (defun my/highlight-text-at-point ()
;;   (interactive)
;;   (my/highlight-text nil 'hl-at-point 'show-paren-match)
;;   (let* ((target-symbol (symbol-at-point))
;;          (txt (symbol-name target-symbol))
;;          (regexp (concat "\\_<" (regexp-quote txt) "\\_>")))
;;     (when target-symbol
;;       (my/highlight-text regexp 'hl-at-point 'show-paren-match))))

;; (global-set-key [(meta f1)] 'my/highlight-text-at-point)
;; (global-set-key (kbd "ESC <f1>") 'my/highlight-text-at-point)

(use-package symbol-overlay
  :hook ((prog-mode . symbol-overlay-mode))
  :init
  ;; (setq symbol-overlay-idle-time 0.5)
  :bind
  (("M-i" . symbol-overlay-put)
   ("M-n" . symbol-overlay-switch-forward)
   ("M-p" . symbol-overlay-switch-backward)
   ;; ("<f7>" . symbol-overlay-mode)
   ;; ("<f8>" . symbol-overlay-remove-all)
   )
  :config
  ;; (advice-add 'mouse-start-end :after
  ;;             (defun my/hl-double-click-advice (start end mode)
  ;;               (cond ((= mode 1)
  ;;                      (symbol-overlay-remove-all)
  ;;                      (symbol-overlay-put))
  ;;                     ((= mode 2)
  ;;                      (symbol-overlay-remove-all)))))
  (with-eval-after-load "pulse"
    (advice-add 'symbol-overlay-jump-next :after (lambda (&rest _) (pulse-line-hook-function)))
    (advice-add 'symbol-overlay-jump-prev :after (lambda (&rest _) (pulse-line-hook-function)))
    (advice-add 'symbol-overlay-switch-forward :after (lambda (&rest _) (pulse-line-hook-function)))
    (advice-add 'symbol-overlay-switch-backward :after (lambda (&rest _) (pulse-line-hook-function))))
  )

(use-package highlight-parentheses
  :hook ((prog-mode . highlight-parentheses-mode))
  :init
  (add-hook 'minibuffer-setup-hook #'highlight-parentheses-minibuffer-setup)
  )

(use-package hl-todo
  :hook (after-init . global-hl-todo-mode)
  ;; :bind (("C-c n" . hl-todo-next)
  ;;        ("C-c p" . hl-todo-previous)
  ;;        ("C-c o" . hl-todo-occur))
  :config
  )

(use-package diff-hl
  :hook ((prog-mode . turn-on-diff-hl-mode)
         (vc-dir-mode . turn-on-diff-hl-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (setq diff-hl-draw-borders nil)
  )

(use-package volatile-highlights
  :config
  (volatile-highlights-mode 1))

(provide 'init-highlight)

;;; init-highlight.el ends here

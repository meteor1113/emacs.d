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

;; hideshow
(defvar hs--overlay-keymap nil "keymap for folding overlay")

(let ((map (make-sparse-keymap)))
  (define-key map [mouse-1] 'hs-show-block)
  (setq hs--overlay-keymap map))

(setq hs-set-up-overlay
      (defun my/display-code-line-counts (ov)
        (when (eq 'code (overlay-get ov 'hs))
          (overlay-put ov 'display
                       (propertize
                        (format "...<%d>" (count-lines (overlay-start ov) (overlay-end ov)))
                        'face 'mode-line))
          (overlay-put ov 'priority (overlay-end ov))
          (overlay-put ov 'keymap hs--overlay-keymap)
          (overlay-put ov 'pointer 'hand))))

(with-eval-after-load "hideshow"
  (define-key hs-minor-mode-map [(shift mouse-2)] nil)
  (define-key hs-minor-mode-map (kbd "C-+") 'hs-toggle-hiding)
  (define-key hs-minor-mode-map (kbd "<left-fringe> <mouse-2>") 'hs-mouse-toggle-hiding))

(add-hook 'prog-mode-hook
          (lambda ()
            (hs-minor-mode t)))

;; (global-set-key (kbd "C-?") 'hs-minor-mode)

;; hideshowvis (slow?)
(use-package hideshowvis
  :hook (prog-mode . hideshowvis-enable)
  :config
  (hideshowvis-symbols)
  (defun my/hideshowvis-add-click-behavior (ov)
    (when (and (overlayp ov) (eq (overlay-get ov 'hs) 'code))
      (let* ((after (overlay-get ov 'after-string))
             (count-str (if (stringp after) after ""))
             (display-str (propertize (format "...<%s>" count-str) 'face 'hideshowvis-hidden-region-face)))
        (overlay-put ov 'display display-str)
        (overlay-put ov 'pointer 'hand)
        ;; (overlay-put ov 'mouse-face 'highlight)
        (overlay-put ov 'help-echo "mouse-1: show hidden text")
        (overlay-put ov 'keymap hs--overlay-keymap)
        (overlay-put ov 'after-string nil))))
  (advice-add 'hideshowvis-display-code-line-counts
              :after #'my/hideshowvis-add-click-behavior)
  )

(provide 'init-hideshow)

;;; init-hideshow.el ends here

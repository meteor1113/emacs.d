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

;; https://www.cnblogs.com/lanuage/p/18865128

;;; Code:

(use-package consult
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer))
  )

(use-package vertico
  :config
  (vertico-mode 1)
  (setq vertico-multiform-commands
        '((consult-line buffer)
          (consult-grep buffer))))

(use-package orderless
  :custom
  (completion-styles '(orderless partial-completion)))

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package corfu
  ;; :ensure t
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)
  :custom
  (corfu-auto t)
  ;; (corfu-auto-deply 0.2)
  )

(use-package corfu-terminal
  :after corfu
  :if (not (display-graphic-p))
  :config
  (corfu-terminal-mode 1)
  )

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )

(provide 'init-completion)

;;; init-completion.el ends here

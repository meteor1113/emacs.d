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

(use-package treemacs
  :commands (treemacs)
  :hook (window-setup-hook . treemacs))

;; (use-package treemacs-nerd-icons
;;   :autoload treemacs-nerd-icons-config
;;   :init (treemacs-nerd-icons-config))

(use-package treemacs-magit
  )

(use-package treemacs-projectile
  :after treemacs)

(provide 'init-treemacs)

;;; init-treemacs.el ends here

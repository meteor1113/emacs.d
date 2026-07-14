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

(use-package cc-mode
  :init
  (setq ff-always-try-to-create nil)
  (setq cc-search-directories '("/usr/include" "/usr/local/include/*"
                                "." "./include" "./inc"
                                "./common" "./public" "./src"
                                ".." "../include" "../inc"
                                "../common" "../public" "../src"
                                "../.." "../../include" "../../inc"
                                "../../common" "../../public" "../../src"))
  (setq w32-pipe-read-delay 0)
  (when (boundp 'magic-mode-alist)
    (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*@implementation" . objc-mode))
    (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*@interface" . objc-mode))
    (add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*@protocol" . objc-mode)))
  :config
  (let ((cflags '("-I.." "-I../include" "-I../inc"
                  "-I../common" "-I../public"
                  "-I../.." "-I../../include" "-I../../inc"
                  "-I../../common" "-I../../public")))
    (when (fboundp 'semantic-gcc-get-include-paths)
      (let ((dirs (semantic-gcc-get-include-paths "c++")))
        (dolist (dir dirs)
          (add-to-list 'cflags (concat "-I" dir))))))
  (with-eval-after-load 'ffap
    (setq ffap-c-path (append ffap-c-path cc-search-directories)))
  (with-eval-after-load 'filecache
    (file-cache-add-directory-list cc-search-directories)
    (file-cache-add-directory-recursively "/usr/include/c++")
    (file-cache-add-directory-recursively "/usr/local/include")))

(provide 'init-cc)

;;; init-cc.el ends here

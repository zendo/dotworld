;;; early-init.el --- Early Initialization -*- lexical-binding: t; -*-

;;; Commentary:
;; Vanilla Emacs configuration.

;;; Code:

;; Prevent unwanted runtime compilation for gccemacs (native-comp) users;
;; packages are compiled ahead-of-time when they are installed and site files
;; are compiled when gccemacs is installed.
(setq native-comp-jit-compilation nil)

;; Package initialize occurs automatically, before `user-init-file' is
;; loaded, but after `early-init-file'. We handle package
;; initialization, so we must prevent Emacs from doing it early!
(setq package-enable-at-startup nil)

;; In noninteractive sessions, prioritize non-byte-compiled source files to
;; prevent the use of stale byte-code. Otherwise, it saves us a little IO time
;; to skip the mtime checks on every *.elc file.
(setq load-prefer-newer noninteractive)

;; Without this, Emacs will try to resize itself to a specific column size
(setq frame-inhibit-implied-resize t)

;; A second, case-insensitive pass over `auto-mode-alist' is time wasted.
;; No second pass of case-insensitive search over auto-mode-alist.
(setq auto-mode-case-fold nil)

;; Faster to disable these here (before they've been initialized)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(push '(menu-bar-lines       . nil) default-frame-alist)
(push '(tool-bar-lines       . nil) default-frame-alist)
;; (push '(alpha-background     . 98 ) default-frame-alist)
;; (push '(scroll-bar-mode      . nil) default-frame-alist)
;; (push '(blink-cursor-mode    . nil) default-frame-alist)
;; (push '(column-number-mode   . nil) default-frame-alist)

;; Disable GUI elements
(add-hook 'before-make-frame-hook
          #'(lambda ()
              (setq inhibit-splash-screen t
                    inhibit-startup-screen t
                    inhibit-startup-message t ;关闭欢迎界面
                    inhibit-startup-buffer-menu t

                    inhibit-x-resources t
                    use-file-dialog nil
                    use-dialog-box nil
                    ;; inhibit-default-init t ;skip load default.el

                    ;; scratch buffer
                    initial-scratch-message  nil
                    initial-major-mode 'fundamental-mode

                    initial-frame-alist (quote ((fullscreen . maximized)))
                    ;; (setq default-frame-alist
                    ;;       '((height . 48)
                    ;;         (width . 83)))
                    )))

(defun display-startup-echo-area-message ()
  "Delete startup message."
  (message ""))

(org-babel-load-file (expand-file-name "init.org" user-emacs-directory))

(provide 'early-init)
;;; early-init.el ends here

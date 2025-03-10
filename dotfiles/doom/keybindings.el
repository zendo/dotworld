;;; Package --- Summary $DOOMDIR/keybindings.el -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Mouse
(blink-cursor-mode -1)               ;禁用指针闪烁
(setq mouse-yank-at-point t)         ;禁用鼠标点击粘贴
(global-unset-key (kbd "<mouse-2>")) ;禁用鼠标中键
(fset 'mouse-save-then-kill 'ignore) ;禁用鼠标右键双击剪切

;; Scroll
(pixel-scroll-precision-mode t)

(ffap-bindings)
;; (global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'undo-redo)

;; vterm or eshell
(when (featurep :system 'windows)
  (global-set-key (kbd "<f2>") '+eshell/toggle))

(when (featurep :system 'linux)
  (global-set-key (kbd "<f2>") '+vterm/toggle)
  (after! vterm
    (setq vterm-shell "zsh")
    (define-key vterm-mode-map (kbd "<f2>")  '+vterm/toggle)))

;; treemacs
(after! treemacs
  (define-key! treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

;; set-mark multiple times to expands
(use-package! smart-region
  :hook (after-init . smart-region-on))

;; (use-package! ctrlf
;;   :config (ctrlf-mode t))

(map!
 "C-\\" #'align-regexp
 "M-s" #'avy-goto-word-1 ;默认 isearch 被覆盖
 "<f1>" #'+treemacs/toggle
 "C-<tab>" #'consult-buffer

 "C-x C-d" #'dired-jump
 "C-c s r" #'deadgrep
 "C-c C-s" #'deadgrep
 "C-s" #'consult-line
 "C-x C-r" #'consult-recent-file
 "C-x C-b" #'consult-buffer
 "M-y" #'consult-yank-pop
 "M-m" #'consult-mark
 "C-x 4 r" #'consult-buffer-other-window
 "C-x 4 x" #'ace-swap-window
 "C-S-t" #'tab-new
 [remap other-window] #'ace-window
 [remap kill-buffer] #'kill-current-buffer

 "C-." #'hippie-expand
 "C-," #'+company/complete
 "C-/" #'comment-line ;vscode
 "C-S-i" #'lsp-format-buffer ;vscode

 "C-k" #'crux-smart-kill-line
 "C-x u" #'vundo
 "C-x l" #'ialign
 "C-x j" #'dired-jump-other-window

 "C-}" #'mc/mark-next-like-this
 "C-{" #'mc/mark-previous-like-this
 "C-|" #'mc/mark-all-like-this-dwim
 "s-<mouse-1>" #'mc/add-cursor-on-click

 "M-z" #'avy-zap-to-char
 [remap kill-ring-save] #'easy-kill
 [remap mark-sexp] #'easy-mark-sexp
 [remap mark-word] #'easy-mark-word
 [remap query-replace] 'anzu-query-replace
 [remap query-replace-regexp] 'anzu-query-replace-regexp

 "s-w" #'+hydra/window-nav/body
 "s-=" #'+hydra/text-zoom/body
 "s-d" #'dired-jump

 "s-g" #'magit-status
 ;; :map magit-status-mode-map
 ;; "p" 'magit-push
 )

;; emacs keymap
(unless (modulep! :editor evil +everywhere)
  ;; (setq doom-leader-alt-key "C-c")
  ;; (setq doom-leader-alt-key "<M-SPC>")
  (map!
   :leader
   "y" #'fanyi-dwim2
   "g" #'magit-status
   "<left>" #'winner-undo
   "<right>" #'winner-redo
   "<SPC>" #'project-find-file
   "C-<SPC>" #'project-find-file
   "," #'consult-buffer
   "." #'find-file
   "/" #'consult-ripgrep
   :prefix ("-" . "remove-lists")
   "b" #'bookmark-delete
   "r" #'recentf-edit-list
   "p" #'project-forget-project
   :prefix ("b" . "buffer")
   "b" #'consult-buffer
   "k" #'kill-current-buffer
   "K" #'crux-kill-other-buffers
   "s" #'save-some-buffers
   "l" #'+ibuffer/open-for-current-workspace
   :prefix ("f" . "file")
   "<f2>" #'rename-visited-file
   "s" #'save-some-buffers
   :prefix ("z" . "zap")
   "SPC" #'just-one-space
   "z" #'avy-zap-to-char
   :prefix ("m" . "multiple-cursors")
   "l" #'goto-last-change
   "'" #'er/mark-inside-quotes
   "[" #'er/mark-inside-pairs
   :prefix ("w" . "window")
   "x" #'ace-swap-window
   "v" #'rotate-layout
   ))

;; evil keymap
(when (modulep! :editor evil +everywhere)
  (map!
   :niv "C-=" #'expreg-expand
   :niv "C-y" #'yank
   :niv "C-k" #'crux-smart-kill-line
   :niv "C-e" #'end-of-line
   :leader
   "y" #'fanyi-dwim2
   "<left>" #'next-buffer
   "<right>" #'previous-buffer
   :prefix ("-" . "remove-lists")
   "b" #'bookmark-delete
   "r" #'recentf-edit-list
   "p" #'projectile-remove-known-project
   :prefix ("f" . "file")
   "<f2>" #'crux-rename-file-and-buffer
   :prefix ("w" . "window")
   "0" #'delete-window
   "1" #'delete-other-windows
   "2" #'split-window-vertically
   "3" #'split-window-horizontally
   "," #'winner-undo
   "." #'winner-redo
   "x" #'ace-swap-window
   "v" #'rotate-layout
   :prefix ("z" . "zap")
   "SPC" #'just-one-space
   ))

;; 新建 window 并切换过去
(global-set-key (kbd "C-x 2")
                (lambda()
                  "split windows and switch"
                  (interactive)
                  (split-window-below)
                  (select-window (next-window))))
(global-set-key (kbd "C-x 3")
                (lambda()
                  "split windows and switch"
                  (interactive)
                  (split-window-right)
                  (select-window (next-window))))

;; M-backspace 删除而非剪切
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))
(global-set-key [remap backward-kill-word] #'backward-delete-word)

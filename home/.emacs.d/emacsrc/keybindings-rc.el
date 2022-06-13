;; Keybidings
(global-set-key (kbd "C-<tab>") 'other-window) ;; chenge focus window
(global-set-key (kbd "M-<down>") 'enlarge-window)
(global-set-key (kbd "M-<up>") 'shrink-window)
(global-set-key (kbd "M-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<right>") 'shrink-window-horizontally)
;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Ident region
(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)

;; General keybinding
(use-package general :ensure t
  :config (general-evil-setup t))
(nvmap :prefix "SPC"
       "SPC"   '(counsel-M-x :which-key "M-x")
       "."     '(find-file :which-key "Find file")
       "h r r" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
       ;; Buffers
       "b b"   '(ibuffer :which-key "Ibuffer")
       "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
       "b k"   '(kill-current-buffer :which-key "Kill current buffer")
       "b n"   '(next-buffer :which-key "Next buffer")
       "b p"   '(previous-buffer :which-key "Previous buffer")
       "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K"   '(kill-buffer :which-key "Kill buffer")
       "b s"   '(switch-to-buffer :which-key "switch-to-buffer")
       ;; Dired
       "d d" '(dired :which-key "Open dired")
       "d j" '(dired-jump :which-key "Dired jump to current")
       ;; LSP
       "l l" '(lsp :wich-key "lsp")
       "l c" '(company-mode :which-key "Company-Mode")
       "l t" '(treemacs-select-directory :which-key "TreeMacs")
       ;; Snippets
       "s n" '(yas-new-snippet :which-key "New snippet")
       ;; Terminal
       "t t" '(term :which-key "term")
       "t e" '(eshell :which-key "eshell")
       ;; Window splits
       "w q"   '(evil-window-delete :which-key "Close window")
       "w n"   '(evil-window-new :which-key "New window")
       "w h"   '(evil-window-split :which-key "Horizontal split window")
       "w v"   '(evil-window-vsplit :which-key "Vertical split window")
       ;; Window
       "w f"   '(toggle-frame-fullscreen :which-key "Fullscreen")
       "w m"   '(toggle-frame-maximized :which-key "Maximized")
       ;; Markdown
       "m p"   '(markdown-live-preview-mode :which-key "Live Preview")
       ;; Magit
       "g g"   '(magit-status :which-key "Magit Status")
       )

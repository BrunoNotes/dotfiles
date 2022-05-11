(setq inhibit-startup-screen t) ; Remove start screen

(require 'package)
(add-to-list 'package-archives '
	     ;; Melpa package repository
	     ("melpa" . "https://melpa.org/packages/")) 
(package-refresh-contents)
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Download Evil (vim like navigation)
(use-package evil
  :ensure t
  :init
  (progn
    (setq evil-want-keybinding nil)
    )
  :config (evil-mode 1))
;; Evil navigation for other parts
(use-package evil-collection
  :after evil
  :ensure t
  :config (evil-collection-init))

(global-display-line-numbers-mode 1) ; Show line number
(global-visual-line-mode 1) ; Makes lines wrap at word boundaries 

;(menu-bar-mode -1) ; Disable menu-bar
(tool-bar-mode -1) ; Disable tool-bar

;; “Interactively DO things” autocompletion
(ido-mode 1) 
(ido-everywhere 1)

;; Install Smex - ido like M-x completion
(use-package smex :ensure t)

;; Set the smex keybidings
(require 'smex) 
(global-set-key (kbd "M-x") 'smex) 
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; This is your old M-x.

;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; Which key - show the keybidings associated with a command
(use-package which-key :ensure t)
(require 'which-key)
(which-key-mode 1) ; Start wich key

;; General keybinding
(use-package general :ensure t
  :config (general-evil-setup t))

(nvmap :prefix "SPC"
       "SPC"   '(smex :which-key "M-x")
       "."     '(find-file :which-key "Find file")
       ;; Buffers
       "b b"   '(ibuffer :which-key "Ibuffer")
       "b c"   '(clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
       "b k"   '(kill-current-buffer :which-key "Kill current buffer")
       "b n"   '(next-buffer :which-key "Next buffer")
       "b p"   '(previous-buffer :which-key "Previous buffer")
       "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
       "b K"   '(kill-buffer :which-key "Kill buffer"))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode 1))

;; Dashboard
(use-package dashboard
  :ensure t
  :init      ;; tweak dashboard config before loading it
  ;(setq dashboard-set-heading-icons t)
  ;(setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Welcome do Emacs!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;(setq dashboard-startup-banner "~/.emacs.d/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          ;(agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          ;(registers . 3)
			  ))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
			      (bookmarks . "book"))))
;; Ensure that emacsclient always opens on dashboard rather than scratch.
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))

;; Theme

;; Theme - added automaticaly
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(vscode-dark-plus))
 '(custom-safe-themes
   '("6c4c97a17fc7b6c8127df77252b2d694b74e917bab167e7d3b53c769a6abb6d6" "0cce5c3627e626a8ab64cc849073ed4d92b45d4ad16af2ccd849f56bf5187b37" default))
 '(package-selected-packages
   '(vscode-dark-plus-theme vs-dark-theme projectile dashboard evil-collection general wich-key evil smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

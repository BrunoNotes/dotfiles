;; Adding Melpa package repository
(require 'package)
(add-to-list 'package-archives 
  '("melpa" . "https://melpa.org/packages/")) 
(package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))
(package-refresh-contents)

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Remove Start screen
(setq inhibit-startup-screen t)

;; Auto complete ()
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

(global-display-line-numbers-mode 1) ; Show line number
(global-visual-line-mode 1) ; Makes lines wrap at word boundaries 
;(menu-bar-mode -1) ; Disable menu-bar
(tool-bar-mode -1) ; Disable tool-bar

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Disable line numbers for some modes
(dolist (mode '(
		treemacs-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; “Interactively DO things” autocompletion
(ido-mode 1) 
(ido-everywhere 1)

;; Ivy completion
(use-package ivy
  :ensure t
  :bind (
	 :map ivy-minibuffer-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
	 )
  :config
  (ivy-mode))
(use-package counsel
  :after ivy
  :ensure t
  :config (counsel-mode))
(use-package ivy-rich
  :after ivy
  :ensure t
  :config
  (ivy-rich-mode 1)) ;; this gets us descriptions in M-x.

;; no-littering - makes the folder more clean
(use-package no-littering :ensure t)
(require 'no-littering)
;; auto save with no littering
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

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
;; Auto comment
(use-package evil-nerd-commenter
  :ensure t
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; zoom in/out like we do everywhere else.
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; Which key - show the keybidings associated with a command
(use-package which-key :ensure t)
(require 'which-key)
(which-key-mode 1) ; Start wich key

;; Dired
(use-package dired
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  )
(with-eval-after-load 'dired
  ;; Vim keybinding for dired
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file)
  )

;; LSP Mode - code completion
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l") 
  :config
  (lsp-enable-which-key-integration t))
;; Treemacs - tree style folders
(use-package lsp-treemacs
  :ensure t
  :after lsp)
;; Company
(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0)
)

;; Other languages

;; TypeScript
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred))

;; VUE Js
(use-package vue-mode
  :ensure t
  :mode "\\.vue\\'"
  :hook (vue-mode . lsp-deferred))


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

;; Move customization varables to a separate file and load it
(setq custom-file (locate-user-emacs-file "Custom-vars.el"))

(load custom-file 'noerror 'nomessage)

;; Doom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; All the icons
(use-package all-the-icons
  :ensure t)

;; Theme
(use-package vscode-dark-plus-theme
  :ensure t
  :config
  (load-theme 'vscode-dark-plus t))

;; (use-package gruber-darker-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruber-darker t))

;; Font
(set-frame-font "SauceCodePro Nerd Font")

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
       ;;Dired
       "d d" '(dired :which-key "Open dired")
       "d j" '(dired-jump :which-key "Dired jump to current")
       ;; LSP
       "l l" '(lsp :wich-key "lsp")
       "l c" '(company-mode :which-key "Company-Mode")
       "l t" '(treemacs-select-directory :which-key "TreeMacs")
       )

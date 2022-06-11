;; no-littering - makes the folder more clean
(use-package no-littering :ensure t)
(require 'no-littering)

;; auto save with no littering
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

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
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init t)
  :custom (evil-collection-setup-minibuffer t)
    )

;; Auto comment
(use-package evil-nerd-commenter
  :ensure t
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; Which key - show the keybidings associated with a command
(use-package which-key
  :ensure t
  :config (which-key-mode)
  )

;; Dired
(use-package dired
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  )
(with-eval-after-load 'dired
  ;; Vim keybinding for dired
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-find-file)
  )

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode 1))

;; Terminal
(use-package term
  :config
  (setq explicit-shell-file-name "zsh"))
(use-package eterm-256color
  :ensure t
  :hook (term-mode . eterm-256color-mode))

;; Eshell
(defun rc/configure-eshell ()
  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size         1000
        eshell-buffer-maximum-lines 1000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell
  :hook (eshell-first-time-mode . rc/configure-eshell)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim"))))

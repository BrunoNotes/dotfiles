;; LSP Mode - code completion
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l") 
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ui
    :ensure t
    :hook (lsp-mode . lsp-ui-mode))

;; Treemacs - tree style folders
(use-package lsp-treemacs
  :ensure t
  :after lsp)
;; Disable line numbers for some modes
(dolist (mode '(
		treemacs-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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
  (company-idle-delay 0.1)
)
(add-hook 'after-init-hook 'global-company-mode)

;; Flycheck - Syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

;; Magit - Git
(use-package magit
  :ensure t
  )
(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/etc/yasnippet/snippets" ;Personal snippet
          ))
  (yas-global-mode 1)
  )

;; ----- Other languages -----

;; Markdown
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
    )
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))


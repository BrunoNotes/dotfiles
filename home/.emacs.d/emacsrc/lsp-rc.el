;; LSP Mode - code completion
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ui
    :ensure t
    :hook (
           (lsp-mode . lsp-ui-mode)
           )
    )

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

;; Yasnippet
(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/etc/yasnippet/snippets" ;Personal snippet
          ))
  (yas-global-mode 1)
  )


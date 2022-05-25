;; LSP Mode - code completion
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . efs/lsp-mode-setup)
         (html-mode . lsp-deferred)
         (css-mode . lsp-deferred)
    )
  :init
  (setq lsp-keymap-prefix "C-c l") 
  :config
  (lsp-enable-which-key-integration t))
(use-package lsp-ui
    :ensure t
    :commands (lsp-ui-mode))

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
  :init (global-company-mode t)
)

;; Flycheck - Syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

;; Auto formatter
(use-package apheleia
  :ensure t
  :init (apheleia-global-mode 1)
  )

;; ----- Other languages -----

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

;; Yaml
(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'"
  :hook (yaml.mode . lsp-deferred))

;; Lua
(use-package lua-mode
  :ensure t
  :mode "\\.lua\\'"
  :hook (lua.mode . lsp-deferred))

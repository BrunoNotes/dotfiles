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
  :mode "\\.md\\'"
  )
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2)))))

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

;; Rust
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :hook (rust.mode . lsp-deferred)
  )
(use-package rustic
        :ensure t)


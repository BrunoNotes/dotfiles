;; Adding Melpa package repository
(require 'package)
(add-to-list 'package-archives 
  '("melpa" . "https://melpa.org/packages/")) 
(package-initialize)
(package-refresh-contents)

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;; ----- IMPORTS -----

;; LSP Mode - code completion
(load "~/.emacs.d/emacsrc/lsp-rc.el")
;; Misc
(load "~/.emacs.d/emacsrc/misc-rc.el")
;; Keybidings
(load "~/.emacs.d/emacsrc/keybindings-rc.el")
;; Themes
(load "~/.emacs.d/emacsrc/theme-rc.el")

;; ----- Config -----

;; Remove Start Screen
(setq inhibit-startup-screen t)
;; tab indent to 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; Auto complete ()
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)
;; Move customization varables to a separate file and load it
(setq custom-file (locate-user-emacs-file "Custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Show line number
(global-display-line-numbers-mode 1) ; Show line number
;; Makes lines wrap at word boundaries
(global-visual-line-mode 1)  
;; Disable tool bar
(tool-bar-mode -1)
;; “Interactively DO things” autocompletion
(ido-mode 1) 
(ido-everywhere 1)
;; Disable line numbers for some modes
(dolist (mode '(
		treemacs-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

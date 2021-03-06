;; Adding Melpa package repository
(require 'package)
(add-to-list 'package-archives 
  '("melpa" . "https://melpa.org/packages/")) 
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; ----- Update -----

;; Run the command to see the packages:
;; M-x list-packages
;; Hit "U" to mark available upgrades, then "x" to upgrade

;; To delete older versions run:
;; M-x package-autoremove

;; ----- IMPORTS -----

;; LSP Mode - code completion
(load "~/.emacs.d/emacsrc/lsp-rc.el")
;; Other programming languages
(load "~/.emacs.d/emacsrc/lang-rc.el")
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
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)
;; Makes lines wrap at word boundaries
(global-visual-line-mode 0) ; change to 1 to wrap
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default truncate-lines 1) ; change to 0 to wrap
;; Disable tool bar
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
;; “Interactively DO things” autocompletion
(ido-mode 1) 
(setq ido-everywhere 1)
(setq ido-enable-flex-matching 1)

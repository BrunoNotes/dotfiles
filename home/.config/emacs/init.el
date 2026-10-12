(setq custom-file "~/.emacs.custom.el")

(setq inhibit-startup-message 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(ido-mode 1)
(ido-everywhere 1)

(setq-default display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

; configure package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

; download packages
(unless (package-installed-p 'evil)
  (package-install 'evil))

; packages config
(require 'evil)
(evil-mode 1)

(use-package tokyo-night
  :ensure t
  :init
  (load-theme 'tokyo-night t))

(setq background_color "#121212")
(set-face-attribute 'default nil :background background_color)
(set-face-attribute 'fringe nil :background background_color)
(set-face-attribute 'line-number nil :background background_color)
(set-face-attribute 'line-number-current-line nil :background background_color)
; (set-face-attribute 'mode-line nil :background background_color :box nil)
; (set-face-attribute 'mode-line-inactive nil :background background_color :box nil)

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font-13")

; keybindings

(gobal-set-key (kbd "<escape>") 'keyboard-escape-quit)

(load custom-file)

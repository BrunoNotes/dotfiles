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

;; Doom modeline
(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1))

;; All the icons
(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . all-the-icons-dired-mode))

;; Theme

;; (use-package gruber-darker-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruber-darker t))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tokyo-night t)
  ;; (load-theme 'doom-dark+ t)
  )

;; Font
(set-frame-font "SauceCodePro Nerd Font 12")

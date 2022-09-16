;;
(package-initialize)
;;(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(setq custom-file (concat user-emacs-directory "custom-settings.el"))
(setq use-package-always-ensure t)
(load custom-file t)

(defvar my/laptop-p (equal (system-name) "nicola-20aws0a500"))

(setq user-full-name "Nicola Gramola"
      user-mail-address "nicola.gramola@gmail.com")

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(unless (assoc-default "elpa" package-archives)
  (add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t))
(unless (assoc-default "nongnu" package-archives)
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(require 'use-package)

;; Useful defaults
(use-package emacs
  :init
  ;; <OPTIONAL> Setting my favorite fonts here. You can replace "Roboto" with your favorite font.
  ;; You can also also adjust the size of the font with the "height" here under.
  ;; (set-face-attribute 'default nil :family "Roboto Mono" :height 110 :weight 'regular)
  ;; (set-face-attribute 'fixed-pitch nil :family "Roboto Mono" :height 110 :weight 'medium)
  ;; (set-face-attribute 'variable-pitch nil :family "Roboto Regular" :height 110 :weight 'medium)
  :config
  (setq-default cursor-type 'bar)              ; Line-style cursor similar to other text editors
  (setq inhibit-startup-screen t)              ; Disable startup screen (the welcome to Emacs message)
  ;; (setq initial-scratch-message "")	       ; Make *scratch* buffer blank
  (setq-default frame-title-format '("%b"))    ; Make window title the buffer name
  ;; (setq confirm-kill-processes nil)            ; Stop confirming the killing of processes
  (setq use-short-answers t)	               ; y-or-n-p makes answering questions faster
  (show-paren-mode t)	                       ; Visually indicates pair of matching parentheses
  (delete-selection-mode t)                    ; Start writing straight after deletion
  (setq read-process-output-max (* 1024 1024)) ; Increase the amount of data which Emacs reads from the process
  (global-hl-line-mode 1))

;; (use-package better-defaults)

;; (use-package auto-compile
;;   :if my/laptop-p
;;   :config (auto-compile-on-load-mode))
;; (setq load-prefer-newer t)

;; autocoplete
(use-package company
  :diminish
  :init (global-company-mode)
  :config (setq company-backends
		'((company-files         ; files & directory
		   company-keywords      ; keywords
		   company-capf)         ; completion-at-point-functions
		  (company-abbrev company-dabbrev)
		  ))

(use-package company-statistics
    ;; :straight t
    :init (company-statistics-mode))

(use-package company-web)

(use-package company-try-hard
    :bind    (("C-<tab>" . company-try-hard)
	      :map company-active-map
	      ("C-<tab>" . company-try-hard)))
(use-package company-quickhelp
    :config (company-quickhelp-mode))
     
;; (use-package company-posframe
;;   :if my/laptop-p
;;   :init (company-posframe-mode 1)
;;   :diminish
;;   )
)
  
;; 
(use-package neotree
  :config (global-set-key [f8] 'neotree-toggle)
  ;; :config (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )

;; python
;; (use-package elpy
;;   :bind (:map elpy-mode-map
;; 	      ("C-M-n" . elpy-nav-forward-block)
;; 	      ("C-M-p" . elpy-nav-backword-block))
;;   :hook ((elpy-mode . flycheck-mode)
;; 	 (elpy-mode . (lambda()
;; 			(set (make-local-variable 'company-backends)
;; 			     '((elpy-company-backend ::with company-yasnippet))))))
;;   :config (setq elpy-rpc-virtualenv-path 'current)
;;   ;; :ensure t
;;   :init (elpy-enable))

;; (use-package flycheck
;;   :config (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   :config (add-hook 'elpy-mode-hook 'flycheck-mode))


;;; <EGLOT> configuration, pick this or the LSP configuration but not both.
;; Using Eglot with Pyright, a language server for Python.
;; See: https://github.com/joaotavora/eglot.
(use-package eglot
  :ensure t
  :defer t
  :hook (python-mode . eglot-ensure))



(use-package magit)


(use-package org)


(use-package multiple-cursors)

;; Themes
(use-package monokai-theme)
(use-package material-theme
  :init (load-theme 'material))
(use-package melancholy-theme)


;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

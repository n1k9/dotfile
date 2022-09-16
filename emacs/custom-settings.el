;; custom-settings.el
(if (display-graphic-p)
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)
            ;; (background-color . "honeydew")
            (width . 100)
            (height . 48)
            ;; (left . 50)
            ;; (top . 50)
            ))
  (setq initial-frame-alist '( (tool-bar-lines . 0))))
;; (tool-bar-mode -1)
(display-time-mode 1)
(global-linum-mode 1)

;;
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-;") 'comment-region)
;; (global-set-key (kbd "C-c m c") 'mc/edit-lines)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

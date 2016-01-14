(require-package 'better-defaults)
(global-set-key (kbd "<C-tab>") 'bury-buffer)


;; ============================
;; Setup shell stuff
;; ============================
;; Commented out for now, not necessary?
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun rename-eshell ()
 (if (not (equal (buffer-name) "eshell"))
     (rename-buffer "eshell" t)))
(add-hook 'eshell-mode-hook
 '(lambda ()
   (rename-eshell)
   (define-key eshell-mode-map [?\C-c r] 'eshell-isearch-backward)))

(set 'eshell-hist-ignoredups t)
(setq eshell-cmpl-cycle-completions nil)


;; ============================
;; Key mappings
;; ============================

;; use F1 key to go to a man page
(global-set-key [f1] 'man)
;; use F3 key to kill current buffer
;(global-set-key [f3] 'kill-this-buffer)
;; use F5 to get help (apropos)
;(global-set-key [f5] 'apropos)
;; use F9 to open files in hex mode
;(global-set-key [f9] 'hexl-find-file)

;; goto line function C-c C-l, C-x g
;(global-set-key [ (control c) (control l) ] 'goto-line)
;(global-set-key [ (control x) (g) ] 'goto-line)
(global-set-key [ (control x) (control g) ] 'goto-line)

;; word completion
(global-set-key [(control \')] ' dabbrev-expand)

;;;; undo and redo functionality with special module
;;(require 'redo)
;;(global-set-key (kbd "C-x C-r") 'redo)
;;(global-set-key [ (control x) (r)] 'redo)
;;(global-set-key [ (control x) (control u)] 'undo)



(toggle-frame-fullscreen)

(provide 'init-local)

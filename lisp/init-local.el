(require-package 'better-defaults)
(global-set-key (kbd "<C-tab>") 'bury-buffer)
(global-set-key (kbd "<M-q>") 'bury-buffer)


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

;; ====================================
;; Encoding/Descoding of property files
;; ====================================
(setq js-unicode-mappings
  '(
   ("Å" "\\u00C5")
   ("Ä" "\\u00C4")
   ("Ö" "\\u00D6")
   ("å" "\\u00E5")
   ("ä" "\\u00E4")
   ("ö" "\\u00F6")
  )
)


(defun js-replace-all(from to)
   (save-excursion
      (save-restriction
        (let ((case-fold-search nil))
          (goto-char (point-min))
          (while (search-forward from nil t)
            (replace-match to t t)
          )
        )
      )
   )
)

(defun js-unicode-encode ()
   "Encode swedish characters as unicode ascii"
   (interactive)
   (let ((list js-unicode-mappings))
     (while list
       (js-replace-all (nth 0 (car list)) (nth 1 (car list)))
       (setq list (cdr list))
     )
  )
)
(defun js-unicode-encode-conditional ()
   "Encode swedish characters as unicode ascii"
   (if (y-or-n-p "Encode swedish characters with unicode ascii?")
      (js-unicode-encode )
   )
)

(defun js-unicode-decode ()
   "Decode unicodes ascii to swedish characters"
   (interactive)
   (let ((list js-unicode-mappings))
     (while list
       (js-replace-all (nth 1 (car list)) (nth 0 (car list)))
       (setq list (cdr list))
     )
  )
)
(defun js-unicode-decode-conditional ()
   "Encode swedish characters as unicode ascii"
   (if (y-or-n-p "Decode unicode ascii to swedish characters?")
      (js-unicode-decode )
   )
)

(define-derived-mode resource-bundle-sv-mode conf-javaprop-mode "Resource bundle:sv"
  "Swedish resource bundle mode"
   (font-lock-mode))

(add-hook 'resource-bundle-sv-mode-hook
   '(lambda ()
      (add-hook 'before-save-hook
                'js-unicode-encode-conditional
                 nil t)
      (add-hook 'find-file-hook
                'js-unicode-decode-conditional
                 nil t)

))

(setq auto-mode-alist
      (cons '("_sv\\.properties$" . resource-bundle-sv-mode) auto-mode-alist))


(defun just-one-space-in-region (beg end)
  "replace all whitespace in the region with single spaces"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "\\s-+" nil t)
        (replace-match " ")))))

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))

(toggle-frame-fullscreen)

(provide 'init-local)

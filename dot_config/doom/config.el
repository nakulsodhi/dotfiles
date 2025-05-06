(setq doom-localleader-key ",")

(setq doom-theme 'modus-vivendi)

(setq display-line-numbers-type `relative)

(setq which-key-idle-delay 0.5)

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))

(setq org-directory "~/notes/org-mode/")
(setq org-roam-directory "~/notes/org-mode/")

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

 (defun enable-word-processor-minor-modes ()
    (setq line-spacing 0.15)
    ;;(pixel-scroll-precision-mode)
    (smartparens-mode)
    (visual-line-mode))
  ;;  (add-hook 'window-size-change-functions 'org-image-resize)
  (add-hook 'text-mode-hook 'enable-word-processor-minor-modes)
  ;;(add-hook 'org-mode-hook 'org-appear-mode)
  (add-hook 'org-mode-hook 'org-roam-db-autosync-enable)
  (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)
  (setq org-habit-show-habits-only-for-today nil)
  (setq org-agenda-files (directory-files-recursively "~/OneDrive/org-mode/" "\\.org$"))
(setq org-pretty-entities t)
(setq org-hide-emphasis-markers t)
(setq org-startup-folded 'content)
(setq org-ellipsis " ") ;; folding symbol

(setq-default major-mode 'org-mode)

(setq org-appear-autolinks t)
(setq org-appear-autoentities t)
(setq org-appear-autosubmarkers t)
(setq org-appear-autokeywords t)
(setq org-appear-inside-latex t)

;; It's cool to have appear only work in insert mode, gonna leave in automatic for now
;; (setq org-appear-trigger 'manual)
;; (add-hook 'org-mode-hook (lambda ()
;;                           (add-hook 'evil-insert-state-entry-hook
;;                                     #'org-appear-manual-start
;;                                     nil
;;                                     t)
;;                           (add-hook 'evil-insert-state-exit-hook
;;                                     #'org-appear-manual-stop
;;                                     nil
;;                                     t)))

(set-frame-parameter nil 'alpha-background 0.6)

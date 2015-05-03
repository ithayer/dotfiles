(add-to-list 'load-path "/Users/ignaciothayer/.emacs.d/")

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "grey20" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :height 107))))
 '(cursor ((t (:background "white"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "red" :weight bold)))))

(global-set-key (kbd "C-x C-c") (lambda () (interactive) (message "Quick exit disabled, try M-x kill-emacs")))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Small Visual Stuff

(tabbar-mode -1)
(setq inhibit-splash-screen t)
(setq font-lock-maximum-decoration 3)
(show-paren-mode 1)
(scroll-bar-mode -1)
(setq global-hl-line-mode t)
(blink-cursor-mode 0)

(set-default 'truncate-lines t)
(setq truncate-partial-width-windows nil)
(display-time-mode t)

;; When splitting windows, put them side-by-side instead of one above the other.
(setq split-width-threshold 160) ;; Don't split them too small
(setq split-height-threshold nil)

(setq pop-up-windows nil)

(global-linum-mode 1)
;; open *help* in current frame
(setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MELPA

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keys

;; Remove Aquamacs settings for A-{, A-}, which cycled
;; buffers, to cycle windows instead.

(define-key osx-key-mode-map (kbd "A-{") nil)
(global-set-key (kbd "A-{") 'previous-multiframe-window)
(define-key osx-key-mode-map (kbd "A-}") nil)
(global-set-key (kbd "A-}") 'next-multiframe-window)

;; Set Fn to be hyper
(setq ns-function-modifier 'hyper)

(global-set-key [insert] 'copy-region-as-kill)
(global-set-key [C-insert] 'yank)

(global-set-key (kbd "C-M-<up>") '(lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "C-M-<down>") '(lambda () (interactive) (scroll-up 1)))

(global-set-key (kbd "<f1>") '(lambda ()
                                (interactive)
                                (progn
                                  (other-window 1)
                                  (shell))))

(global-set-key (kbd "<f12>") 'slime-eval-defun)
(global-set-key (kbd "C-<f12>") 'slime-repl-resend)

(global-set-key (kbd "C-S-w") 'copy-region-as-kill)
;; Copy line
(global-set-key (kbd "C-S-K") '(lambda () (interactive)
                               (save-excursion
                                 (kill-ring-save
                                  (line-beginning-position)
                                  (line-end-position)))))

(global-set-key (kbd "H-g") 'goto-line)
(global-set-key (kbd "H-d") '(lambda () (interactive)
                                    (find-file "~/org/daily.org")))

(require 'expand-region)
(global-set-key (kbd "H-r") 'er/expand-region)

(global-set-key (kbd "A-H-R") '(lambda () (interactive)
                                 (message (format "Reverting from: %s" buffer-file-name))
                                 (revert-buffer nil t)))

(global-set-key (kbd "H-m") 'mc/mark-all-dwim)


;; Occur mode?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indent

(setq-default indent-tabs-mode nil) ;; from http://dotfiles.org/~benjamn/.emacs
;;(setq-default tab-width 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Paredit

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "<C-S-]>") 'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "<C-S-[>") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "<C-left>") 'backward-word)
     (define-key paredit-mode-map (kbd "<C-right>") 'forward-word)
     (define-key paredit-mode-map (kbd "C-<") 'backward-sexp)
     (define-key paredit-mode-map (kbd "C->") 'forward-sexp)))

(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'cider-mode-hook 'enable-paredit-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files '("~/org"))

;;
;; ace jump mode major function
;; 
(require 'ace-jump-mode)
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "H-a") 'ace-jump-char-mode)
;; 
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "H-M-a") 'ace-jump-mode-pop-mark)


;; ns-right-command-modifier

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tramp
(require 'tramp)
(setq tramp-default-method "ssh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clojure mode

(require 'clojure-mode)
(define-clojure-indent
  (-> 0)
  (->> 0))

(add-hook 'clojure-mode-hook 'enable-paredit-mode)
(add-hook 'clojure-mode-hook 'aggressive-indent-mode)


(define-key clojure-mode-map [tab] '(lambda ()
                                      (interactive)
                                      (indent-for-tab-command)
                                      (indent-sexp)))
(require 'clojure-mode-extra-font-locking)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Uniquify

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ido

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit

(define-key osx-key-mode-map (kbd "A-g") nil) ;; A-g did repeat-last-isearch on this map, not that useful.
(global-set-key (kbd "A-g") 'magit-status)
(define-key osx-key-mode-map (kbd "A-G") nil) ;; A-g did repeat-last-isearch on this map, not that useful.
(global-set-key (kbd "A-G") '(lambda ()
                               (interactive)
                               (magit-status "/Users/ignaciothayer/p/debtapp")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
;; FFIG

(require 'find-file-in-git-repo)
(global-set-key (kbd "<f5>") 'find-file-in-git-repo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RFZ Search

(defun rs (x)
  (interactive "srfz-search: ")
  (grep (format "%s %s" "/Users/ignaciothayer/bin/rfzsearch" x)))


(defun rfzsearch-with-symbol-at-point ()
  (interactive)
  (grep (format "%s %s" "/Users/ignaciothayer/bin/rfzsearch" (symbol-at-point))))

(global-set-key (kbd "C-7") 'rfzsearch-with-symbol-at-point)


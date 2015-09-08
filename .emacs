(add-to-list 'load-path "/Users/ignaciothayer/.emacs.d/")

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


(define-key osx-key-mode-map (kbd "A-p") nil) ;; Remove print binding

;; Set Fn to be hyper
(setq ns-function-modifier 'hyper)

(global-set-key (kbd "C-M-<up>") '(lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "C-M-<down>") '(lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "C-A-N") '(lambda ()
                                 (interactive)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)
                                 (aquamacs-next-line)))
(global-set-key (kbd "C-A-P") '(lambda ()
                                 (interactive)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)
                                 (aquamacs-previous-line)))


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

;; Keys for buffers
(global-set-key (kbd "H-b d") '(lambda () (interactive)
                                 (find-file "~/org/daily.org")))
(global-set-key (kbd "H-b r") '(lambda () (interactive)
                                 (switch-to-buffer-here "*cider-repl app*")))

(require 'expand-region)
(global-set-key (kbd "H-r") 'er/expand-region)

(global-set-key (kbd "A-H-R") '(lambda () (interactive)
                                 (message (format "Reverting from: %s" buffer-file-name))
                                 (revert-buffer nil t)))

(require 'multiple-cursors)
(global-set-key (kbd "H-m") 'mc/mark-all-dwim)

;; Occur mode?
;; C-c C-h -- brings up help for prefix map

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indent

(setq-default indent-tabs-mode nil) ;; from http://dotfiles.org/~benjamn/.emacs
;;(setq-default tab-width 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Paredit

(require 'paredit)

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "<C-}>") 'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "<C-{>") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "<C-left>") 'backward-word)
     (define-key paredit-mode-map (kbd "<C-right>") 'forward-word)
     (define-key paredit-mode-map (kbd "C-<") 'backward-sexp)
     (define-key paredit-mode-map (kbd "C->") 'forward-sexp)
     ))

;; Make m-backspace not do backward kill word because that screws up balanced parens.
(define-key paredit-mode-map (kbd "<M-backspace>") 'paredit-backward-kill-word)
(define-key paredit-mode-map (kbd "H-p") 'paredit-splice-sexp-killing-backward)

;; old
;; (defhydra hydra-paredit (paredit-mode-map "H-p")
;;   "Paredit"
;;   ("s" paredit-splice-sexp-killing-backward "slice"))

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

(setq org-todo-keyword-faces
           '(("TODO" . org-warning) ("STARTED" . (:foreground "black" :background "green"))
             ("BLOCKED" . (:foreground "red"))
             ("DONE" . org-done)))

(require 'org)
;; Have + act as a "censored" mode -- doesn't show unless it's on the current line (with line highlight mode).
(add-to-list 'org-emphasis-alist '("+" (:background "gray" :foreground "gray")))

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
(define-key global-map (kbd "H-.") 'ace-jump-char-mode)
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
(define-key global-map (kbd "H->") 'ace-jump-mode-pop-mark)

(setq ace-jump-mode-move-keys '(?q ?w ?e ?r ?t ?a ?s ?d ?f ?g ?z ?x ?c ?v ?b))

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

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Magit

(define-key osx-key-mode-map (kbd "A-g") nil) ;; A-g did repeat-last-isearch on this map, not that useful.
(global-set-key (kbd "A-g") 'magit-status)
(define-key osx-key-mode-map (kbd "A-G") nil) ;; A-g did repeat-last-isearch on this map, not that useful.

(global-set-key (kbd "A-G") '(lambda ()
                                 (interactive)
                                 (let ((default-directory "/Users/ignaciothayer/p/debtapp/"))
                                   (magit-status))))
(global-set-key (kbd "A-A") '(lambda ()
                               (interactive)
                               (let ((default-directory "/Users/ignaciothayer/p/avant-basic"))
                                 (magit-status))))

(setq git-commit-summary-max-length 80)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;'
;; FFIG

(require 'find-file-in-git-repo)
(global-set-key (kbd "H-f d")
                '(lambda ()
                   (interactive)
                   (let ((default-directory "/Users/ignaciothayer/p/debtapp/"))
                     (find-file-in-git-repo))))
(global-set-key (kbd "H-f a")
                '(lambda ()
                   (interactive)
                   (let ((default-directory "/Users/ignaciothayer/p/avant-basic/"))
                     (find-file-in-git-repo))))
(global-set-key (kbd "H-f g")
                '(lambda ()
                   (interactive)
                   (find-file-in-git-repo)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RFZ Search

(defun rs (x)
  (interactive "srfz-search: ")
  (grep (format "%s %s" "/Users/ignaciothayer/bin/rfzsearch" x)))


(defun rfzsearch-with-symbol-at-point ()
  (interactive)
  (grep (format "%s %s" "/Users/ignaciothayer/bin/rfzsearch" (symbol-at-point))))

(global-set-key (kbd "C-7") 'rfzsearch-with-symbol-at-point)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Avant Search

(defun as (x)
  (interactive "savant-search: ")
  (grep (format "%s %s" "/Users/ignaciothayer/bin/avantsearch" x)))

(defun avantsearch-with-symbol-at-point ()
  (interactive)
  (grep (format "%s %s" "/Users/ignaciothayer/bin/avantsearch" (symbol-at-point))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LookML mode
      
(add-to-list 'auto-mode-alist '("\\.lookml\\'" . yaml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Yasnippet

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Censoring

(defvar censor-face
  '(:foreground "black" :background "black")
  "Face to use for censoring")
 
(defun censor ()
  "Censor the current region"
  (interactive)
  (let ((overlay (make-overlay (region-beginning) (region-end))))
        (overlay-put overlay 'face censor-face)))
 
(defun censor-remove ()
  "Uncensor the current region"
  (interactive)
  (remove-overlays (region-beginning) (region-end) 'face censor-face))

;; DEMO
;;(define-key paredit-mode-map (kbd "<M-backspace>") 'paredit-backward-kill-word)
;;(define-key paredit-mode-map (kbd "<M-backspace>") nil)

;; There's also stuff in customizations.el

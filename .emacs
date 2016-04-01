;; More customizations in
;; /Users/ignaciothayer/Library/Preferences/Aquamacs Emacs/customizations.el

(add-to-list 'load-path "/Users/ignaciothayer/.emacs.d/")
(add-to-list 'load-path "/Users/ignaciothayer/.emacs.d/vendor/emacs-pry")

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

;; Occur mode
(global-set-key (kbd "H-o") 'occur)

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

(define-key org-mode-map (kbd "H-t") (lambda ()
                                       (interactive)
                                       (org-todo)))

(define-key org-mode-map (kbd "H-y") (lambda ()
                                       (interactive)
                                       (org-archive-subtree)))

(setq-default org-download-image-dir "~/org/images")

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

(defun create-branch-and-push-origin (branch start-point)
  (message (format "Creating branch '%s' from '%s'" branch start-point))
  (magit-branch-and-checkout branch start-point)
  (message (format "Pushing '%s'" branch))
  (magit-run-git-no-revert "push" "-v" "origin" branch)
  (let ((upstream (format "remotes/origin/%s" branch)))
    (message (format "Setting upstream to '%s'" upstream))
    (magit-branch-set-upstream branch upstream)))

(defun magit-create-branch-from-master (branch-name)
  (interactive "sNew branch name: ")
  (create-branch-and-push-origin branch-name "master"))

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

;; Find file in p/

(global-set-key (kbd "H-f p")
                '(lambda ()
                   (interactive)
                   (let* ((default-directory "/Users/ignaciothayer/p/")
                          (files (shell-command-to-string (format "cd %s && find avant-basic avant avant-analytics" default-directory))))
                     (find-file
                      (concat default-directory
                              (ido-completing-read
                               "find in avant repos below p/: "
                               (remove-if (lambda (x) (string= "" x))
                                          (split-string files "\n"))))))))


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
  (grep (format "%s '%s'" "/Users/ignaciothayer/bin/avantsearch" x)))

(global-set-key (kbd "H-A") '(lambda (s)
                               (interactive "sFind RE in avant repos: ")
                               (as s)))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby stuff

(require 'rvm)
(rvm-use-default)

(require 'pry)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ag

;; Search with ag in all of p.
(defun ag-p-regexp (regexp)
  (interactive (list (ag/read-from-minibuffer "Search regexp in p/")))
  (ag/search regexp (ag/project-root "/Users/ignaciothayer/p") :regexp t))

(global-set-key (kbd "H-a") '(lambda (s)
                               (interactive
                                (list
                                 (read-string
                                  (format "Find RE in project (%s): "
                                          (thing-at-point 'symbol))
                                  nil nil (thing-at-point 'symbol))))
                               (ag-project-regexp s)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SmartParens

(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "<%" "%>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enh-ruby

(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(add-hook 'enh-ruby-mode-hook 'enable-paredit-mode)

(eval-after-load "enh-ruby-mode"
  '(add-to-list 'hs-special-modes-alist
                 `(enh-ruby-mode
                   ,(rx (or "def" "class" "module" "{" "[")) ; Block start
                   ,(rx (or "}" "]" "end"))                  ; Block end
                   ,(rx (or "#" "=begin"))                   ; Comment start
                   enh-ruby-forward-sexp nil)))

(eval-after-load "enh-ruby-mode"
  '(progn (define-key enh-ruby-mode-map (kbd "C-<") 'enh-ruby-backward-sexp)
          (define-key enh-ruby-mode-map (kbd "C->") 'enh-ruby-forward-sexp)
          (define-key enh-ruby-mode-map (kbd "C-?") 'enh-ruby-up-sexp)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;(require 'ipython)
;; Didn't work the first time -- buffer local?
;;(setq py-python-command-args '("--colors=linux"))
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--colors Linux --autoindent"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(require 'python-mode)
(require 'company)
(define-key python-mode-map (kbd "H-p l") (lambda ()
                                            (interactive)
                                            (py-execute-line)))
(define-key python-mode-map (kbd "H-p p") (lambda ()
                                            (interactive)
                                            (py-execute-block)))
(define-key python-mode-map (kbd "H-p g") (lambda ()
                                            (interactive)
                                            (jedi:goto-definition)))
(define-key python-mode-map (kbd "H-x") (lambda ()
                                            (interactive)
                                            (py-execute-def-or-class)))
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(add-to-list 'company-backends 'company-jedi)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(defun paredit-space-for-delimiter-predicates-python (endp delimiter)
  "Check for python"
  nil)

(defun python-mode-paredit-hook ()
  (enable-paredit-mode)
  (add-to-list (make-local-variable 'paredit-space-for-delimiter-predicates)
               'paredit-space-for-delimiter-predicates-python))

(add-hook 'python-mode-hook 'python-mode-paredit-hook)


;;(add-hook 'python-mode 'elpy-mode)
;;(require 'company-jedi) ;; TESTING
;;(require 'autocomplete)

;; DEMO
;;(define-key paredit-mode-map (kbd "<M-backspace>") 'paredit-backward-kill-word)
;;(define-key paredit-mode-map (kbd "<M-backspace>") nil)

;; There's also stuff in customizations.el

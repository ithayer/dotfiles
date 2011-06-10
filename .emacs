(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(browse-url-browser-function (quote browse-url-firefox))
 '(recentf-max-saved-items 100)
 '(tool-bar-mode nil)
 '(transient-mark-mode t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "grey20" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :height 107 :family "misc-fixed"))))
 '(cursor ((t (:background "white"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "red" :weight bold)))))

(require 'url)
(defun search-site-url (site url keyword)
  (concat "http://www.google.com/"
	  (format "search?q=%s+site:%s+inurl:%s&btnI"  
		  (url-hexify-string keyword)  
		  (url-hexify-string site)  
		  (url-hexify-string url))))

(defun search-site (site keyword)
  (concat "http://www.google.com/"
	  (format "search?q=%s+site:%s"  
		  (url-hexify-string keyword)  
		  (url-hexify-string site))))

(defun googhelp ()
  ""
  (interactive)
  (browse-url (search-site  "docs.python.org" (thing-at-point 'symbol))))

(add-hook 'window-setup-hook
          (lambda ()
	    (global-set-key (kbd "C-x C-c") (lambda () (interactive) (message "Quick exit disabled, try M-x kill-emacs")))))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(require 'uniquify)

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) (setq ido-create-new-buffer 'always)



;; (global-font-lock-mode 1)
;; (setq inhibit-splash-screen t)
(setq font-lock-maximum-decoration 3)
;; (setq use-file-dialog nil)
;; (setq use-dialog-box nil)
;; (fset 'yes-or-no-p 'y-or-n-p)
;; (tool-bar-mode -1)
(show-paren-mode 1)
;; (transient-mark-mode t)
;; (setq case-fold-search t)
;; (blink-cursor-mode 0)

;; (push '("." . "c:/home/jared/.emacs-backups") backup-directory-alist)


;; (setq x-select-enable-clipboard t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; YASNIPPET
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")


;;(set-default-font "-outline-Consolas-normal-r-normal-normal-14-97-96-96-c-*-iso8859-1")

;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(global-set-key (kbd "M-1") 'previous-multiframe-window)
(global-set-key (kbd "M-2") 'next-multiframe-window)

(global-set-key [insert] 'copy-region-as-kill)
(global-set-key [C-insert] 'yank)

(global-set-key (kbd "M-<f11>") 'compile)

(global-set-key (kbd "C-M-<up>") '(lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "C-M-<down>") '(lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "<kp-home>") 'kmacro-end-and-call-macro)

(global-set-key (kbd "<f12>") 'slime-eval-defun)
(global-set-key (kbd "C-<f12>") 'slime-repl-resend)
(global-set-key (kbd "<XF86Calculator>") 'revert-buffer)
(global-set-key (kbd "<f6>") '(lambda () (interactive) 
				(insert "lg.error(\")")
				(backward-char)))
(global-set-key (kbd "<kp-home>") 'call-last-kbd-macro)
(global-set-key (kbd "<kp-up>") 'slime-eval-defun)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq-default indent-tabs-mode nil) ;; from http://dotfiles.org/~benjamn/.emacs
;;(setq-default tab-width 4)


(require 'tramp)
(setq tramp-default-method "ssh")

(load "/home/ignacio/.emacs.d/javascript.el")
(load "/home/ignacio/.emacs.d/puppet-mode.el")

(add-to-list 'tramp-default-user-alist '(nil nil "ithayer") t)

(load "/home/ignacio/.emacs.d/js2-mode.elc")
(load "/home/ignacio/.emacs.d/espresso.elc")

(defun jslint-thisfile ()
  (interactive)
  (compile (format "~/p/lintnode/jslint.curl  %s" (buffer-file-name))))

(add-hook 'espresso-mode-hook
  '(lambda ()
  (local-set-key [f6] 'jslint-thisfile)))
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;; clojure-mode
(add-to-list 'load-path "/home/ignacio/.emacs.d/clojure-mode")
(require 'clojure-mode)

;; swank-clojure
(add-to-list 'load-path "/home/ignacio/.emacs.d/swank-clojure")
(add-to-list 'load-path "/home/ignacio/.emacs.d/slime")

(setq swank-clojure-jar-path "~/p/twintwin/v3/jars/clojure.jar"
      swank-clojure-extra-classpaths (list
				      "/home/ignacio/.emacs.d/swank-clojure"
				      "~/p/twintwin/v3/jars/clojure-contrib.jar"
				      "~/p/twintwin/v3/crunch3/src/*"
				      ))

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
               'flymake-create-temp-inplace))
       (local-file (file-relative-name
            temp-file
            (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
   (add-to-list 'flymake-allowed-file-name-masks
             '("\\.py\\'" flymake-pyflakes-init)))

(require 'swank-clojure)

(eval-after-load 'paredit
  '(progn
     (define-key paredit-mode-map (kbd "<M-left>") 'paredit-forward-barf-sexp)
     (define-key paredit-mode-map (kbd "<M-right>") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "<C-left>") 'backward-word)
     (define-key paredit-mode-map (kbd "<C-right>") 'forward-word)))

;; slime
(eval-after-load "slime" 
  '(progn (slime-setup '(slime-repl))	
	(defun paredit-mode-enable () (paredit-mode 1))	
	(add-hook 'slime-mode-hook 'paredit-mode-enable)	
	(add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
	(setq slime-protocol-version 'ignore)))

(defun clojure-font-lock-setup ()
  (interactive)
  (set (make-local-variable 'lisp-indent-function)
       'clojure-indent-function)
  (set (make-local-variable 'lisp-doc-string-elt-property)
       'clojure-doc-string-elt)
  (set (make-local-variable 'font-lock-multiline) t)

  (add-to-list 'font-lock-extend-region-functions
               'clojure-font-lock-extend-region-def t)

  (when clojure-mode-font-lock-comment-sexp
    (add-to-list 'font-lock-extend-region-functions
                 'clojure-font-lock-extend-region-comment t)
    (make-local-variable 'clojure-font-lock-keywords)
    (add-to-list 'clojure-font-lock-keywords
                 'clojure-font-lock-mark-comment t)
    (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil))

  (setq font-lock-defaults
        '(clojure-font-lock-keywords    ; keywords
          nil nil
          (("+-*/.<>=!?$%_&~^:@" . "w")) ; syntax alist
          nil
          (font-lock-mark-block-function . mark-defun)
          (font-lock-syntactic-face-function
           . lisp-font-lock-syntactic-face-function))))

(add-hook 'slime-repl-mode-hook
          (lambda ()
            (font-lock-mode nil)
            (clojure-font-lock-setup)
            (font-lock-mode t)))

(add-to-list 'load-path "/home/ignacio/.emacs.d/swank-clojure")
(require 'slime)
(slime-setup)

;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'scheme-mode-hook     'enable-paredit-mode)
;; (add-hook 'clojure-mode-hook    'enable-paredit-mode)
;; (add-hook 'ruby-mode-hook       'esk-paredit-nonlisp)
;; (add-hook 'espresso-mode-hook   'esk-paredit-nonlisp)

;;(setq latex-mode-hook
;;   '(lambda ()
;;      (auto-fill-mode 1)
;;      ))

;; TODO: make this switch to most recent slime buffer then reevaluate.
;; (defun slime-eval-defun-and-resend ()
;;   ""
;;   (interactive)
;;   (progn
;;     (slime-eval-defun)
;;     (slime-repl-resend)))

;; ;;(x-popup-menu t '("title" ("pane1t" ("1" . "a") ("2" . "b"))))
;; ;;(x-popup-dialog t '("ok" "test"))

;; 
;; (add-to-list 'load-path "/usr/share/slime")
;; (require 'slime)
;; (slime-setup)

;; (global-set-key [f12] 'slime-eval-defun)
;; (global-set-key (kbd "M-<f12>") 'slime-eval-buffer)
;; (global-set-key (kbd "C-<f12>") 'slime-repl-resend)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(defun jsj-ac-show-help ()
  "show docs for symbol at point or at beginning of list if not on a symbol"
  (interactive)
  (let ((s (save-excursion
             (or (symbol-at-point)
                 (progn (backward-up-list)
                        (forward-char)
                        (symbol-at-point))))))
    (pos-tip-show (if (equal major-mode 'emacs-lisp-mode)
                      (ac-symbol-documentation s)
                    (ac-slime-documentation (symbol-name s)))
                  'popup-tip-face
                  ;; 'alt-tooltip
                  (point)
                  nil
                  -1)))

(define-key lisp-mode-shared-map (kbd "C-c C-h") 'jsj-ac-show-help)
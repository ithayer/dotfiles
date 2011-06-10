(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key (kbd "<f6>") 'find-tag)
(global-set-key (kbd "M-<f11>") 'compile)

(global-set-key "\M-g"  'goto-line) ; use M-g for goto-line


;; From http://nlp.stanford.edu/javanlp/emacs-tips.shtml

(add-hook 'java-mode-hook '(lambda () (setq c-basic-offset 2)))
(setq-default indent-tabs-mode nil)     ; use only spaces, not tabs

(add-hook 'java-mode-hook 'turn-off-auto-fill)  ; don't wrap long lines

(defun fill-column-hook () (setq fill-column 80))
(add-hook 'java-mode-hook 'fill-column-hook)    ; use 80 column width

(defun comment-column-hook () (setq comment-column 40))
(add-hook 'java-mode-hook 'comment-column-hook) ; start comments in column 40

(add-hook 
 'java-mode-hook
 '(lambda () "Treat Java 1.5 @-style annotations as comments."
    (setq c-comment-start-regexp "\\(@\\|/\\(/\\|[*][*]?\\)\\)")
    (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))

;; END FROM

(setq compile-command-history
      (list "cd .. && /u/nlp/packages/jakarta-ant/bin/ant"
            "java junit.textui.TestRunner dev.ignacio."))

(setq compile-command (car compile-command-history))
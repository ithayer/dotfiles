;; Provide a mode that helps to write logging statements that include
;; all the local context and function arguments.
;; Refactor as defun
;; Refactor as variable
;; Movement
;; auto expand double period

(require 'yas)

(defgroup pyql nil
  "Various python utilities mode."
  :group 'external)

(defcustom pyql-complete-char-code 96
  "Char code for the character that triggers an auto-complete."
  :type 'integer
  :group 'pyql)

(defvar pyql-mode-enabled nil)

(defun pyql-expand-do ()
  "Run yas/expand."
  (delete-backward-char)
  (yas/expand))

(defun pyql-check-complete ()
  "Check if we should trigger the auto-complete."
  (when (eq pyql-complete-char-code last-command-event)
    (pyql-expand-do)))

(define-minor-mode pyql-mode
  "Various python utilities."
  :lighter " pyql"
  (make-local-variable 'pyql-mode-enabled)
  (make-local-variable 'post-self-insert-hook)
  (if pyql-mode-enabled
      (remove-hook 'post-self-insert-hook 'pyql-check-complete)
    (add-hook 'post-self-insert-hook 'pyql-check-complete))
  (setq pyql-mode-enabled (not pyql-mode-enabled)))

(provide 'pyql)

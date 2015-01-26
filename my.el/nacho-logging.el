
;;http://stackoverflow.com/questions/2622351/emacs-lisp-how-to-use-ad-get-arg-and-ad-get-args

(setq lg--buffer "*log*")

(defun lg--str (&rest args)
  (mapconcat (lambda (s) (format "%s" s)) args " "))

(defun lg--do-log (type time xs)
  (with-current-buffer (get-buffer-create lg--buffer)
    (insert (format "[%6s] %s: %s\n" type time (apply #'lg--str xs)))
    (let ((w (car (get-buffer-window-list (current-buffer)))))
      (set-window-point w (window-end w)))
    ))

(defun lg--now ()
  (format-time-string "%Y%m%d-%H:%M:%S.%3N"))

(defun lg/info (&rest xs)
  (lg--do-log "INFO" (lg--now) xs))

(defun lg/set-local-buffer (n)
  "Set the logging buffer for a buffer."
  (make-local-variable 'lg--buffer)
  (setq lg--buffer n))

(defmacro lg/spy (x)
  (let ((s* (lg--str x)))
    `(let ((e* (progn ,x)))
       (lg--do-log "SPY" (lg--now) (list (format "%s => %s" ,s* e*)))
       e*)))

(provide 'nacho-logging)


;; Examples

;; (lg/info "test3")
;; (lg/info "x" '(1 2 3))

;; (lg/spy (+ 1 2))
;; (lg/spy (progn (let ((x (+ 1 2)))
;;                  (message "got x: ")
;;                  x)))
;

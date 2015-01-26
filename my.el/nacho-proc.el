(setq proc--cb nil)

;; (defun proc/handle-sentinel (process signal)
;;   (message signal)
;;   (if (equal signal "finished\n")
;;       (progn (with-current-buffer (process-buffer process)
;;                (funcall proc--cb
;;                         (buffer-substring (point-min) (point-max))))
;;              (kill-buffer (process-buffer process)))
;;     ))

(defun proc/handle-sentinel (process signal)
  (let ((p-buffer (process-buffer process)))
    (message (format "Process in buffer %s sent %s" p-buffer signal))
    (if (equal signal "finished\n")
        (with-current-buffer p-buffer
          (funcall proc--cb p-buffer))
      )))

(defun proc/run (name buf cmd cb &optional region-start region-end)
  (let ((proc (start-process-shell-command name buf cmd)))
    (with-current-buffer (process-buffer proc)
      (make-local-variable 'proc--cb)
      (setq proc--cb cb))
    (set-process-sentinel proc 'proc/handle-sentinel)
    (when (and region-start
               region-end)
      (progn (process-send-region proc region-start region-end)
             (process-send-eof proc)))))


;;(proc/run "ls" "*ls*" "ls -l /bin" (lambda (x) (print-it x)))

(provide 'nacho-proc)

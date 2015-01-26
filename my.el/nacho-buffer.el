
(defmacro b/save (&rest x)
  `(save-excursion
     (save-match-data
       ,(cons 'progn x))))

(defun b/point-at (f1)
  (b/save
   (funcall f1)
   (point)))

;;(b/point-at #'beginning-of-line)

(defun b/points-at (f1 f2)
  (b/save
   (let ((start (progn (funcall f1)
                       (point)))
         (end   (progn (funcall f2)
                       (point))))
     `(,start ,end))))

;;(b/points-at #'beginning-of-line #'end-of-line)


(defun b/insertf (b format-str &rest args)
  (let ((b* (if (stringp b)
                (get-buffer b)
              b)))
    (with-current-buffer b*
      (insert (apply #'format format-str args)))))


;;(b/insertf "*log*" "xx%d%f\n" 1 0.2)



(provide 'nacho-buffer)

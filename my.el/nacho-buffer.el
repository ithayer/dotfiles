
(defmacro b/save (&rest x)
  `(save-excursion
     (save-match-data
       ,(cons 'progn x))))

(defun b/point-at (f1)
  "Get the point after calling 'f1'."
  (b/save
   (funcall f1)
   (point)))

;;(b/point-at #'beginning-of-line)

(defun b/points-at (f1 f2)
  "Get the points after calling 'f1' and 'f2'."
  (b/save
   (let ((start (progn (funcall f1)
                       (point)))
         (end   (progn (funcall f2)
                       (point))))
     `(,start ,end))))

;;(b/points-at #'beginning-of-line #'end-of-line)

(defun b/->buffer (b)
  "Either identity or if 'b' is a string, the buffer represented by 'b'."
  (if (stringp b)
      (get-buffer b)
    b))

(defun b/insertf-other (b format-str &rest args)
  "Insert formatted string into other buffer."
  (with-current-buffer (b/->buffer b)
    (insert (apply #'format format-str args))))

(defun b/insertf (format-str &rest args)
  "Insert formatted string into current buffer."
  (insert (apply #'format format-str args)))

;;(b/insertf "*log*" "xx%d%f\n" 1 0.2)

(defun b/overlay-create (start end kind &optional face*)
  (let ((o (make-overlay start end)))
    (overlay-put o 'b/-overlay-kind kind)
    (when face*
      (overlay-put o 'face face*))
    o))

;;(b/overlay-create (get-buffer "test.py") 12 17 :x 'nacho-highlight-face2)
;;(b/overlay-create (get-buffer "test.py") 3 6 :x 'nacho-highlight-function-face)

(defun b/overlay-delete (kind &optional start end)
  "Delete overlays of kind 'kind', if :all, deletes all. If start/end aren't specified,
   will delete entire buffer."
  (cond ((and start end (eq :all kind))
         (remove-overlays start end))
        ((and start end)
         (remove-overlays start end 'b/-overlay-kind kind))
        (t
         (remove-overlays (point-min) (point-max) 'b/-overlay-kind kind))))

(defun b/point-at-line (l)
  "Returns the point at the start of line 'l'."
  (save-excursion
    (goto-line l)
    (line-beginning-position 0)))


(provide 'nacho-buffer)

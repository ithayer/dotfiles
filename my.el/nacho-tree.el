
(defun tree/visit (tree child-fn visit-fn)
  (funcall visit-fn tree)
  (mapcar (lambda (x)
            (lg/logging-errors
             nil
             (tree/visit x child-fn visit-fn)))
          (funcall child-fn tree)
          ))

(provide 'nacho-tree)


(tree/visit )

(lg/logging-errors nil (lg/info "xyz") (/ 1 0))

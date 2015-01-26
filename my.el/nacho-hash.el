

(defun h/get (h* k)
  (cdr (assoc k h*)))

(defun h/add (h* &rest *kvs)
  (while *kvs
    (let ((k (car *kvs))
          (v (cadr *kvs)))
      (setq h* (cons `(,k . ,v) h*))
      (setq *kvs (cddr *kvs))))
  h*)

(defun h/new (&rest *kvs)
  (apply #'h/add nil *kvs))

(defun h/set (h* k v)
  (cons `(,k . ,v) (assq-delete-all k h*)))

(provide 'nacho-hash)

;; examples
(-> (h/set nil :x 2) (h/get :x))
(h/add nil :x 2 :y 3)

(cddr '(1 2))
(-> (h/add '((1 . 2)) :x 2 :y 3 :z 10) (h/set :x 20) (lg/spy) (h/get :x))


(momentary-string-display "xasd" 0)

(defvar _b (generate-new-buffer "foo"))

(defun lg (x)
  (with-current-buffer _b
    (goto-char (point-max))
    (insert x)
    (insert "\n"))
  (let ((w (car (get-buffer-window-list _b))))
    (set-window-point w (window-end w)))
  )

(setq w1 )

(save-excursion )

(append-to-buffer)
(lg "123")
(lg "sdfsdf")p



(require 'json)
(defun --cb (b)
  (let ((--cb-buffer b))
    (tree/visit
     (json-read-from-string
      (with-current-buffer b
        (buffer-substring (point-min) (point-max))))
     (lambda (x) (cdr (assoc 'children x)))
     (lambda (x)
       (lg/info "VISIT" x)
       (let ((fields (elt (h/get x 'fields) 0)))
         (let ((column (h/get x 'col_offset))
               (line   (h/get x 'line))
               (node   (h/get x 'node))
               (name   (or (h/get fields 'name) (h/get fields 'id))))
           (cond ((string= node "Name")
                  (progn
                    (let ((col-pos (with-current-buffer (get-buffer "test.py")
                                     (+ (b/point-at-line (+ 1 line)) column))))
                      (lg/info "HERE: " line column "=" col-pos)
                      (b/overlay-create (get-buffer "test.py")
                                        col-pos
                                        (+ col-pos (length name))
                                        :nacho-highlight-function
                                        'nacho-highlight-face2)))))
           (lg/info "GOT: " node (string= node "FunctionDef") column line name)
           )))))) ;; !! LEFT HERE -- change this to filter by certain name.

 (add-text-properties 1 2 '(font-lock-face nacho-highlight-face2) (get-buffer "test.py"))
(with-silent-modifications
  (add-face-text-property 2 3 '(:foreground "red") nil (get-buffer "test.py")))
;; use overlays instead
(remove-text-properties 1 8 '(face nil) (get-buffer "test.py"))
(let ((o (make-overlay 2 3 (get-buffer "test.py"))))
  (overlay-put o 'face 'nacho-highlight-function-face)
  )
(with-current-buffer (get-buffer "test.py") (remove-overlays 0 20))

(defgroup nacho-faces nil
  "The standard faces of Nacho."
  :group 'faces)

(defface nacho-highlight-function-face
  '((t :slant italic
       :weight bold
       :background "green"))
  "Basic default face."
  :group 'nacho-faces)
(defface nacho-highlight-face2
  '((t :foreground "red"))
  "Basic default face."
  :group 'nacho-faces)


(add-text-properties)


;;!! LEFT HERE, next pass a visitor that sets the location and identity of variables describing the items of interest in the syntax tree


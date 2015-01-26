

(defun s/strip-left (s re)
  (replace-regexp-in-string (format "^%s" re)  "" s))

;;(s/strip-left "xxuzxx" "xx")

(defun s/strip-right (s re)
  (replace-regexp-in-string (format "%s$" re) "" s))

;;(s/strip-right "xxuzxx" "xx")

(defun s/strip (s re)
  (replace-regexp-in-string re "" s))


(provide 'nacho-string)

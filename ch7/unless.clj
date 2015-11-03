(defmacro unless [test then else]
  `(if-not ~test
             ~then
             ~else))

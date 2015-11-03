(defn i [s]
  (let [s (str s)
        n? (.endsWith s "n")
        s (if n?
            (.substring s 0 (-> s (count) (dec)))
            s)
        x (Integer/valueOf s)]
    (if n?
      (- x)
      x)))

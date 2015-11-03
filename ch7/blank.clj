(defprotocol Blank
  (blank? [this] "Returns true if data is considered blank/empty"))

(extend-protocol Blank
  clojure.lang.IPersistentMap
  (blank? [this]
    (= {} this))
  clojure.lang.IPersistentVector
  (blank? [this]
    (= [] this))
  String
  (blank? [this]
    (.isEmpty this))
  nil
  (blank? [this]
    true)
  false
  (blank? [this]
    true)
  Object
  (blank? [this]
    false))

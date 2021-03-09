;;;; cl-fill-string.asd

(asdf:defsystem #:cl-fill-string
  :description "Fill strings to fill-column."
  :author "Pavel Stepanov"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "cl-fill-string")))

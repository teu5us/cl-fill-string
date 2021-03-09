;;;; package.lisp

(defpackage #:cl-fill-string
  (:use #:cl)
  (:nicknames #:cfs)
  (:export #:nfill-string #:fill-string
           #:no-space-before-fill-column))

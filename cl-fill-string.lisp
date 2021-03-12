;;;; cl-fill-string.lisp

(in-package #:cl-fill-string)

(define-condition no-space-before-fill-column (error)
  ((fill-column :initarg :fill-column
                :initform nil
                :accessor :fill-column)
   (string :initarg :string
           :initform nil
           :accessor :string))
  (:report (lambda (condition stream)
             (format stream "No space found before fill-column ~A."
                     (:fill-column condition)))))

(defun sym (sym string start end)
  (search (format nil "~A" sym) string :from-end t :start2 start :end2 end))

(defun find-space (string column &optional (start 0))
  (let* ((lstr (length string))
         (--end (+ start column))
         (lstr-or-end (<= lstr --end))
         (-end (if lstr-or-end lstr --end))
         (-newline (sym #\newline string start -end))
         (n-start (if -newline -newline start))
         (-n-end (+ n-start column))
         (n-end (if (< lstr -n-end) lstr -n-end))
         (end (if lstr-or-end
                  -end
                  (sym #\space string n-start n-end)))
         (finished (if (eql end lstr) t nil)))
    (unless end (error 'no-space-before-fill-column :fill-column -end
                                                    :string string))
    (values end finished)))

(defun nfill-string (string column &optional (start 0))
  (if (eql column 0)
      string
      (multiple-value-bind (end finished) (find-space string column start)
        (if finished
            string
            (fill-string (progn
                           (setf (char string end) #\newline)
                           string)
                         column
                         (1+ end))))))

(defun fill-string (string column &optional (start 0))
  (let ((str (copy-seq string)))
    (nfill-string str column start)))

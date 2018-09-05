;;; amesh.el --- Amesh for emacs

;; Copyright (C) 2010-2018 decoch

;; Author: decoch
;; Created: 4 Sep 2018
;; Keywords: amesh

;;; Commentary:

;; Show cloud image from amesh at now

;;; Code:

(defun amesh ()
  "Show a amesh image."
  (progn (kill-buffer (get-buffer-create "*amesh*"))
         (switch-to-buffer (get-buffer-create "*amesh*"))
         (insert-image-from-url (amesh-image-url))
         (insert-image-from-url (map-image-url))
         (insert "\n")
         (insert (map-image-url))
         (insert "\n")
         (insert (amesh-image-url))))

(defun insert-image-from-url (url)
  "Insert image to buffer from URL."
  (let ((buffer (url-retrieve-synchronously url)))
    (unwind-protect
        (let ((data (with-current-buffer buffer
                      (goto-char (point-min))
                      (search-forward "\n\n")
                      (buffer-substring (point) (point-max)))))
          (insert-image (create-image data nil t)))
      (kill-buffer buffer))))

(defvar amesh-base-url "http://tokyo-ame.jwa.or.jp")

(defun map-image-url ()
  "Get url of amesh's map image."
  (concat amesh-base-url "/map/map000.jpg"))

(defun amesh-image-url ()
  "Get url of amesh's image."
  (concat amesh-base-url "/mesh/000/" (adjusted-time) ".gif"))

(defun adjusted-time ()
  "Get time of amesh's image."
  (concat (format-time-string "%Y%m%d%H") (adjusted-minites)))

(defun adjusted-minites ()
  "Get minites of amesh's image."
  (format "%02d" (* (/ (- (string-to-number (format-time-string "%MM")) 1) 5) 5)))

(provide 'amesh)

;;;###autoload

;;; amesh.el ends here

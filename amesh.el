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
  (progn (kill-buffer (get-buffer-create "*lgtm*"))
         (switch-to-buffer (get-buffer-create "*lgtm*"))
         (insert-image-from-url (amesh-image-path))
         (insert "\n")
         (insert (amesh-image-path))))

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

(defun amesh-image-path ()
  "Get path of amesh's image."
  (concat "http://tokyo-ame.jwa.or.jp/mesh/000/" (adjusted-time) ".gif"))

(defun adjusted-time ()
  "Get time of amesh's image."
  (concat (format-time-string "%Y%m%d%H") (number-to-string (adjusted-minites))))

(defun adjusted-minites ()
  "Get minites of amesh's image."
  (* (/ (string-to-number (format-time-string "%M")) 5)  5))

(provide 'amesh)

;;;###autoload

;;; amesh.el ends here

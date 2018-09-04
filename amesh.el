;;; lgtm.el --- lgtm.in client

;; Copyright (C) 2015 Hiroki Kumamoto

;; Author: Hiroki Kumamoto <kumabook@live.jp>
;; Version: 0.1
;; Package-Requires: ((request "1.0"))
;; Keywords: multimedia, frobnicate
;; URL: https://github.com/kumabook/lgtm-emacs

;;; Commentary:

;; Show a LGTM image from lgtm.in at random

;;; Code:

(require 'url)
(require 'json)

(defun amesh ()
  "Show a amesh image."
  (progn (kill-buffer (get-buffer-create "*lgtm*"))
         (switch-to-buffer (get-buffer-create "*lgtm*"))
         (insert-image-from-url (amesh-image-path))
         (insert "\n")
         (insert (image-path))))

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
  "Get amesh image'path."
  (concat "http://tokyo-ame.jwa.or.jp/mesh/000/" (adjusted-time) ".gif"))

(defun adjusted-time ()
  "Get time of eamesh image' path."
  (concat (format-time-string "%Y%m%d%H") (number-to-string (adjusted-minites))))

(defun adjusted-minites ()
  "Get minites of amesh image's path."
  (* (/ (string-to-number (format-time-string "%M")) 5)  5))

(provide 'amesh)

;;;###autoload

;;; lgtm.el ends here

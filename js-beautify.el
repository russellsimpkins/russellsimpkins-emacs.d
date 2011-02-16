;;; js-beautify.el -- beautify some js code
(defcustom rhino-jar "~/software/rhino1_7R"
       "Location of the rhino jar e.g. rhino1_7R2"
       :type '(string)
       :group 'data)
(defcustom beautify-dir "~/software/js-beautify"
       "Location of the js-beautify directory e.g. ~/software/js-beautify"
       :type '(string)
       :group 'data)
(defun js-beautify ()
  "Beautify a region of javascript using the code from jsbeautify.org"
  (interactive)
  (let ((orig-point (point)))
    (unless (mark)
      (mark-defun))
    ;; 
    (setq command (concatenate 'string "java -jar " rhino-jar "/js.jar " beautify-dir  "/beautify-cl.js -i 4 -p -d " beautify-dir ))
    (shell-command-on-region (point)
                             (mark)
                             command  nil t)
    (goto-char orig-point)))
(provide 'js-beautify)

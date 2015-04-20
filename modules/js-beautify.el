;;; js-beautify.el -- beautify some js code
(defcustom rhino-jar "~/software/rhino1_7R2"
       "Location of the rhino jar e.g. rhino1_7R2"
       :type '(string)
       :group 'data)
(defcustom beautify-dir "~/software/js-beautify"
       "Location of the js-beautify directory e.g. ~/software/js-beautify"
       :type '(string)
       :group 'data)

(defun js-beautify-region ()
  "Beautify a region of javascript using the code from jsbeautify.org. If you don't have
   a region selected, the code will go from the cursor to the end of the line."
  (interactive)
  (let ((orig-point (point)))
    (setq endm 0)
    (if mark-active
        (setq endm (mark))
      (setq endm (point-at-eol))
    )
    (setq command (concatenate 'string "java -jar " rhino-jar "/js.jar " beautify-dir  "/beautify-cl.js -i 4 -p -d " beautify-dir ))
    (shell-command-on-region (point)
                             endm
                             command  nil t)
    (goto-char orig-point)))

(defun js-beautify-buffer ()
  "Beautify the buffer using the code from jsbeautify.org"
  (interactive)
  (let ((orig-point (point)))
    (setq command (concatenate 'string "java -jar " rhino-jar "/js.jar " beautify-dir  "/beautify-cl.js -i 4 -p -d " beautify-dir ))
    (shell-command-on-region (point-min) (point-max) command  nil t)
    (goto-char orig-point)))

(provide 'js-beautify)

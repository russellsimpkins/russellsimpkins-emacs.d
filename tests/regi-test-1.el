(defun regi-test-1 ()
  "Regi test 1"
  (interactive)
  (http-post "http://dprofile.prvt.nytimes.com/svc/profile/preferencesv3/user/createoauth" (list (cons "id" "12345") (cons "location" "New York") (cons "source" "twitter") (cons "email" "test1nytimes@nytimes.com") (cons "displayname" "spunky1")) 'utf-8)
) 
(provide 'regi-test-1)
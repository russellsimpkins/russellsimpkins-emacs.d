(require 'http-post-simple)
(defun regi-test-2 ()
  "Regi test 2"
  (interactive)
  (http-post-simple "http://dprofile.prvt.nytimes.com/svc/profile/preferencesv3/user/createoauth" (list (cons 'id "12345") (cons 'location "New York") (cons 'source "twitter") (cons 'email "test1nytimes@nytimes.com") (cons 'displayname "spunky1")) )
) 
(provide 'regi-test-2)
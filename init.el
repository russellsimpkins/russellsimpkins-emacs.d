;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.


;; Load path etc.

;;(setq dotfiles-dir (file-name-directory
;;                    (or (buffer-file-name) load-file-name)))
(setq dotfiles-dir "/Users/202238/.emacs.d")
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit/jabber"))
(add-to-list 'load-path (concat dotfiles-dir "/http-post"))
(add-to-list 'load-path (concat dotfiles-dir "/tests"))
(add-to-list 'load-path (concat dotfiles-dir "/smarttabs"))
(add-to-list 'load-path (concat dotfiles-dir "/puppet-syntax-emacs"))
(add-to-list 'load-path (concat dotfiles-dir "/yaml-mode"))
(add-to-list 'load-path (concat dotfiles-dir "/elpa/magit-0.8.1"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'recentf)
(require 'mustache-mode)
(require 'yaml-mode)
;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)
;; git support
(require 'magit)
(require 'git)
(require 'git-blame)
;; Load up ELPA, the package manager
(require 'package)
(package-initialize)
(require 'starter-kit-elpa)

;; Load up starter kit customizations
(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-js)
(require 'http-post)
(require 'http-cookies)
(require 'js-beautify)
(require 'php-mode)
(require 'tramp)
(require 'go-mode)
;;(require 'go-autocomplete)
(require 'auto-complete-config)
(require 'puppet-mode)


;; must set before helm-config,  otherwise helm use default
;; prefix "C-x c", which is inconvenient because you can
;; accidentially pressed "C-x C-c"
;;(setq helm-command-prefix-key "C-c h")
;;(require 'helm-config)
;;(require 'helm-eshell)
;;(require 'helm-files)
;;(require 'helm-grep)










;; smart tabs
;;(require 'smart-tabs-mode)
;;(smart-tabs-insinuate 'c 'javascript 'c++)

(ac-config-default)
(setq tramp-default-method "scp")
(add-to-list 'auto-mode-alist '("\\.pp$". puppet-mode))
;;(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
;;(require 'php-mode)
;;(require 'php-electric)
;;(add-hook 'php-mode-hook '(lambda () (php-electric-mode)))

;;(require 'php-mode)
;;(eval-after-load "sql"
;;   '(load-library "tsql-indent"))
;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))

(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
    (mapc #'load (directory-files user-specific-dir nil ".*el$")))


;;(recentf-mode 1)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-c\m" 'execute-extended-command)
(global-set-key "\C-x\m" 'execute-extended-command)
(global-set-key (kbd "C-x 6")  'enlarge-window)
(global-set-key (kbd "C-x 5") 'shrink-window)
					; for font size adjust
(global-set-key (kbd "C-x }") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x {") 'shrink-window-horizontally)
(global-set-key (kbd "C-x +") 'balance-windows)
					; search replace
(global-set-key (kbd "C-x C-g") 'query-replace)
(global-set-key (kbd "C-x C-z") 'query-replace-regexp)

					; add key to quit a shell job
(global-set-key (kbd "C-c C-c") 'comint-interrupt-subjob)

;; map to do a save as e.g. for save as unix
(global-set-key (kbd "C-x C-a") 'set-buffer-file-coding-system)

					; add key for describe char - will give ascii code for a char
(global-set-key (kbd "C-x C-l") 'describe-char)

					; add key code to beautify javascript
(global-set-key (kbd "C-x j b") 'js-beautify-region)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
(global-set-key (kbd "C-x p") 'magit-push)

;;(setq ac-quick-help-delay 3)
(setq scroll-preserve-screen-position t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-last-directory-history nil)
(setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
(setq ido-show-dot-for-dired t) ;; put . as the first item
(setq ido-use-filename-at-point t) ;; prefer file names near point
(setq mac-option-modifier 'meta)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default js-indent-level 2)
(setq-default fill-column 9999)
;; (setq-default fill-column 72)
;; let emacs find <> as well balanced parens as [] and () are
(modify-syntax-entry ?> "(<")
		     (modify-syntax-entry ?< ")>")
;;; init.el ends here

(column-number-mode 1)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; map stuff ending in .com to the Unix conf-mode
(add-to-list 'auto-mode-alist '("\\.com$" . conf-mode))

;;(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
;;(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
;;(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;;(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
;;(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
;;(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(setq
 helm-google-suggest-use-curl-p t
 helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
 helm-quick-update t ; do not display invisible candidates
 helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
 helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
 helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.

 helm-split-window-default-side 'other ;; open helm buffer in another window
 helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window


;; helm-buffers-favorite-modes (append helm-buffers-favorite-modes
 ;;                                     '(picture-mode artist-mode))
 
 helm-candidate-number-limit 200 ; limit the number of displayed canidates
 helm-M-x-requires-pattern 0     ; show all candidates when set to 0
 helm-ff-file-name-history-use-recentf t
 helm-move-to-line-cycle-in-source t ; move to end or beginning of source
                                        ; when reaching top or bottom of source.
 ido-use-virtual-buffers t      ; Needed in helm-buffers-list
 helm-buffers-fuzzy-matching t          ; fuzzy matching buffer names when non--nil
                                        ; useful in helm-mini that lists buffers
 )

;; Save current position to mark ring when jumping to a different place
;;(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

;;(helm-mode 1)

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun terminal-init-screen ()
  "Terminal initialization function for screen."
  ;; Use the xterm color initialization code.
  ;; (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
)

(defun no-windows ()
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (terminal-init-screen)
  )


;; *********************************************************
;; Stuff if you're not in a terminal
;; *********************************************************
(defun window-settings ()
  ;; give us frame resizing functions
  ;;(require 'autofit-frame)
  (require 'frame-cmds)
  (require 'ansi-color)
  
  (menu-bar-mode 1)
  (tool-bar-mode 0)
  ;; cedet
  (add-to-list 'load-path (concat dotfiles-dir "/cedet"))
  (add-to-list 'load-path (concat dotfiles-dir "/cedet/common"))
  (add-to-list 'load-path (expand-file-name "cedet/common"))
  ;;(load-file "~/.emacs.d/cedet/common/cedet.el")
  ;;(global-ede-mode 1)                      ; Enable the Project management system
  ;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;  (global-srecode-minor-mode 1)            ; Enable template insertion menu
  ;; * This enables the database and idle reparse engines
;  (semantic-load-enable-minimum-features)
  ;; * This enables some tools useful for coding, such as summary mode
  ;; * imenu support, and the semantic navigator
;  (semantic-load-enable-code-helpers)
  ;; * for elib support of java
;  (add-to-list 'load-path (expand-file-name "~/.emacs.d/jde/lisp"))
;  (setq load-path (append (list "/usr/local/share/emacs/site-lisp/elib") load-path))
  ;; * turn on cedit if you turn this on
;  (require 'jde)
  ;; ecb
;  (add-to-list 'load-path (concat dotfiles-dir "/ecb"))
  ;; * turn on cedit if you turn this on
;  (require 'ecb)
  (regen-autoloads)
  (load custom-file 'noerror)
;  (add-hook 'php-mode-user-hook 'semantic-default-java-setup)
  ;; (ecb-activate)
  (defun sacha/increase-font-size ()
    (interactive)
    (set-face-attribute 'default
                        nil
                        :height
                        (ceiling (* 1.10
                                    (face-attribute 'default :height)))))
  (defun sacha/decrease-font-size ()
    (interactive)
    (set-face-attribute 'default
                        nil
                        :height
                        (floor (* 0.9
				  (face-attribute 'default :height)))))

  (global-set-key (kbd "C-+") 'sacha/increase-font-size)
  (global-set-key (kbd "C--") 'sacha/decrease-font-size)
					;  (global-set-key (kbd "C-+") 'text-scale-increase)
					;  (global-set-key (kbd "C--") 'text-scale-decrease)
  
  (require 'color-theme)
  (defun color-theme-djcb-dark ()
    "dark color theme created by djcb, Jan. 2009."
    (interactive)
    (color-theme-install
     '(color-theme-djcb-dark
       ((foreground-color . "#a9eadf")
	(background-color . "black") 
	(background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))
       (font-lock-builtin-face ((t (:italic t :foreground "#a96da0"))))
       (font-lock-comment-face ((t (:italic t :foreground "#bbbbbb"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#666666"))))
       (font-lock-constant-face ((t (:bold t :foreground "#197b6e"))))
       (font-lock-doc-string-face ((t (:foreground "#3041c4"))))
       (font-lock-doc-face ((t (:foreground "gray"))))
       (font-lock-reference-face ((t (:foreground "white"))))
       (font-lock-function-name-face ((t (:foreground "#356da0"))))
       (font-lock-keyword-face ((t (:bold t :foreground "#bcf0f1"))))
       (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
       (font-lock-string-face ((t (:foreground "#ffffff"))))
       (font-lock-type-face ((t (:bold t :foreground "#364498"))))
       (font-lock-variable-name-face ((t (:foreground "#7685de"))))
       (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
					  :foreground "yellow"))))
       (hl-line ((t (:background "#112233"))))
       (mode-line ((t (:foreground "#ffffff" :background "#333333"))))
       (region ((t (:foreground nil :background "#555555"))))
       (show-paren-match-face ((t (:bold t :foreground "#ffffff" 
					 :background "#050505")))))))
  (setq my-color-themes (list 'color-theme-billw 'color-theme-jsc-dark 
			      'color-theme-sitaramv-solaris 'color-theme-resolve
			      'color-theme-classic 'color-theme-jonadabian-slate
			      'color-theme-kingsajz 'color-theme-shaman
			      'color-theme-subtle-blue 'color-theme-snowish
			      'color-theme-sitaramv-nt 'color-theme-wheat))
  (setq doremi-color-themes my-color-themes) ; Otherwise, cycles among _all_ themes.
  (defun doremi-color-themes ()
    "Successively cycle among color themes."
    (interactive)
    (doremi (lambda (newval) (funcall newval) newval) ; update fn - just call theme
            (car (last doremi-color-themes)) ; start with last theme
            nil                           ; ignored
            nil                           ; ignored
            doremi-color-themes))         ; themes to cycle through

  (color-theme-midnight)

  ;; setting the default font size
  (set-face-attribute 'default
		      nil
		      :height 180)
  (maximize-frame)
  )



(if window-system
  (window-settings)
  (no-windows)
)

;(global-set-key "\C-x\C-f" 'helm-for-files)
;(global-set-key "\C-x f" 'helm-buffers-list)

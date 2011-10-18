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

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
;;(setq dotfiles-dir '/Users/russellsimpkins/.emacs.d')
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit/jabber"))

(add-to-list 'load-path (concat dotfiles-dir "/http-post"))
(add-to-list 'load-path (concat dotfiles-dir "/tests"))
;; (load (concat dotfiles-dir "elpa-to-submit/nxhtml/autostart.el"))
;;(setq autoload-file (concat dotfiles-dir "/http-post/http-post.el"))
;;(setq autoload-file (concat dotfiles-dir "/http-post/http-cookies.el"))

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

;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)

;; Load up ELPA, the package manager
(require 'package)
(package-initialize)
(require 'starter-kit-elpa)

;;(load "elpa-to-submit/nxhtml/autostart")
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
(require 'http-post-simple)
(require 'http-post)
(require 'http-cookies)
(require 'js-beautify)
(require 'php-mode)

(require 'tramp)
(setq tramp-default-method "scp")

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;(require 'php-mode)
;;(require 'php-electric)
;;(add-hook 'php-mode-hook '(lambda () (php-electric-mode)))

;;(require 'php-mode)
(eval-after-load "sql"
   '(load-library "tsql-indent"))
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

;(global-set-key (kbd "C-x c") 'kill-ring-save)
;(global-set-key (kbd "C-x v") 'yank)


;; set the starting fame height
;;(set-frame-height 'default 30)
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
(setq-default fill-column 999)
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

(defun no-windows ()
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  )

;; *********************************************************
;; Stuff if you're running in a gui
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
  (load-file "~/.emacs.d/cedet/common/cedet.el")
  (global-ede-mode 1)                      ; Enable the Project management system
  (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
  ;;(global-srecode-minor-mode 1)            ; Enable template insertion menu
  ;; * This enables the database and idle reparse engines
  (semantic-load-enable-minimum-features)
  ;; * This enables some tools useful for coding, such as summary mode
  ;; * imenu support, and the semantic navigator
  (semantic-load-enable-code-helpers)
  ;; * for elib support of java
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/jde/lisp"))
  (setq load-path (append (list "/usr/local/share/emacs/site-lisp/elib") load-path))
  ;; * turn on cedit if you turn this on
  (require 'jde)
  ;; ecb
  (add-to-list 'load-path (concat dotfiles-dir "/ecb"))
  ;; * turn on cedit if you turn this on
  ;;(require 'ecb)
  (regen-autoloads)
  (load custom-file 'noerror)
  (add-hook 'php-mode-user-hook 'semantic-default-java-setup)
;;  (add-hook 'php-mode-user-hook
;;  (lambda ()
;;    (setq imenu-create-index-function
;;    'semantic-create-imenu-index)
;;  ))
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
;;  (color-theme-djcb-dark)
  (color-theme-midnight)
;;  (color-theme-zenburn)
  ;;( color-theme-arjen)
  ;;(color-theme-twilight)
  ;;(color-theme-comidia)
  ;;(color-theme-hober)
  ;;(color-theme-tty-dark)
  ;; setting the default font size
  (set-face-attribute 'default
                    nil
                    :height 180)
  (maximize-frame)
  )

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))
(if window-system
    (window-settings)
    (no-windows)
)

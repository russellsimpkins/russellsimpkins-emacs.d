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
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit/jabber"))
(add-to-list 'load-path (concat dotfiles-dir "/http-post"))
(add-to-list 'load-path (concat dotfiles-dir "/tests"))

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
(require 'ansi-color)
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
(require 'regi-test-1)
(require 'regi-test-2)
(require 'php-mode)

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
(global-set-key (kbd "C-x C-g") 'query-replace)
(global-set-key (kbd "C-x }") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x {") 'shrink-window-horizontally)
(global-set-key (kbd "C-x +") 'balance-windows)
(global-set-key (kbd "C-c C-c") 'comint-interrupt-subjob)

;; setting the default font size
(set-face-attribute 'default
                    nil
                    :height 200)
;; set the starting fame height
;;(set-frame-height 'default 30)
(require 'color-theme)
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

(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-enable-last-directory-history nil)
(setq ido-confirm-unique-completion nil) ;; wait for RET, even for unique?
(setq ido-show-dot-for-dired t) ;; put . as the first item
(setq ido-use-filename-at-point t) ;; prefer file names near point
(setq mac-option-modifier 'meta)
(setq-default tab-width 4)

;;(setq-default indent-tabs-mode nil)
;;(color-theme-twilight)
;;; init.el ends here

(column-number-mode 1)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


(defun no-windows ()
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  )
(defun window-settings ()
  ;; cedet
  (add-to-list 'load-path (concat dotfiles-dir "/cedet"))
  (add-to-list 'load-path (concat dotfiles-dir "/cedet/common"))
  (add-to-list 'load-path (expand-file-name "cedet/common"))
  (load-file "~/.emacs.d/cedet/common/cedet.el")
  (global-ede-mode 1)                      ; Enable the Project management system
  (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
  (global-srecode-minor-mode 1)            ; Enable template insertion menu
  ;; * This enables the database and idle reparse engines
  (semantic-load-enable-minimum-features)
  ;; * This enables some tools useful for coding, such as summary mode
  ;;   imenu support, and the semantic navigator
  (semantic-load-enable-code-helpers)
  ;; for elib support of java
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/jde/lisp"))
  (setq load-path (append (list "/usr/local/share/emacs/site-lisp/elib")
                          load-path))
  (require 'jde)
  ;; ecb
  (add-to-list 'load-path (concat dotfiles-dir "/ecb"))
  (require 'ecb)
  (regen-autoloads)
  (load custom-file 'noerror)

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
 )
(if window-system
    (window-settings)
    (no-windows)
)
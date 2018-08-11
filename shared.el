; Inhibit the printing of the startup message
(setq inhibit-startup-message t)

; Set up CC mode
(fmakunbound 'c-mode)
(makunbound 'c-mode-map)
(fmakunbound 'c++-mode)
(makunbound 'c++-mode-map)
(makunbound 'c-style-alist)
(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode   "cc-mode" "C Editing Mode" t)

; Define standard editing modes
(load "cc-mode")

(defconst my-c-style
  '((c-basic-offset . 2)
    (c-offsets-alist . ((arglist-cont . +)
			(arglist-cont-nonempty . +)
			(label . 0)))
    )
  "My C++ Programming Style")

(defun use-my-c-style ()
  (interactive)
  (c-add-style "My C++" my-c-style t)
  (setq c-block-comments-indent-p 1)
  )
(add-hook 'c-mode-hook 'use-my-c-style)
(add-hook 'c++-mode-hook 'use-my-c-style)
(add-hook 'objc-mode-hook 'use-my-c-style)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq compilation-skip-threshold 2)

(defun use-my-python-mode ()
  (interactive)
  (setq python-guess-indent nil)
  (setq-default python-indent 2)
)

(add-hook 'python-mode-hook '(lambda () 
 (setq python-guess-indent nil)
 (setq python-indent 2)
))


(defconst my-c4-style
  '((c-basic-offset . 4)
    (c-offsets-alist . ((arglist-cont . +)
			(arglist-cont-nonempty . +)
			(label . 0)))
    )
  "My C++ Programming Style")
(defun use-my-c4-style ()
  (interactive)
  (c-add-style "My C++ (4)" my-c4-style t)
  (setq c-block-comments-indent-p 1)
  )

; Turn on auto-fill whenever text-mode is entered
(setq text-mode-hook 'turn-on-auto-fill)

 ; scrolling is one line at a time
(setq scroll-step 1)

; Popup only when editing
(setq auto-raise-screen nil)

; Turn off suggestions
(setq suggest-key-bindings nil)

; Turn off visible bell
(setq visible-bell nil)

; Turn on transient marks
(setq transient-mark-mode nil)

; Prevent the multi-buffer effect
(setq find-file-existing-other-name t)

; Turn off tildes
(setq make-backup-files nil)

; Make sure files end in a newline
(setq require-final-newline t)

; Reduce the amount of garbage collection
(setq gc-cons-threshold 4000000)

(setq shorthost (car (split-string system-name "\\.")))
(setq frame-title-format (concat "emacs @ " shorthost " %f"))

(setenv "EMACS" "1")
(setenv "TERM" "dumb")

(setq-default tab-width 8)
; Don't indent with hard tabs
(setq-default indent-tabs-mode nil)

(setq version-control 'never)
'(setq vc-handle-cvs nil)

(menu-bar-mode 0)
(tool-bar-mode 0)
(setq gnuserv-frame nil)
(setq split-height-threshold 25) ; was 80
(setq split-width-threshold nil) ; was 160
(setq display-buffer-reuse-frames 't) ; nil
(setq pop-up-windows nil) ; was t

(setq grep-command "grep -i -n ")

(load "dabbrev")
(setq dabbrev-case-fold-search t)

(defun hard-tab ()
  "Insert a real tab character."
  (interactive)
  (insert ?\t))

(global-set-key [delete] 'backward-delete-char)
(global-set-key [S-tab] 'hard-tab)
(global-set-key [C-tab] 'hard-tab)

(setq completion-ignored-extensions
      '(".o" ".elc" "~" ".bin" ".lbin" ".fasl" ".dvi" ".toc" ".log" ".aux"
	".lof" ".blg" ".bbl" ".glo" ".idx" ".lot" ".ps" ".orig" ".dlog"
	".log" ".class"))


; Load uniquify and then open two different Makefile’s in two different directories

;; uniquify!
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; visually show where the end of the file is
(setq default-indicate-empty-lines t)

(if (file-exists-p "~/FILES.el")
    (load "~/FILES.el"))

(put 'eval-expression 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq auto-mode-alist
      (append '(("\\.c$" . c-mode) ("\\.h$" . c-mode)
		("\\.cxx$" . c++-mode) ("\\.hxx$" . c++-mode)
		("\\.idl$" . c++-mode) ("\\.bld$" . c++-mode)
                ("\\.jsp$" . java-mode) ("\\.jxx$" . java-mode)
		("\\.java$" . java-mode) ("\\.jidl$" . java-mode) ("\\.jdl$" . java-mode)
		("\\.y$" . c++-mode) ("\\.l$" . c++-mode)
		("\\.txt$" . text-mode) ("\\.log$" . text-mode)
                ("\\.m$" . octave-mode)
		("TASKS" . tasks-mode)) auto-mode-alist))

(defun fix-all-faces ()
  (interactive)
  (fix-all-faces-in-frame nil)
  )

(defun fix-all-faces-in-frame (frame)
  (frame-set-background-mode frame)

  (set-face-foreground 'default "white" frame)
  (set-face-background 'default "black" frame)

  (set-face-foreground 'mode-line "white" frame)
  (set-face-background 'mode-line "blue" frame)

  (set-face-foreground 'region "white" frame)
  (set-face-background 'region "brown" frame)

  (set-face-foreground 'secondary-selection "white" frame)
  (set-face-background 'secondary-selection "sea green" frame)

  (set-face-foreground 'highlight "white" frame)
  (set-face-background 'highlight "blue" frame)

  (set-face-foreground 'font-lock-keyword-face "cyan" frame)
  (set-face-background 'font-lock-keyword-face "black" frame)

  (set-face-foreground 'font-lock-comment-face "yellow" frame)
  (set-face-background 'font-lock-comment-face "black" frame)

  (set-face-foreground 'font-lock-string-face "pink1" frame)
  (set-face-background 'font-lock-string-face "black" frame)

  (set-face-foreground 'font-lock-function-name-face "LightBlue1" frame)
  (set-face-background 'font-lock-function-name-face "black" frame)

  (set-face-foreground 'font-lock-variable-name-face "green" frame)
  (set-face-background 'font-lock-variable-name-face "black" frame)

  (set-face-foreground 'font-lock-type-face "turquoise" frame)
  (set-face-background 'font-lock-type-face "black" frame)

  (set-face-foreground 'font-lock-warning-face "pink" frame)
  (set-face-background 'font-lock-warning-face "black" frame)

  (set-face-foreground 'font-lock-builtin-face "LightSteelBlue" frame)
  (set-face-background 'font-lock-builtin-face "black" frame)

  (set-face-foreground 'font-lock-constant-face "Aquamarine" frame)
  (set-face-background 'font-lock-constant-face "black" frame)
  )


(cond (window-system
       ; Set default frame parameters
       (setq default-frame-alist
	     '(
	       (foreground-color . "white")
	       (background-color . "black")
	       (cursor-color . "red")
	       (mouse-color . "white")
	       (vertical-scroll-bars . nil)
               (menu-bar-mode -99)
	       (menu-bar-lines . 1)
	       (tool-bar-lines . 0)
               )
             )
       (if (memq 'x (list window-system))
           (progn
             (setq default-frame-alist
                   (append 
                    '((width . 80) (height . 34)
                      (font . "-*-courier-medium-r-normal-*-24-*-iso8859-1")
                      ) default-frame-alist))
             )
	   (setq default-frame-alist
	         (append 
		  '((width . 110) (height . 33)
		    (font . "-*-Courier New-normal-normal-normal-*-19-*-*-*-*-*-iso8859-1")
		    ) default-frame-alist))
         )

       (setq mouse-1-click-follows-link nil)
       (setq mouse-1-click-in-non-selected-windows  nil)
       ; (defun x-popup-menu nil)

       (blink-cursor-mode nil)
       (set-cursor-color "red")

       ; Set up paren matching
       (require 'paren)
       (show-paren-mode 1)
       (setq blink-matching-paren nil)
       
       ; Set up search highlighting
       (setq search-highlight t)
       
       ; Set up font-lock 
       (require 'font-lock)
       (global-font-lock-mode t)
       (setq font-lock-maximum-decoration
	     '((c-mode . 1) (c++-mode . 1)))
       (setq font-lock-maximum-size' 200000)

       ; Load colors and fonts
       (fix-all-faces)
       (add-hook 'after-make-frame-functions 'fix-all-faces-in-frame)
       
       )
      ('t  ; this is the default terminal case
         (xterm-mouse-mode 1)
         (require 'font-lock)
         (global-font-lock-mode -1)
      )
)

(defun fixme-again ()
  (interactive)
  (menu-bar-mode 0)
  (tool-bar-mode 0))
(add-hook 'after-init-hook 'fixme-again)

; Recommended X defaults:
;
; Emacs*Background:       black
; Emacs*Dialog*background:        brown
; Emacs*Dialog*foreground:        white
; Emacs*Foreground:       white
; Emacs*popup*Background: brown
; Emacs*popup*Foreground: white
; Emacs.default.attributeBackground:      black
; Emacs.default.attributeForeground:      white

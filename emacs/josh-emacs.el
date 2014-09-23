(load "shared")

(if (file-exists-p "~/spdtags.el")
    (progn
      (setq spdtag (concat (getenv "STORMBIRDS") "/common/emacs/spdtags.el"))
      (if (file-exists-p spdtag)
          (progn
            (load spdtag)
            (spdload-tags "~/spdtags.el")
            )
        )
      )
  )

(setq user-full-name "Josh Siegel")
(setq mail-default-reply-to "jsiegel@jumptrading.com\nX-Return-Receipt-To: jsiegel@jumptrading.com")
(setq user-mail-address "jsiegel@jumptrading.com")

(set-default 'indent-tabs-mode nil)

(setq visible-bell t)

(defun join-line () 
  (interactive) 
  (delete-indentation t)
  )

(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
		((looking-at "[])}]") (forward-char) (backward-sexp 1))
		(t (self-insert-command (or arg 1)))))

(put 'narrow-to-region 'disabled nil)

(setq mail-archive-file-name "~/mail/record")

(defun my-hide-other nil
   "set the minor mode at the same time"
   (interactive)
   (outline-minor-mode 1)
   (hide-other)
)

(defun set-mykeys ()
  "setup my personal keymaps"
  (interactive)
					; Keypad bindings
  (global-set-key [insert] 'undefined)

  (global-set-key "\C-cg" 'goto-line)
  (global-set-key "\C-ch" 'help-command)
  (global-set-key "\C-c\C-z" 'suspend-emacs)
  (global-set-key "\C-h" 'backward-delete-char-untabify)
  (global-set-key "\C-j" 'join-line)
  (global-set-key "\C-c%" 'match-paren)
  (global-set-key "\C-c+" 'show-subtree)
  (global-set-key "\C-c-" 'hide-subtree)
  (global-set-key "\C-c=" 'my-hide-other)
  (global-set-key "\C-c0" 'show-all)
  (global-set-key "\C-x%" 'match-paren)

  (global-set-key "\C-u" 'advertised-undo)
  (global-set-key "\C-w" 'backward-kill-word)
  (global-set-key "\C-xg" 'insert-register)
  (global-set-key "\C-xx" 'copy-to-register)
  (global-set-key "\C-x\C-u" 'universal-argument)
  (global-set-key "\C-x\C-w" 'kill-region)
  (global-set-key "\C-xn" 'switch-to-buffer)
  (global-set-key "\C-xo" 'other-window)

  (global-set-key "\C-z" ctl-z-map)
  (global-set-key "\C-z2" 'make-frame)
  (global-set-key "\C-z0" 'delete-frame)
  (global-set-key "\C-zo" 'other-frame)
  (global-set-key "\C-z\C-z" 'buffer-menu)
  (global-set-key "\C-z\C-w" 'write-file)
  (global-set-key [delete] 'delete-char)
  (global-set-key [end] 'end-of-buffer)
  (global-set-key [home] 'beginning-of-buffer)
  )

(defvar ctl-z-map (make-sparse-keymap))
(fset 'ctl-z-map ctl-z-map)

(defun minibuffer-complete-exit-backup nil
   "Minibuffer completion, exiting on unique completion with backup."
   (interactive)
   (let (comp (complete t))
	(while (null (setq comp (all-completions
				     (buffer-substring (point-min) (point))
				     minibuffer-completion-table
				     minibuffer-completion-predicate)))
	     (setq complete nil)
	     (delete-backward-char 1 nil))
	(and complete (if (null (cdr comp)) (minibuffer-complete-and-exit)
			   (minibuffer-complete)))))

(define-key minibuffer-local-must-match-map " " 
  'minibuffer-complete)

(define-key minibuffer-local-completion-map " " 
  'minibuffer-complete)

(defun region-regexp (regexp to-string) 
  (interactive "sQuery replace regexp: \nsQuery replace regexp %s with: ")
  (save-excursion
    (narrow-to-region (mark) (point))
    (goto-char (point-min))
    (replace-regexp regexp to-string)
    (widen)
    )
  )

(setq dired-listing-switches "-lt")

(set-mykeys)

(menu-bar-mode 0)
(tool-bar-mode 0)
(line-number-mode 1)
(column-number-mode 1)

(setq gnuserv-frame nil)

(global-auto-revert-mode)

 (setq vm-imap-server-list
      '(
         "imap-ssl:chiexchange01.w2k.jumptrading.com:993:inbox:login:jsiegel:*"
       )
 )

  (setq vm-spool-files
       '(
          "imap-ssl:chiexchange01.w2k.jumptrading.com:993:inbox:login:jsiegel:*"
        )
  )
 

; IMAP mail server:
; 
;   smtp.w2k.jumptrading.com
;   TLS authentication enabled
; 
; AddressBook (used by Thunderbird)
; 
;   server:  jumpmail1.w2k.jumptrading.com
;   baseDN: ou=people,dc=jumptrading,dc=com
; 
; Outbound SMTP:
; 
;   smtp.w2k.jumptrading.com
;   Enable using your name/password for outbound messages
; 
; Under composition and addressing for your primary jump account, make it look up
;    addresses using the LDAP address book configured above 

(setq vm-pop-expunge-after-retrieving 'nil)
(setq vm-imap-expunge-after-retrieving 'nil)

 (autoload 'vm "~/vm/vm" "Start VM on your primary inbox." t)
 (autoload 'vm-visit-folder "~/vm" "Start VM on an arbitrary folder." t)
 (autoload 'vm-mail "~/vm" "Send a mail message using VM." t)
 (autoload 'vm-submit-bug-report "~/vm" "Send a bug report about VM." t)


(defun use-my-c-style ()
  (interactive)
  (c-add-style "My C++" my-c-style t)
  (setq c-block-comments-indent-p 1)
  )
(add-hook 'c-mode-hook 'use-my-c-style)
(add-hook 'c++-mode-hook 'use-my-c-style)
(add-hook 'objc-mode-hook 'use-my-c-style)

(setq scroll-step 1)
(setq scroll-conservatively 50) 
(setq scroll-preserve-screen-position nil) 

;; uniquify!
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(setq default-indicate-empty-lines t)

(setq split-height-threshold 25) ; was 80
(setq split-width-threshold nil) ; was 160
(setq display-buffer-reuse-frames 't) ; nil
(setq pop-up-windows nil) ; was t




 ;; Set a Mode Line that tells me which machine, which directory,
     ;; and which line I am on, plus the other customary information.
; (setq-default mode-line-format
;               (quote
;                (#("-" 0 1
;                   (help-echo
;                    "mouse-1: select window, mouse-2: delete others ..."))
;                 mode-line-mule-info
;                 mode-line-modified
;                 mode-line-frame-identification
;                 "    "
;                 mode-line-buffer-identification
;                 "    "
;                 (:eval (substring
;                         (system-name) 0 (string-match "\\..+" (system-name))))
;                 ":"
;                 (:eval (progn 
;                          (setq url (shell-command-to-string "svn info|&grep URL"))
;                          (if (eq (length url) 0) default-directory (substring url 37 -1))
;                          ))
;                 #(" " 0 1 (help-echo "mouse-1: select window, mouse-2: delete others ..."))
;                 (line-number-mode " Line %l ")
;                 global-mode-string
;                 #("   %[(" 0 6 (help-echo "mouse-1: select window, mouse-2: delete others ..."))
;                 (:eval (mode-line-mode-name))
;                 mode-line-process
;                 minor-mode-alist
;                 #("%n" 0 2 (help-echo "mouse-2: widen" local-map (keymap ...)))
;                 ")%] "
;                 (-3 . "%P")
;                 ;;   "-%-"
;                 )))
; 
; 

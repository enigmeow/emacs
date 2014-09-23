;; vtags.el
;;
;; Written by Josh Siegel
;;

(setq spdtag-file-names nil)
(setq spdtags-list nil)
(setq spdmethod-list nil)

(defun spdinitialize-methods ()
  (message "Initializing method list...")
  (let (ptr bits)
    (setq bits (sort (mapcar 'car
      (apply 'append (mapcar '(lambda(x) (nth 3 x)) spdtags-list))) 'string<))
    (setq ptr bits)
    (while (cdr ptr)
      (if (string= (car ptr) (car (cdr ptr))) 
	  (rplacd ptr (cdr (cdr ptr)))
	(setq ptr (cdr ptr))
	)
      )
    (setq spdmethod-list (mapcar 'list bits))
    )
  (message "done")
)

(defun spdgoto (class method)
 "Goto specific tag"
  (interactive (list 
		(setq spdcurrent-class 
		      (completing-read "Class: " spdtags-list))
		(completing-read "Method: " 
		       (nth 3 (assoc spdcurrent-class spdtags-list)))))
  (let (spdmethod-entry)
	(setq spdmethod-entry (assoc method (nth 3 (assoc class spdtags-list))))
    (setq spdcurrent-class class)
    (spdgoto-file (nth 1 spdmethod-entry) (nth 2 spdmethod-entry))
    )
)


(defun spdclass (class)
  "goto a specific class"
  (interactive (list (setq spdcurrent-class 
 		      (completing-read "Class: " spdtags-list))))
 (let (spdthe-line)
   (setq spdthe-line (assoc class spdtags-list))
   (spdgoto-file (car (cdr spdthe-line)) 
		 (nth 2 spdthe-line))
 )
)

(defun spdreturn-method-and-class (meth)
  (list 
   (setq spdcurrent-method meth)
   (if (= (length (setq magic_list (apply 'append 
      (mapcar '(lambda(x) (if (car x) (list x) nil))
        (mapcar '(lambda(x) 
	  (list (if (assoc spdcurrent-method (nth 3 x)) (nth 0 x) nil))) 
	    spdtags-list))))) 1) 
       (car (car magic_list))
       (completing-read "Class: " magic_list)
     )
   )
)

(defun spdfunction (method class)
 "Goto a method in a class"
 (interactive (spdreturn-method-and-class 
	       (completing-read "method: " spdmethod-list)))
 (spdgoto class method)
)

(defun spdinverted (method class)
 "Goto a method in a class"
 (interactive (spdreturn-method-and-class 
	       (completing-read "method: " spdmethod-list)))
 (spdgoto class method)
)

(defun spdthis (method class)
  (interactive (spdreturn-method-and-class (current-word)))
  (spdgoto class method)
)

(defun spdgoto-file (file place)
  (find-file-other-window file)
  (if (numberp place)
      (goto-char (- place 2))
    (progn
      (goto-char (point-min))
      (search-forward place)
      (beginning-of-line)
      )
  )
)


(defun spdload-tags (file)
  "Load Magic tag file"
  (interactive "fMagic tags file: ")
  (let (new_critter spdbit-o-list)
    (spdunload-tags file)
    (load file)
;    (load-file file)
    (setq new_critter (list (list 
      file (mapcar '(lambda(x) (list (car (cdr x)))) spdbit-o-list))))
  
    (if spdtag-file-names
	(rplacd new_critter spdtag-file-names))
  
    (setq spdtag-file-names new_critter)

    (if spdtags-list
	(nconc spdtags-list spdbit-o-list)
        (setq  spdtags-list spdbit-o-list)
    )

    (spdinitialize-methods)
  )
)

(defun spdunload-tags (file)
  "Unload loaded tags file"
  (interactive (list (completing-read "Tag file:" spdtag-file-names)))
  (let (files)
    (setq files (car (cdr (assoc file spdtag-file-names))))
    (if files 
	(progn
	  (setq spdtags-list 
		(apply 'nconc 
		    (mapcar '(lambda(x) (if (assoc (car (cdr x)) files) nil (list x))) spdtags-list)
                )
          )
	  (spdinitialize-methods)
	  (setq spdtag-file-names (delq (assoc file spdtag-file-names) spdtag-file-names))
	)
    )
  )
)

(defun spdfile (file)
  (interactive (list (completing-read "File: " spdfiles)))
  (find-file-other-window (car (cdr (assoc file spdfiles))))
)

(defun spddescribe-word-here nil
  (interactive)

  (setq entry (assoc (current-word) method-list))
  (message (nth 1 entry))
)

(defun spddescribe-word nil
  (interactive)

  (spddescribe-word-here)
  (insert last-command-char)
)

(defun spddesc-setup  nil
  (interactive)
)

 (add-hook 'python-mode-hook 
    '(lambda ()
       (define-key python-mode-map "(" 'spddescribe-word)
 ))

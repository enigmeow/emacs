
(defun perform-replace (from-string to-string
		        query-flag regexp-flag delimited-flag)
  (let ((nocasify (not (and case-fold-search case-replace
			    (string-equal from-string
					  (downcase from-string)))))
	(literal (not regexp-flag))
	(search-function (if regexp-flag 're-search-forward 'search-forward))
	(search-string from-string)
	(keep-going t)
	(lastrepl nil))			;Position after last match considered.
    (if delimited-flag
	(setq search-function 're-search-forward
	      search-string (concat "\\b"
				    (if regexp-flag from-string
				      (regexp-quote from-string))
				    "\\b")))
    (push-mark)
    (push-mark)
    (while (and keep-going
		(not (eobp))
		(progn
		 (set-mark (point))
		 (funcall search-function search-string nil t)))
      ;; Don't replace the null string 
      ;; right after end of previous replacement.
      (if (eq lastrepl (point))
	  (forward-char 1)
;	(undo-boundary)
	(if (not query-flag)
	    (replace-match to-string nocasify literal)
	  (let (done replaced)
	    (while (not done)
	      ;; Preserve the match data.  Process filters and sentinels
	      ;; could run inside read-char..
	      (let ((data (match-data))
		    (help-form
		     '(concat "Query replacing "
			      (if regexp-flag "regexp " "")
			      from-string " with " to-string ".\n\n"
			      (substitute-command-keys query-replace-help))))
		(setq char help-char)
		(while (= char help-char)
		  (message "Query replacing %s with %s: " from-string to-string)
		  (setq char (read-char))
		  (if (= char ??)
		      (setq unread-command-char help-char char help-char)))
		(store-match-data data))
	      (cond ((or (= char ?\e)
			 (= char ?q))
		     (setq keep-going nil)
		     (setq done t))
		    ((= char ?^)
		     (goto-char (mark))
		     (setq replaced t))
		    ((or (= char ?\ )
			 (= char ?y))
		     (or replaced
			 (replace-match to-string nocasify literal))
		     (setq done t))
		    ((= char ?\.)
		     (or replaced
			 (replace-match to-string nocasify literal))
		     (setq keep-going nil)
		     (setq done t))
		    ((= char ?\,)
		     (if (not replaced)
			 (progn
			   (replace-match to-string nocasify literal)
			   (setq replaced t))))
		    ((= char ?!)
		     (or replaced
			 (replace-match to-string nocasify literal))
		     (setq done t query-flag nil))
		    ((or (= char ?\177)
			 (= char ?n))
		     (setq done t))
		    ((= char ?\C-l)
		     (recenter nil))
		    ((= char ?\C-r)
		     (store-match-data
		       (prog1 (match-data)
			 (save-excursion (recursive-edit)))))
		    ((= char ?\C-w)
		     (delete-region (match-beginning 0) (match-end 0))
		     (store-match-data
		       (prog1 (match-data)
			 (save-excursion (recursive-edit))))
		     (setq replaced t))
		    (t
		     (setq keep-going nil)
		     (setq unread-command-char char)
		     (setq done t))))))
	(setq lastrepl (point))))
    (pop-mark)
    keep-going))

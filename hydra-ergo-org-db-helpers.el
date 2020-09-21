(defun hydra-ergo-org-to-vars ()
  "Go through org file and create variables with names from
from top headline containing at list with names of all subheadings"
  (interactive)
  (let (vname group)
    (org-map-entries
     '(progn
	(move-end-of-line nil)
	(if (equal (car (org-heading-components)) 1)
	    (progn
	      (when vname
		(set (intern vname) group)
		(setq group nil))
	      (setq vname (current-word)))
	  (push (current-word) group))))
    (set (intern vname) group)))
    
(defun hydra-ergo-add-var-orgfile (parent entry)
  (interactive)
  (goto-line 0)
  (when (search-forward parent nil nil)
    (org-narrow-to-subtree)
    (unless (search-forward-regexp (concat entry "$") nil t)
      (org-insert-subheading entry)
      (insert entry)))
  (widen))

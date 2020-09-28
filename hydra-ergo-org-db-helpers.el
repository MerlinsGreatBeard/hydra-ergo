(defun hydra-ergo-org-to-vars (fname)
  "Go through org file and create variables with names from
from top headline containing at list with names of all subheadings"
  (find-file fname)
  (goto-line 0)
  ;; (interactive)
  (let (vname group)
    (org-map-entries
     '(progn
	(move-end-of-line nil)
	(if (equal (car (org-heading-components)) 1)
	    (progn
	      (org-show-children)
	      (when vname
		(set (intern vname) group)
		(setq group nil))
	      (setq vname (current-word)))
	  (push (current-word) group))))
    (set (intern vname) group))
  (kill-buffer))
    
(defun hydra-ergo-add-var-orgfile (fname parent entry)
  (find-file fname)
  (goto-line 0)
  (when (search-forward parent nil nil)
    (org-narrow-to-subtree)
    (unless (search-forward-regexp (concat entry "$") nil t)
      (org-insert-subheading entry)
      (insert entry)))
  (save-buffer)
  ;; (kill-buffer)
  (widen))

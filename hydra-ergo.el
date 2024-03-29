(defhydra hydra-ergo (evil-normal-state-map "SPC" :color blue)
  "hydra-ergo "
  ("a" execute-extended-command :color blue)
  ("d" hydra-ergo-d-menu/body :color blue)
  ("e" hydra-ergo-e-menu/body :color blue)
  ("f" persp-switch-to-buffer :color blue)
  ("g" mgb/sel-from-org-prop)
  ("i" hydra-ergo-i-menu/body :color blue)
  ("o" (lambda ()
	 (interactive)
	 (other-window 1)
	 (hydra-ergo-o-menu/body)) :color blue)
  ("O" (lambda ()
	 (interactive)
	 (other-frame 1)
	 (hydra-ergo-capital-o-menu/body)) :color blue)
  ("r" hydra-ergo-r-menu/body :color blue)
  ("ö" save-buffer :color blue)
  ("w" ace-window :color blue)
  ("j" evil-search-forward :color blue)
  ("k" evil-search-backward :color blue)
  ("l" swiper :color blue)
  ("m" hydra-ergo-m-menu/body :color blue)
  ("n" swiper-thing-at-point :color blue)
  ("s" hydra-ergo-s-menu/body :color blue)
  ("t" hydra-ergo-t-menu/body :color blue)
  ("T" hydra-ergo-cap-t-menu/body :color blue)
  ("y" hydra-ergo-y-menu/body :color blue)
  ("§" hydra-ergo-§-menu/body :color blue)
  ("c" hydra-ergo-c-menu/body :color blue)
  ("2" split-window-below :color blue)
  ("3" split-window-right :color blue)
  ("4" delete-other-windows :color blue)
  ("5" hydra-ergo-5-menu/body :color blue)
  ("0" delete-window :color blue)
  ("<" hydra-ergo-<-menu/body :color blue)
  ("å" (lambda ()
	 (interactive)
	 (setq abbr-swe (not abbr-swe))
	 (load "~/.emacs.d/lisp/my-abbrev.el")))
  ("x" hydra-ergo-x-menu/body :color blue)
  ("," fixup-whitespace :color blue)
  ("z" hydra-ergo-z-menu/body :color blue))
  ;; (global-set-key (kbd "M-SPC") 'hydra-ergo/body)
  ;; (define-key evil-motion-state-map (kbd "SPC") 'hydra-ergo/body)

(defvar hydra-ergo-intercept-mode-map (make-sparse-keymap)
"High precedence keymap.")

(define-minor-mode hydra-ergo-intercept-mode
"Global minor mode for higher precedence evil keybindings."
:global t)

(hydra-ergo-intercept-mode)

(dolist (state '(normal motion))
(evil-make-intercept-map
;; NOTE: This requires an evil version from 2018-03-20 or later
(evil-get-auxiliary-keymap hydra-ergo-intercept-mode-map state t t)
state))

(evil-define-key 'normal hydra-ergo-intercept-mode-map
(kbd "SPC") 'hydra-ergo/body)
(evil-define-key 'motion hydra-ergo-intercept-mode-map
(kbd "SPC") 'hydra-ergo/body)

(defhydra hydra-ergo-c-menu (:color blue)
  ("a" (lambda ()
	 (interactive)
	 (org-entry-put nil "TRIGGER" (concat (completing-read "finder"
							       '("ancestors"
								 "children"
								 "descendants"
								 "file"
								 "first-child"
								 "ids"
								 "match"
								 "next-sibling"
								 "next-sibling-wrap"
								 "olp"
								 "org-file"
								 "parent"
								 "previous-sibling"
								 "previous-sibling-wrap"
								 "relatives"
								 "rest-of-siblings"
								 "rest-of-siblings-wrap"
								 "self"
								 "siblings"
								 "siblings-wrap"))
					      " "
					      (completing-read "action"
							       '(
								 "scheduled!"
								 "deadline!"))
					      "(\"++0h\")"))))
  ("b" hydra-ergo-org-brain/body)
  ("e" org-journal-new-entry)
  ("n" org-narrow-to-subtree)
  ("d" widen)
  ("i" hydra-ergo-org-download/body)
  ;; ("j" (org-brain-visualize (org-brain-entry-at-pt)))
  ("j" hydra-ergo-org-rifle/body)
  ;; ("k" (lambda ()
  ;; 	 (interactive)
  ;; 	 (if (not (org-clocking-p))
  ;; 	     (org-pomodoro-kill)
  ;; 	   (org-pomodoro-kill)
  ;; 	   (org-pomodoro-start :short-break))))
  ("k" (lambda ()
	 (interactive)
	 (let ((start-break
		(or (org-clocking-p)
		    (equal org-pomodoro-state :none))))
	   (org-pomodoro-kill)
	   (when start-break
	     (org-pomodoro-start :short-break)))))
  ("l" (lambda ()
	 (interactive)
	 (org-time-stamp-inactive '(16))
	 (org-clock-update-time-maybe)))
  ;; ("o" (lambda ()
  ;; 	 (interactive)
  ;; 	 (set-pomodoro-len-from-property)
  ;; 	 (org-pomodoro)))
  ("o" (hydra-mgb/pomodoro/body)
   ;; (lambda ()
   ;; 	 (interactive)
   ;; 	 (if org-timer-start-time
   ;; 	     (org-timer-stop)
   ;; 	   (let ((pomotime 
   ;; 		  (completing-read "minutes:" '("14" "10" "8") nil nil "14")))
   ;; 	     (hydra-mgb/pomodoro/body)
   ;; 	     (org-timer-set-timer pomotime))))
   )
  ("x" (org-cut-special))
  ("w" (org-copy-special))
  ("s" (org-sparse-tree))
  ("f" (org-refile))
  ("y" (org-paste-special nil))
  ("q" (org-ql-menu/body) "org-ql menu")
  )

(defhydra hydra-ergo-d-menu (:color blue)
  ("f" dired)
  ("j" dired-jump)
  ("k" hydra-ergo-ranger)
  ("w" ranger-kill-buffers-without-window "ranger-kill-buffers-without-window)"))

(defhydra hydra-ergo-e-menu (:color blue)
 ("j" quick-calc))

(defhydra hydra-ergo-i-menu (:color blue)
	"i-menu"
	("f" find-file)
	("w" burly-bookmark-windows)
	("o" bookmark-jump)
	("p" bookmark-set)
	("i" bookmark-bmenu-list))

(defhydra hydra-ergo-m-menu (:color blue)
   ;; ("SPC" xah-clean-whitespace)
   ;; ("TAB" move-to-column)
   ;; ("1" xah-clear-register-1)
   ;; ("2" xah-append-to-register-1)
   ;; ("3" xah-copy-to-register-1)
   ;; ("4" xah-paste-from-register-1)
   ("." sort-lines)
   ("," sort-numeric-fields)
   ("'" reverse-region)
   ;; ("c" goto-char)
   ("d" mark-defun)
   ("e" list-matching-lines)
   ("f" (switch-to-buffer (clone-indirect-buffer nil nil)) "clone ind buf")
   ("i" delete-non-matching-lines)
   ("j" copy-to-register)
   ("l" insert-register)
   ("k" kill-buffer)
   ;; ("l" xah-escape-quotes)
   ;; ("m" xah-make-backup-and-save)
   ("n" repeat-complex-command)
   ("p" query-replace-regexp)
   ("r" revert-buffer)
   ("t" repeat)
   ("u" delete-matching-lines)
   ;; ("w" xah-next-window-or-frame)
   ("y" delete-duplicate-lines))

(defhydra hydra-ergo-o-menu (:color red)
	("o" other-window :color red))

(defhydra hydra-ergo-capital-o-menu (:color red)
  ("o" other-window :color red)
  ("O" other-frame :color red))

(defhydra hydra-ergo-r-menu (:color blue)
  "r-menu"
  ("k" eyebrowse-close-window-config)
  ("1" eyebrowse-switch-to-window-config-1)
  ("2" eyebrowse-switch-to-window-config-2)
  ("3" eyebrowse-switch-to-window-config-3)
  ("4" eyebrowse-switch-to-window-config-4)
  ("5" eyebrowse-switch-to-window-config-5)
  ("6" eyebrowse-switch-to-window-config-6)
  ("7" eyebrowse-switch-to-window-config-7)
  ("8" eyebrowse-switch-to-window-config-8)
  ("9" eyebrowse-switch-to-window-config-9)
  ("0" eyebrowse-switch-to-window-config-0)
  ("n" eyebrowse-rename-window-config "rename-window")
  ("i" evil-numbers/inc-at-pt)
  ("d" evil-numbers/dec-at-pt))

(defhydra hydra-ergo-s-menu (:color blue)
  "Format Text org-mode-style"
  ("i" (ergo-surround #x2F #x2F 1))
  ;; ("i" (lambda (&optional arg) (interactive "p") (sp-wrap-with-pair "/")))
  ("b" (ergo-surround #x2A #x2A 1))
  ("c" (ergo-surround #x7e #x7e 1))
  ("u" (ergo-surround #x5F #x5F 1))
  ("k" (ergo-surround #x2b #x2b 1))
  ("r" (ergo-surround #x3C #x3E 3)))

(defhydra hydra-ergo-t-menu (:color blue)
  "Timers"
  ("j" tea-timer "tea-timer")
  ("k" (lambda ()
	 (interactive)
	 (org-pomodoro-start :short-break))
   "pomodoro short break")
  ("o" chronos-add-timer "chronos-add-timer"))

(defun save-theme-settings (group)
  (let ((curr-theme (car custom-enabled-themes)))
    (if (listp (symbol-value (intern group)))
	(add-to-list (intern group) curr-theme)
      (set (intern group) (list curr-theme)))
    (when (file-exists-p hydra-ergo-fav-themes-fname)
      (hydra-ergo-add-var-orgfile hydra-ergo-fav-themes-fname group (symbol-name
								     curr-theme)))))
(defhydra hydra-ergo-cap-t-menu (:color red :post (set-fringe-style 0))
  "Theme Commands"
  ("j" rand-theme-iterate "rand theme iterate")
  ("k" rand-theme-iterate-backwards "rand theme iterate backwards")
  ("f" rand-theme "rand theme")
  ("r" (reload-theme) "reload-theme")
  ("d" (progn
	 (save-theme-settings "fav-dark-themes")
	 (print "Theme added to fav-dark-themes")) "add to fav-dark")
  ("l" (rand-theme--load-theme (intern (completing-read "Load theme:" `(,@fav-dark-themes ,@fav-light-themes ,@ef-themes-collection)))))
  ("i" (progn
	 (save-theme-settings "fav-light-themes")
	 (print "Theme added to fav-light-themes")) "add to fav-light")
  ("u" (progn
	 (save-theme-settings "rand-theme-unwanted")
	 (print "Theme added to unwanted-themes")) "add to unwanted themes")
  ("n" (lambda ()
	 (interactive)
	 (print (car custom-enabled-themes))) "show name of current theme")
  ("q" nil "quit"))

(defhydra hydra-ergo-x-menu (:color blue)
  ("r" (lambda ()
	 (interactive)
	 (cond (centered-cursor-mode 
		(centered-cursor-mode 0)
		(hl-line-mode -1))
	       (t (centered-cursor-mode)
		  (hl-line-mode)
		  (set-face-background hl-line-face "DarkGrey")
		  (setq ccm-vpos 14))))))

(defhydra hydra-ergo-y-menu (:color blue)
  ("d" aya-create "aya-create")
  ("f" aya-expand "aya-expand")
  ("m" yankpad-map "yankpad-map")
  ("e" yankpad-expand "yankpad-expand")
  ("c" yankpad-set-category "yankpad-set-category"))

(defhydra hydra-ergo-5-menu (:color blue)
  ("c" make-frame-command)
  ("d" delete-frame)
  ("o" other-frame "other-frame" :color red)
  ("q" nil "quit"))

(defhydra hydra-ergo-z-menu (:color blue)
  ("-" pulseaudio-control-decrease-volume "decrease-volume" :color red)
  ("d" pulseaudio-control-display-volume "display-volume")
  ("+" pulseaudio-control-increase-volume "increase-volume" :color red)
  ("m" pulseaudio-control-toggle-current-sink-mute "toggle-current-sink-mute")
  ("x" pulseaudio-control-toggle-sink-mute-by-index "toggle-sink-mute-by-index")
  ("e" pulseaudio-control-toggle-sink-mute-by-name "toggle-sink-mute-by-name")
  ("]" pulseaudio-control-toggle-use-of-default-sink "toggle-use-of-default-sink")
  ("i" pulseaudio-control-select-sink-by-index "select-sink-by-index")
  ("n" pulseaudio-control-select-sink-by-name "select-sink-by-name")
  ("v" pulseaudio-control-set-volume "set-volume")
  ("b" hydra-ergo-bt-menu/body "bluetooth menu"))

(defhydra hydra-ergo-<-menu (:color blue)
  ("j" calendar "Simple Calendar")
  ("o" cfw:open-org-calendar "Org-Calendar"))

(defhydra hydra-ergo-bt-menu (:color blue)
  ("c" (lambda (arg)
	 (interactive (list (completing-read "device:" (split-string (shell-command-to-string "bluetoothctl devices") "\n") nil)))
	 (shell-command "bluetoothctl power on")
	 (shell-command (concat "bluetoothctl connect " 
				(cadr (split-string arg " "))))) "connect to bt device")
  ("d" (lambda ()
	 (interactive)
	 (shell-command "bluetoothctl disconnect")) "disconnect device")
  ("s" (lambda ()
	 (interactive)
	 (shell)
	 (switch-to-buffer "*shell*")
	 (insert "bluetoothctl")) "run shell"))

(defhydra hydra-ergo-org-download (:color blue)
  ("i" (lambda ()
	 (interactive)
	 (org-download-image "c:/Users/SEOLSV/OneDrive - Hoganas AB/Bilder/Snapshot/Capture.png")))
  ("f" (lambda ()
	 (interactive)
	 (org-download-image
	  (read-file-name "filnamn: " "C:/temp/"))))
  ("d" org-download-delete))

(defhydra hydra-ergo-org-rifle (:color blue)
("j" helm-org-rifle "Show results from all open Org buffers")
("a" helm-org-rifle-agenda-files "Show results from Org agenda files")
("b" helm-org-rifle-current-buffer "Show results from current buffer")
("d" helm-org-rifle-directories "Show results from selected directories")
("r" (lambda ()
       (interactive)
       ;; (setq current-prefix-arg '(4)) ; C-u
       (helm-org-rifle-directories nil nil)
       ) "Show results from selected directories recursively")
("s" helm-org-rifle-files "Show results from selected files")
("o" helm-org-rifle-org-directory "Show results from Org files in org-directory")
("c" hydra-ergo-org-rifle-occur/body "Occur variants")
("m" (lambda ()
       (interactive)
       (let ((choice (ivy-completing-read "Select: " '(".org$" ".org\\(_archive\\)?$"))))
	 (setq helm-org-rifle-directories-filename-regexp choice))) "Choose regexp for dir filenames"))

(defhydra hydra-ergo-org-rifle-occur (:color blue)
("j" helm-org-rifle-occur "Show results from all open Org buffers")
("a" helm-org-rifle-occur-agenda-files "Show results from Org agenda files")
("b" helm-org-rifle-occur-current-buffer "Show results from current buffer")
("d" helm-org-rifle-occur-directories "Show results from selected directories; with prefix, recursively")
("r" helm-org-rifle-occur-files "Show results from selected files")
("o" helm-org-rifle-occur-org-directory "Show results from Org files in org-directory"))

(defun hydra-ergo-swbrain (brain)
  (setq hydra-ergo-chosen-brain (cdr (assoc brain org-brains)))
  ;; (setq org-id-locations-file (convert-standard-filename (car (cdr hydra-ergo-chosen-brain))))
  ;; hmm are we removing some important locations here?  
  ;; replace with function that removes files from other brain       
  ;; see cl-remove-if 
  (setq org-id-files 
	(cl-remove-if (lambda (file)
			(string-match org-brain-pattern file)) org-id-files))
  (org-brain-switch-brain hydra-ergo-chosen-brain)
  ;; Mark this brain to be used on next startup 
  ;; Since org-id-update-id-locations() will save the new file/id associations for the new brain to be used on next startup.
  (with-temp-file "~/.emacs.d/emacs-current-brain"
    (insert org-brain-path))
  ;; (setq org-brain-path (car hydra-ergo-chosen-brain))
  )
(defhydra hydra-ergo-brain-switch (:color blue)
  ("c" (hydra-ergo-swbrain 'c))
  ("h" (hydra-ergo-swbrain 'h)))
(defhydra hydra-ergo-org-brain (:color blue)
  ("b" org-brain-visualize "org-brain-visualize")
  ("s" hydra-ergo-brain-switch/body "switch brain")
  ("m" brain-find-mirror-file "find mirror file"))

(defhydra hydra-mgb/pomodoro (:pre (progn
				(interactive)
				(if org-timer-start-time
				    (org-timer-stop)
				  (setq hydra-mgb/pomotime 
					(completing-read "minutes:" `(,hydra-mgb/pomotime "14" "10" "8") nil nil "14")
				    ;; (hydra-mgb/pomodoro/body)
				    (org-timer-set-timer pomotime)))))
  ("i" org-clock-in "org-clock-in")
  ("x" org-clock-in-last "org-clock-in-last"))

(defun ergo-surround (begc endc repeat)
  (interactive)
  (let ((i 0))
    (backward-char)
    (evil-forward-WORD-end)
    (forward-char)
    (while (< i repeat)
      (insert-char endc)
      (setq i (+ 1 i))
      )
    (setq i 0)
    (evil-backward-WORD-begin)
    (while (< i repeat)
      (insert-char begc)
      (setq i (+ 1 i))
      )
    (evil-forward-WORD-end)))

(defun set-pomodoro-len-from-property ()
    "Pomodoro length can be set by org property."
    (let ((len (org-entry-get (point) "POMODORO")))
    (if len
	(setq  org-pomodoro-length (string-to-number len))
	nil)))

(defun hydra-ergo-ranger ()
  "Try to open the selected region if there is one, otherwise just call ranger."
  (interactive)
  (if (region-active-p)
      (ranger (buffer-substring (region-beginning) (region-end)))
    (ranger)))

;; (setq hydra-ergo-dir "/home/olle/.emacs.d/hydra-ergo/")
;; (load (concat hydra-ergo-dir "hydra-ergo-org-db-helpers.el"))
;; (setq hydra-ergo-fav-themes-fname (concat
;; 			 hydra-ergo-dir "fav-themes.org"))
;; (hydra-ergo-org-to-vars hydra-ergo-fav-themes-fname)

(defun mgb/sel-from-org-prop ()
  (interactive)
  (let ((name (org-entry-get (point) "menuname"))
	(items (org-entry-get (point) "menuitems")))
    ;; (print (type-of (split-string items)))
    (insert (completing-read name (split-string items)))
    (when (org-table-p)
      (org-table-align))
    ))
;;   ((insert (completing-read "Brännartyp" '("STD" "SUPER")))))
;; (lambda ()
;;        (let ((header (car (-filter #'stringp (org-heading-components)))))
;; 	 (when (string= header tblfilter)
;; 	   (setq rtbl (nconc rtbl (org-table-to-lisp)))
;; 	   ))))

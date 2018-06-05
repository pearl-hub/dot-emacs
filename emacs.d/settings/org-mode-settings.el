; https://orgmode.org/features.html

(setq org-todo-keywords
    '((sequence "TODO" "BLOCKED" "IN-PROGRESS" "|" "DONE")))

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

;; set idle time to 10 minutes
(setq org-clock-idle-time 10)

;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)

;; Date/Time format
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%y-%m-%d %a>" . "<%y-%m-%d %a %H:%M>"))

;; Remember settings
(setq org-directory "~/orgfiles/")
(setq org-default-notes-file "~/notes.org")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

;; templates on the office computer
(setq org-remember-templates
    '(
     ("Todo" ?t "* TODO %^{Brief Description} %?\nAdded: %U" "~/orgfiles/notes.org" "Tasks")
     ("Journal" ?j "\n* %^{topic} %T \n%i%?\n" "~/orgfiles/notes.org")
     ("Private" ?p "\n* %^{topic} %T \n%i%?\n" "~/orgfiles/privnotes.org")
     ("Contact" ?c "\n* %^{Name} :CONTACT:\n" "~/orgfiles/privnotes.org" "Contacts")
     ))

;; Set agenda key binding
(define-key global-map "\C-ca" 'org-agenda)

(provide 'org-mode-settings)

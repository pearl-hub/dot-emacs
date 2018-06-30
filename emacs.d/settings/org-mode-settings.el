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


;; Set wip limit on a specific state
;; https://emacs.stackexchange.com/questions/10206/limit-number-of-org-todo-items-in-a-certain-state
(defun org-count-todos-in-state (state)
  (let ((count 0))
    (org-scan-tags (lambda ()
                     (when (string= (org-get-todo-state) state)
                       (setq count (1+ count))))
                   t t)
    count))

;; Set IN-PROGRESS WIP limit to two in order to deal with subtasks.
;; This may be improved by forcing the WIP limit only on the highest level tasks.
(defvar org-wip-limit 2  "Work-in-progress limit")
(defvar org-wip-state "IN-PROGRESS")

(defun org-block-wip-limit (change-plist)
  (catch 'dont-block
    (when (or (not (eq (plist-get change-plist :type) 'todo-state-change))
              (not (string= (plist-get change-plist :to) org-wip-state)))
      (throw 'dont-block t))

    (when (>= (org-count-todos-in-state org-wip-state) org-wip-limit )
      (setq org-block-entry-blocking (format "WIP limit: %s" org-wip-state))
      (throw 'dont-block nil))

    t)) ; do not block

(add-hook 'org-blocker-hook #'org-block-wip-limit)


(provide 'org-mode-settings)

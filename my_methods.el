(defun print-list (list)
  "prints a list right in the buffer"
  (if (= 0 (length list)) () (insert (int-to-string (car list))) (print-list (cdr list)))
)

(print-list '(1 2 3))

(defun replace-double-breaks ()
  (interactive)
  (while (re-search-forward "<br /><br />" nil t)
    (replace-match "</p>\n<p>")))

(defun replace-breaks ()
  (interactive)
  (while (re-search-forward "<br />" nil t)
    (replace-match "\n")))

(defun replace-breaks-region (start end)
  "replace break tags with a newline"
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward "<br />" nil t) (replace-match "\n" nil t))
    )
  )

(defun replace-double-breaks-region (start end)
  "replace double break tags with a para close"
  (interactive "r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (search-forward "<br /><br />" nil t) (replace-match "</p>\n<p>" nil t))
    )
  )

(defun promote-headers ()
  "make h2 => h1, h3 => h2, etc"
  (interactive)
  (setq levels '(2 3 4 5 6 7 8))
  (loop for level in levels do
        (promote-header level)
        )
)

(defun promote-header (level)
  "make h<level> h<level - 1>"
  (while (search-forward (concat "<h" (int-to-string level) ">") nil t)
    (replace-match (concat "<h" (int-to-string (- level 1)) ">") nil t))
  (goto-char (point-min))
  (while (search-forward (concat "</h" (int-to-string level) ">") nil t)
    (replace-match (concat "</h" (int-to-string (- level 1)) ">") nil t))
  (goto-char (point-min))
  )

(defun demote-header (level)
  "make h<level> h<level + 1>"
  (while (re-search-forward (concat "</?h\\(" (int-to-string level) "\\)>") nil t)
    (replace-match (int-to-string (+ level 1)) nil nil nil 1))
  (goto-char (point-min))
  )

(defun demote-headers ()
  (interactive)
  (demote-headers-internal 8))

(defun demote-headers-internal (level)
  "make h1 => h2, h2 => h3, etc"
  (if (= level 0) () (demote-header level) (demote-headers-internal (- level 1)))
  )

(defun insert-tildes ()
  "put a bunch of tildes here"
  (interactive)
  (insert "~~~~~~~~")
  )

;; this is actually usefule, so make it work with c-x t
(global-set-key (kbd "C-x t") 'insert-tildes)

;; to-do
(defun wrap-in-tildes ()
  "wrap the selected block in tildes"
  (interactive)
  (insert "~~~~~~~"))

(defun leanpub-status-and-check ()
  "add code to check book status and set a message"
  (interactive)
  (insert "(clear_mutex(params) && next) if check_for_abort(params)")
  (indent-according-to-mode)
  (newline)
  (insert "set_status_message(params, :)")
  (indent-according-to-mode)
  (backward-char 1)
)

(global-set-key (kbd "C-x C-l") 'leanpub-status-and-check)

(defun generate-random-uuid ()
  "Insert a UUID.
   This commands calls “uuidgen” on MacOS, Linux, and calls PowelShell
   on Microsoft Windows.
   URL `http://xahlee.info/emacs/emacs/elisp_generate_uuid.html'
   Version 2020-06-04"
  (cond ((string-equal system-type "windows-nt")
         (shell-command-to-string "pwsh.exe -Command [guid]::NewGuid().toString()"))
        ((string-equal system-type "darwin")
         (shell-command-to-string "uuidgen"))
        ((string-equal system-type "gnu/linux")
         (shell-command-to-string "uuidgen"))
        (t
         (let ((seed (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                                  (user-uid)
                                  (emacs-pid)
                                  (system-name)
                                  (user-full-name)
                                  (current-time)
                                  (emacs-uptime)
                                  (garbage-collect)
                                  (buffer-string)
                                  (random)
                                  (recent-keys)))))
           (format "%s-%s-4%s-%s%s-%s"
                   (substring seed 0 8)
                   (substring seed 8 12)
                   (substring seed 13 16)
                   (format "%x" (+ 8 (random 4)))
                   (substring seed 17 20)
                   (substring seed 20 32))))))

(defun insert-random-uuid ()
  "Inserts a random uuid in the current cursor position"
  (interactive)
  (insert (downcase (replace-regexp-in-string "\n$" "" (generate-random-uuid)))))

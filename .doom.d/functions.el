;;; $DOOMDIR/functions.el -*- lexical-binding: t; -*-

(defun directory-path-p (path)
  (and (file-exists-p path)
       (file-directory-p path)))

(defun add-project-directories (&rest paths)
  (seq-filter #'directory-path-p paths))

(defun gptel-make-netflix-mg-endpoint (workspace-name)
  (format "/proxy/%s/v1/chat/completions" workspace-name))

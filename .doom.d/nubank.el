;;; ../.dotfiles/.doom.d/nubank.el -*- lexical-binding: t; -*-

(defun add-project-path! (project-path)
  (when (file-directory-p project-path)
    (add-to-list 'projectile-project-search-path project-path)))

(when (add-project-path! "~/dev/nu/")
  (add-project-path! "~/dev/nu/mini-meta-repo/packages")
  (when (file-directory-p "~/dev/nu/nudev/ides/emacs/")
    (use-package! nu
      :load-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p "~/dev/nu/isa.el")
    (use-package! isa
      :load-path "~/dev/nu/isa.el")))

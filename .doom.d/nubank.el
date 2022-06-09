;;; ../.dotfiles/.doom.d/nubank.el -*- lexical-binding: t; -*-

(defun add-project-path! (project-path)
  (when (file-directory-p project-path)
    (add-to-list 'projectile-project-search-path project-path)))

(when (add-project-path! "~/dev/nu/")
  (add-project-path! "~/dev/nu/mini-meta-repo/packages")

  (let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
    (when (file-directory-p nudev-emacs-path)
      (add-to-list 'load-path nudev-emacs-path)
      (require 'nu nil t)
      (require 'nu-datomic-query nil t)))

  (when (file-directory-p "~/dev/nu/isa.el")
    (use-package! isa
      :load-path "~/dev/nu/isa.el")))

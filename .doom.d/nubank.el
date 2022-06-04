;;; ../.dotfiles/.doom.d/nubank.el -*- lexical-binding: t; -*-

(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu nil t)))

(let ((nudev-projects-path "~/dev/nu/"))
  (when (file-directory-p nudev-projects-path)
    (add-to-list 'projectile-project-search-path nudev-projects-path)))

;;; ../.dotfiles/.doom.d/nubank.el -*- lexical-binding: t; -*-

(let ((nudev-projects-path "~/dev/nu/"))
  (when (file-directory-p nudev-projects-path)
    (add-to-list 'projectile-project-search-path nudev-projects-path)
    (when-let* ((nudev-minimeta-path (concat nudev-projects-path "mini-meta-repo/packages/"))
                (_directory-p         (file-directory-p nudev-minimeta-path)))
      (add-to-list 'projectile-project-search-path nudev-minimeta-path))
    (when-let* ((nudev-emacs-path (concat nudev-projects-path "nudev/ides/emacs/"))
                (_directory-p      (file-directory-p nudev-emacs-path)))
      (add-to-list 'load-path nudev-emacs-path)
      (require 'nu nil t))
    (when-let* ((nudev-isa-path (concat nudev-projects-path "isa.el"))
                (_directory-p    (file-directory-p nudev-isa-path)))
      (use-package! isa
        :load-path nudev-isa-path
        :config
        (map! :leader :desc "isa" "N i" #'isa)))))

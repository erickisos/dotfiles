;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq  user-full-name                 "Erick G. Islas Osuna"
       user-mail-address              "erick@tliwaka.com.mx"
       doom-theme                     'doom-one
       org-directory                  "~/Documents/Cloud/Notes/"
       display-line-numbers-type      t
       projectile-project-search-path '("~/Documents/Github")
       evil-vsplit-window-right       t
       evil-split-window-below        t
       doom-font                      (font-spec :family "Fira Code" :size 12)
       doom-themes-treemacs-theme     "all-the-icons"
       ispell-dictionary              "es")

(use-package! treemacs-all-the-icons
  :after treemacs)

(use-package! org-mind-map
  :after ox-org
  :config
  (setq org-mind-map-engine "dot"))

(use-package! lsp-metals
  :ensure t
  :hook (scala-mode . lsp))

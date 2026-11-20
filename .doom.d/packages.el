;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el -*- lexical-binding: t; -*-

(unpin! treemacs)
(unpin! lsp-treemacs)
(unpin! lsp-ui)
(unpin! lsp-mode)

(package! treemacs-all-the-icons)
(package! scss-mode)

(package! po-mode
  :recipe (:local-repo "~/Documents/Github/po-mode" :files ("*.el" "Makefile") :build (:not compile))
  )

(package! ox-moderncv
  :recipe (:host github :repo "erickisos/org-cv" :files ("*.el")))

(package! ox-typst
  :recipe (:host github :repo "jmpunkt/ox-typst" :files ("*.el")))

(unpin! org-roam)
(unpin! org)

;; (package! org-roam-ui)

(package! eca
  :recipe (:host github :repo "editor-code-assistant/eca-emacs" :files ("*.el")))

(package! claude-code-ide
  :recipe (:host github :repo "manzaltu/claude-code-ide.el"))

(package! gradle-mode
  :recipe (:host github :repo "erickisos/emacs-gradle-mode" :files ("*.el" "Makefile")))

(package! obsidian)

(package! why-this
  :recipe (:host github :repo "erickisos/emacs-why-this" :files ("*.el" "Makefile")))

(package! flyover
  :recipe (:host github :repo "konrad1977/flyover" :files ("*.el")))

(package! codesnap
  :recipe (:host github :repo "erickisos/codesnap.el" :files ("*.el")))

(package! typst-ts-mode
  :recipe (:host codeberg :repo "meow_king/typst-ts-mode"))

;; (package! platformio-mode)

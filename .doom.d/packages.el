;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el -*- lexical-binding: t; -*-

;; (unpin! treemacs)
;; (unpin! lsp-treemacs)
;; (unpin! lsp-ui)
;; (unpin! lsp-mode)

(package! treemacs-all-the-icons)
(package! scss-mode)
(package! lsp-metals)

(package! po-mode
  :recipe (:host github :repo "erickisos/po-mode" :files ("*.el" "Makefile")))

(package! ox-moderncv
  :recipe (:host github :repo "erickisos/org-cv" :files ("*.el")))

(package! eca
  :recipe (:host github :repo "editor-code-assistant/eca-emacs" :files ("*.el")))

(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

(package! paredit)

(unpin! lsp-mode)
(unpin! lsp-ui)

(package! gradle-mode
  :recipe (:host github :repo "erickisos/emacs-gradle-mode" :files ("*.el" "Makefile")))

(package! obsidian)

(package! why-this
  :recipe (:host github :repo "erickisos/emacs-why-this" :files ("*.el" "Makefile")))

(package! pulsing-cursor
  :recipe (:host github :repo "jasonjckn/pulsing-cursor"))

(package! codesnap
  :recipe (:host github :repo "erickisos/codesnap.el" :files ("*.el")))

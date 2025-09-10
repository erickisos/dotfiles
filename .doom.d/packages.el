;;; $DOOMDIR/packages.el -*- lexical-binding: t; -*-

(unpin! treemacs)
(unpin! lsp-treemacs)
(unpin! lsp-ui)
(unpin! lsp-mode)

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

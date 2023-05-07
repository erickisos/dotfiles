;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! treemacs-all-the-icons)

(unpin! treemacs)
(unpin! lsp-ui)
(unpin! lsp-mode)
(unpin! lsp-treemacs)
(unpin! cython-mode)

(package! paredit)
(package! posframe)
(package! scss-mode)
;; (package! company-quickhelp)

(unpin! hover)
(unpin! lsp-dart)

(package! lsp-metals)
(package! map :pin "bb50dba")

;; (package! spice-mode)
;; (package! ob-spice)

(package! po-mode
  :recipe (:host github :repo "erickisos/po-mode" :files ("*.el" "Makefile")))

(package! copilot
   :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))

(package! docker-tramp)
(package! ox-moderncv
    :recipe (:host github :repo "erickisos/org-cv" :files ("*.el")))

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

(package! po-mode)
(package! copilot
   :recipe (:host github :repo "zerolfx/copilot.el" :files ("*.el" "dist")))

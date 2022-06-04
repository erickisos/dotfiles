;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! scss-mode)
(package! treemacs-all-the-icons)
(package! paredit)
(package! posframe)
(package! company-quickhelp)

(unpin! hover)
(unpin! treemacs)
(unpin! lsp-treemacs)
(unpin! lsp-mode)
(unpin! lsp-ui)
(unpin! lsp-dart)

(package! map :pin "bb50dba")
(package! po-mode)
(package! org-mind-map)

;; Scala config
(package! lsp-metals)

;; Spice
(package! spice-mode)
(package! ob-spice)

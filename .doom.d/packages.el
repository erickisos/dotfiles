;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! treemacs-all-the-icons)

(unpin! treemacs)
(unpin! lsp-ui)
(unpin! lsp-mode)
(unpin! lsp-treemacs)

(package! paredit)
(package! posframe)
(package! scss-mode)
(package! company-quickhelp)

(unpin! hover)
(unpin! lsp-dart)

(package! lsp-metals)
(package! map :pin "bb50dba")
(package! company-tabnine)

(package! spice-mode)
(package! ob-spice)

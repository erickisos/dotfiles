;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq  user-full-name                 "Erick G. Islas Osuna"
       user-mail-address              "erick@tliwaka.com.mx"
       doom-theme                     'doom-one
       org-directory                  "~/Documents/Cloud/Notes/"
       display-line-numbers-type      t
       projectile-project-search-path '("~/Documents/Github")
       evil-split-window-below        t
       evil-vsplit-window-right       t
       doom-font                      (font-spec :family "Fira Code" :size 12)
       doom-themes-treemacs-theme     "all-the-icons"
       ispell-dictionary              "es")

(use-package! treemacs-all-the-icons
  :after treemacs)

(use-package! cider
  :after clojure-mode
  :config
  (setq cider-show-error-buffer                 t   ;; to keep errors only at the REPL
        cider-font-lock-dynamically             nil
        cider-eldoc-display-for-symbol-at-point nil
        cider-prompt-for-symbol                 nil
        cider-use-xref                          nil)
  (set-lookup-handlers! '(cider-mode cider-repl-mode) nil)
  (add-hook 'cider-mode-hook (lambda () (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))

(use-package! clj-refactor
  :after clojure-mode
  :config
  (set-lookup-handlers! 'clj-refactor-mode nil)
  (setq cljr-warn-on-eval nil
        cljr-magic-require-namespaces '(("s" . "schema.core")
                                        ("st" . "schema.test")
                                        ("m" . "matcher-combinators.matchers")
                                        ("pp" . "clojure.pprint"))))

(use-package! clojure-mode
  :config
  (setq clojure-indent-style 'align-arguments))

(use-package! company
  :init
  (company-quickhelp-mode)
  :config
  (setq company-quickhelp-delay                nil
        company-quickhelp-use-propertized-text t
        company-quickhelp-max-lines            10))

(use-package! lsp-dart
  :after dart-mode
  :config
  (setq lsp-dart-dap-flutter-hot-reload-on-save t))

(use-package! org-mind-map
  :after ox-org
  :config
  (setq org-mind-map-engine "dot"))

(use-package! lsp-java
  :after java-mode
  :config
  (setq lsp-java-references-code-lens-enabled      t
        lsp-java-implementations-code-lens-enabled t))

(use-package! lsp-treemacs
  :config
  (setq lsp-treemacs-error-list-current-project-only t))

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable  nil
        lsp-ui-peek-enable nil))

(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(use-package! org-tree-slide
  :after org-mode
  :config
  (setq +org-present-text-scale              2
        org-tree-slide-skip-outline-level    2
        org-tree-slide-modeline-display      'outside
        org-tree-slide-fold-subtrees-skipped nil))

(load! "nubank")

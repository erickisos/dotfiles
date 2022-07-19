;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq user-full-name                 "Erick G. Islas Osuna"
      user-mail-address              "erickisos653@gmail.com"
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

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-headerline-breadcrumb-enable   t
        lsp-lens-enable                    t
        lsp-signature-render-documentation nil
        lsp-idle-delay                     0.1
        lsp-ui-sideline-enable             nil
        lsp-completion-use-last-result     nil)
  (advice-add #'lsp-rename
              :after (lambda (&rest _) (projectile-save-project-buffers))))

(use-package! lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable  nil
        lsp-ui-peek-enable nil))

(use-package! lsp-treemacs
  :config
  (setq lsp-treemacs-error-list-current-project-only t))

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

(use-package! lsp-java
  :after java-mode
  :config
  (setq lsp-java-references-code-lens-enabled      t
        lsp-java-implementations-code-lens-enabled t))

(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(use-package! org-tree-slide
  :after org-mode
  :config
  (setq +org-present-text-scale              2
        org-tree-slide-skip-outline-level    2
        org-tree-slide-slide-in-effect       t
        org-tree-slide-modeline-display      'outside
        org-tree-slide-fold-subtrees-skipped nil))

(use-package! company-tabnine
  :config
  (add-to-list 'company-backends #'company-tabnine)
  (setq company-idle-delay        0
        company-show-quick-access t))

(map! :leader
      (:prefix ("e" . "evaluate/ERC/EWW")
       :desc "Launch ERC with TLS connection" "E" #'erc-tls))

(setq erc-prompt                  (lambda () (concat "[" (buffer-name) "]"))
      erc-server                  "irc.libera.chat"
      erc-nick                    "erickisos"
      erc-user-full-name          "Erick Isos"
      erc-track-shorten-start     24
      erc-autojoin-channels-alist '(("irc.libera.chat"
                                     "#archlinux"
                                     "#linux"
                                     "#emacs"
                                     "#pyar"))
      erc-kill-buffer-on-part     t
      erc-fill-column             200
      erc-fill-function           'erc-fill-static
      erc-fill-static-center      16)

(load! "nubank")

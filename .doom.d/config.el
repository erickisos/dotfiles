;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(load! "functions")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq user-full-name                    "Erick G. Islas Osuna"
      user-mail-address                 "erick@tliwaka.com.mx"
      doom-theme                        'doom-molokai
      org-directory                     "~/Documents/Cloud/Notes/"
      display-line-numbers-type         t
      projectile-project-search-path    (add-project-directories "~/Documents/Github"
                                                                 "~/Github"
                                                                 "~/Documents/TradingMonkey"
                                                                 "~/Documents/Proyectos/Flutter"
                                                                 "~/Documents/Proyectos/Clojure"
                                                                 "~/Documents/Proyectos/CommonLisp"
                                                                 "~/Documents/Proyectos/Python"
                                                                 "~/Documents/Proyectos/React"
                                                                 "~/Documents/Proyectos/Go"
                                                                 "~/Documents/Proyectos/VHDL"
                                                                 "~/Documents/Proyectos/Machine Learning"
                                                                 "~/Documents/Proyectos/Serverless"
                                                                 "~/Documents"
                                                                 "~/OpenSource")

      evil-vsplit-window-right          t
      evil-split-window-below           t
      doom-font                         (font-spec :family "Fira Code" :size 12)
      display-line-numbers-type         'relative
      ispell-dictionary                 "es"
      ;; doom-themes-treemacs-theme "all-the-icons"
      )

(use-package! po-mode
  :config
  (map! :map po-mode-map
        :localleader
        :desc "Go to next entry" "n" #'po-next-entry
        :desc "Go to prev entry" "N" #'po-previous-entry
        :desc "Next fuzzy entry" "f" #'po-next-fuzzy-entry
        :desc "Prev fuzzy entry" "F" #'po-previous-fuzzy-entry
        :desc "Next untranslated entry" "u" #'po-next-untranslated-entry
        :desc "Prev untranslated entry" "U" #'po-previous-untranslated-entry
        :desc "Edit msgstr in separated buffer" "e" #'po-edit-msgstr))

(use-package! org-tree-slide
  :after org-mode
  :config
  (setq org-tree-slide-slide-in-effect       t
        +org-present-text-scale              2
        org-tree-slide-skip-outline-level    2
        org-tree-slide-fold-subtrees-skipped nil
        org-tree-slide-modeline-display      'outside)
  (map! :map org-tree-slide-mode-map
        :desc "Next slide" "M-n" #'org-tree-slide-move-next-tree
        :desc "Prev slide" "M-p" #'org-tree-slide-move-previous-tree))

(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-headerline-breadcrumb-enable t
        lsp-inlay-hints-mode             t
        lsp-lens-enable                  t)
  (advice-add #'lsp-rename
              :after (lambda (&rest _) (projectile-save-project-buffers))))

(after! lsp-mode
  :config
  (setq lsp-rust-analyzer-display-chaining-hints            t
        lsp-rust-analyzer-display-closure-return-type-hints t
        lsp-rust-analyzer-display-parameter-hints           t))

(use-package! gradle-mode
  :after java-mode)

(use-package! lsp-java
  :after java-mode
  :config
  (add-hook 'java-mode-hook (lambda () (gradle-mode 1)))
  (setq lsp-java-references-code-lens-enabled      t
        lsp-java-implementations-code-lens-enabled t
        lsp-java-lens-mode                         t
        lsp-java-format-settings-url               "~/IDEAJavaFormatter.xml"
        lsp-java-vmargs                            '("-XX:+UseParallelGC"
                                                     "-XX:GCTimeRatio=4"
                                                     "-XX:AdaptiveSizePolicyWeight=90"
                                                     "-Dsun.zip.disableMemoryMapping=true"
                                                     "-Xmx8G"
                                                     "-Xms100m"))
  (setq lombok-library-path (concat doom-data-dir "lombok.jar"))
  (unless (file-exists-p lombok-library-path)
    (url-copy-file "https://projectlombok.org/downloads/lombok.jar" lombok-library-path))
  (push (concat "-javaagent:"
                (expand-file-name lombok-library-path))
        lsp-java-vmargs))

(use-package! lsp-java-boot
  :after lsp-mode
  :preface
  (add-hook 'conf-javaprop-mode-local-vars-hook #'lsp!)
  (add-hook 'yaml-mode-local-vars-hook #'lsp!)
  :config
  (add-hook 'java-mode-local-vars-hook #'lsp-java-boot-lens-mode 'append)
  (add-hook 'yaml-mode-local-vars-hook #'lsp-java-boot-lens-mode 'append))

(use-package! clojure-mode
  :config
  (setq clojure-indent-style 'align-arguments))

(use-package! obsidian
  :config
  (global-obsidian-mode t)
  (obsidian-backlinks-mode t)
  :custom
  (obsidian-directory "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsNotes")
  (obsidian-daily-notes-directory "Daily"))

(use-package! why-this
  :config
  (setq why-this-annotate-enable-heat-map t
        why-this-idle-delay               0.5
        why-this-minimum-column           45)
  (global-why-this-mode))

(use-package! pulsing-cursor
  :config
  (pulsing-cursor-mode +1))

(use-package! magit
  :config
  ;; (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
  ;; (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
  )

(use-package! gptel
  :ensure t
  :defer t
  :config
  (setq gptel-backend (gptel-make-openai "Netflix Model Gateway"
                        :host "mgp.local.dev.netflix.net:9123"
                        :endpoint (gptel-make-netflix-mg-endpoint "eislasosunaws")
                        :protocol "http"
                        :models '(gpt-5
                                  gpt-4.1
                                  o4-mini
                                  gpt-4o
                                  gemini-2.5-pro
                                  gemini-2.5-flash
                                  bedrock/anthropic.claude-sonnet-4-20250514-v1:0
                                  bedrock/anthropic.claude-opus-4-1-20250805-v1:0))
        gptel-model   'bedrock/anthropic.claude-sonnet-4-20250514-v1:0)
  (add-hook 'gptel-post-stream-hook 'gptel-auto-scroll)
  (add-hook 'gptel-post-response-functions 'gptel-end-of-response)
  :custom
  (gptel-prompt-prefix-string "> ")
  (gptel-response-prefix-string "🤖 "))

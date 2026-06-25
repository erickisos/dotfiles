;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(load! "functions")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-frame-parameter nil 'ns-transparent-titlebar t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

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
  :after org
  :config
  (setq org-tree-slide-slide-in-effect       t
        +org-present-text-scale              2
        org-tree-slide-skip-outline-level    2
        org-tree-slide-fold-subtrees-skipped nil
        org-tree-slide-modeline-display      'lighter ;; Show timer in modeline
        )
  
  ;; Disable line numbers, why-this-mode, and close unnecessary windows when starting presentation
  (add-hook 'org-tree-slide-play-hook
            (lambda ()
              (message ">>> org-tree-slide PLAY hook fired! <<<")
              (setq display-line-numbers nil)
              ;; Keep UTF-8 entities displayed (override org-tree-slide's default)
              (setq org-pretty-entities t)
              ;; Disable why-this-mode
              (when (bound-and-true-p why-this-mode)
                (message ">>> Disabling why-this-mode <<<")
                (why-this-mode -1))
              
              ;; Close ECA and other windows, keeping only the org buffer
              (let ((org-buffer (current-buffer)))
                (delete-other-windows)
                (switch-to-buffer org-buffer))))
  
  ;; Re-enable line numbers and why-this-mode when stopping presentation
  (add-hook 'org-tree-slide-stop-hook
            (lambda ()
              (message ">>> org-tree-slide STOP hook fired! <<<")
              ;; Re-enable why-this-mode
              (message ">>> Enabling why-this-mode <<<")
              (why-this-mode 1)))
  
  (map! :map org-tree-slide-mode-map
        :desc "Next slide" "<right>" #'org-tree-slide-move-next-tree
        :desc "Prev slide" "<left>" #'org-tree-slide-move-previous-tree))

(use-package! eca)

(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

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
  :custom
  (obsidian-directory "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ObsNotes")
  (obsidian-daily-notes-directory "Daily"))

(use-package! why-this
  :config
  (setq why-this-annotate-enable-heat-map t
        why-this-idle-delay               0.5
        why-this-minimum-column           45)
  (global-why-this-mode))

(use-package! flyover
  :config
  (add-hook 'flycheck-mode-hook #'flyover-mode)
  (setq flyover-use-theme-colors  t
        flyover-display-mode      'show-only-on-same-line
        flyover-virtual-line-type nil))

(use-package! codesnap
  :config
  (map! :localleader
        :prefix "CodeSnap"
        :desc "Screenshot selected code" "s" #'codesnap-selection
        :desc "Show CodeSnap log" "l" #'codesnap-show-log))

(use-package! typst-ts-mode
  :custom
  (typst-ts-watch-options "--open"))

(after! forge
  (setq forge-alist
        (append forge-alist
                '(("github.netflix.net" "github.netflix.net/api/v3"
                   "github.netflix.net" forge-github-repository)))))

(after! magit
  (add-hook 'window-selection-change-functions
            (lambda (_frame)
              (when (derived-mode-p 'magit-mode)
                (magit-refresh)))))

(after! doom-modeline
  (doom-modeline-def-segment line-word-count
    "Word count of the current line."
    (when (doom-modeline--active)
      (propertize
       (format "%d words" (count-words (line-beginning-position) (line-end-position)))
       'face 'doom-modeline-buffer-minor-mode)))

  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug
      repl lsp minor-modes input-method indent-info line-word-count buffer-encoding major-mode
      process vcs check)))

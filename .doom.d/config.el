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
  (global-font-lock-mode 1)  ; Ensure syntax highlighting is enabled
  
  ;; Customization for enhanced msgstr editing UX
  ;; - po-subedit-use-split-window: Side-by-side view (msgid left, msgstr right)
  ;;   Set to nil for pop-up buffer behavior (default: t)
  ;; - po-subedit-center-msgid: Auto-center msgid in main window (default: t)
  (setq po-subedit-use-split-window t    ; Enable split-window for better UX with long messages
        po-subedit-center-msgid t)       ; Auto-center msgid for easy reference
  
  (map! :map po-mode-map
        :localleader
        :desc "Go to next entry" "n" #'po-next-entry
        :desc "Go to prev entry" "N" #'po-previous-entry
        :desc "Next fuzzy entry" "f" #'po-next-fuzzy-entry
        :desc "Prev fuzzy entry" "F" #'po-previous-fuzzy-entry
        :desc "Next untranslated entry" "u" #'po-next-untranslated-entry
        :desc "Prev untranslated entry" "U" #'po-previous-untranslated-entry
        :desc "Edit msgstr in separated buffer" "e" #'po-edit-msgstr))

(use-package! ox-moderncv)

(use-package! ox-typst
  :after org)

(use-package! org-tree-slide
  :after org
  :config
  (setq org-tree-slide-slide-in-effect       t
        +org-present-text-scale              2
        org-tree-slide-skip-outline-level    2
        org-tree-slide-fold-subtrees-skipped nil
        org-tree-slide-modeline-display      'lighter 
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

;; (use-package! websocket
;;     :after org-roam)

;; (use-package! org-roam-ui
;;   :after org-roam
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-update-on-save t
;;         org-roam-ui-open-on-start t))

(use-package! eca
  :config
  ;; Point at a locally built eca (e.g. from `bb prod-cli` in
  ;; ~/Documents/Github/eca) instead of the downloaded release binary, to
  ;; test unreleased changes. Comment out to go back to the managed binary.
  (setq eca-custom-command '("/Users/erickisos/Documents/Github/eca/eca" "server")))

(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-headerline-breadcrumb-enable t
        lsp-inlay-hint-enable            t
        lsp-lens-enable                  t
        lsp-idle-delay                   0.05
        ;; Don't keep the JDT workspace alive after all its buffers are closed.
        ;; Prevents every project you've ever opened from being re-imported on startup.
        lsp-keep-workspace-alive         nil
        ;; Emit a warning when the file watcher exceeds this many files — useful
        ;; for diagnosing runaway scans into build artifact directories.
        lsp-file-watch-threshold         2000)
  (advice-add #'lsp-rename
              :after (lambda (&rest _) (projectile-save-project-buffers)))
  ;; Exclude Gradle/Java build artifact directories from the file watcher.
  ;; Without this, lsp-mode watches build/, .gradle/, out/ etc. and triggers
  ;; on every recompile, causing unnecessary re-indexing.
  (dolist (dir '("[/\\\\]build\\'"
                 "[/\\\\]\\.gradle\\'"
                 "[/\\\\]out\\'"
                 "[/\\\\]\\.idea\\'"
                 "[/\\\\]bin\\'"))
    (add-to-list 'lsp-file-watch-ignored-directories dir)))

(after! lsp-mode
  :config
  (setq lsp-rust-analyzer-display-chaining-hints            t
        lsp-rust-analyzer-display-closure-return-type-hints t
        lsp-rust-analyzer-display-parameter-hints           t))

(use-package! gradle-mode
  :after java-mode)

(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "settings.gradle")
  (add-to-list 'projectile-project-root-files-bottom-up "settings.gradle.kts")
  ;; build.gradle exists in every Gradle submodule, so it's a false root signal.
  ;; Remove it so submodules like app/ don't get detected as independent projects.
  (setq projectile-project-root-files-bottom-up
        (remove "build.gradle" projectile-project-root-files-bottom-up)))

(use-package! lsp-java
  :after java-mode
  :config
  (add-hook 'java-mode-hook (lambda () (gradle-mode 1)))
  (setq lsp-java-references-code-lens-enabled                 t
        lsp-java-implementations-code-lens-enabled            t
        lsp-java-lens-mode                                    t
        lsp-java-format-settings-url                          "~/IDEAJavaFormatter.xml"
        ;; Import ordering: third-party | java.* | javax.* | static
        ;; Each group gets a blank line separator automatically.
        ;; "" = all imports not matched by a later prefix.
        lsp-java-completion-import-order                      ["" "java" "javax" "\\#"]
        ;; Gradle import — critical for classpath resolution in Gradle projects
        lsp-java-import-gradle-enabled                        t
        lsp-java-import-gradle-wrapper-enabled                t  ; use project's gradlew
        lsp-java-import-maven-enabled                         nil
        lsp-java-configuration-update-build-configuration     'automatic
        ;; Tell JDT's import scanner to skip build artifacts. The defaults only
        ;; exclude node_modules and a few Maven dirs; Gradle projects also generate
        ;; large build/ and .gradle/ trees that JDT would otherwise index.
        lsp-java-import-exclusions                            ["**/node_modules/**"
                                                               "**/.metadata/**"
                                                               "**/archetype-resources/**"
                                                               "**/META-INF/maven/**"
                                                               "**/build/**"
                                                               "**/.gradle/**"
                                                               "**/out/**"
                                                               "**/bin/**"
                                                               "**/.idea/**"]
        lsp-java-vmargs                                       '("-XX:+UseParallelGC"
                                                               "-XX:GCTimeRatio=4"
                                                               "-XX:AdaptiveSizePolicyWeight=90"
                                                               "-Dsun.zip.disableMemoryMapping=true"
                                                               "-Xmx8G"
                                                               "-Xms100m"))
  (setq lombok-library-path
        (let ((primary (expand-file-name "lombok.jar" doom-data-dir))
              (fallback (expand-file-name "~/.config/emacs.old.d/.local/etc/lombok.jar")))
          (cond ((file-exists-p primary)  primary)
                ((file-exists-p fallback) (copy-file fallback primary) primary)
                (t (url-copy-file "https://projectlombok.org/downloads/lombok.jar" primary) primary))))
  (when (file-exists-p lombok-library-path)
    (push (concat "-javaagent:" lombok-library-path) lsp-java-vmargs)))

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
  :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flyover-mode)
  (add-hook 'flymake-mode-hook #'flyover-mode)
  (setq flyover-use-theme-colors  t
        flyover-display-mode      'show-only-on-same-line
        flyover-checkers '(flycheck flymake)
        flyover-levels '(error warning info)
        flyover-text-tint 'lighter
        flyover-text-tint-percent 50
        flyover-debounce-interval 0.2
        flyover-cursor-debounce-interval 0.3
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

(after! gnus
  (set-face-attributes 'gnus-group-news-low-empty nil :inherit 'default))

(defun +magit-refresh-on-focus-h (&optional frame)
    "Refresh the selected Magit buffer on window, buffer or frame focus changes."
    (when (or frame (eq t (frame-focus-state)))
      (with-selected-window (frame-selected-window frame)
        (when (derived-mode-p 'magit-mode)
          (magit-refresh)))))

(use-package! magit
  :defer t
  :config
  (add-hook 'window-selection-change-functions #'+magit-refresh-on-focus-h)
  (add-hook 'window-buffer-change-functions #'+magit-refresh-on-focus-h)
  (add-function :after after-focus-change-function #'+magit-refresh-on-focus-h))

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

(use-package! uv-mode
  :hook (python-mode . uv-mode-auto-activate-hook))

;; (use-package! platformio-mode)

;; Basic package setup
(require 'package)

;; Set up emacs package archives with 'package
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Ensure use-package is present. Also, refresh the package archive on load so we can pull the latest packages.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq
 use-package-always-ensure t ;; Makes sure to download new packages if they aren't already downloaded
 use-package-verbose t) ;; Package install logging. Packages break, it's nice to know why.

;; no-littering to keep dirs clean
(use-package no-littering)

;; evil mode
(use-package evil
  :init
  (setq evil-want-Y-yank-to-eol t)
  :config
  (evil-mode 1))

(use-package undo-tree
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode))

;; doom-themes
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

;; Set user-emacs-directory to no-littering's paths
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Keybinds help
;; Ormai e' incluso direttamente dentro a emacs
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Company (completion backend)
;; Todo: smart tab
(use-package company
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0)
  (evil-global-set-key 'insert (kbd "C-SPC") #'company-complete) ;; Manually bring up completion by pressing C-SPC
  )

;; Vertico (vertical completion UI per M-x etc)
(use-package vertico
  :init
  (vertico-mode))

;; Marginalia (annotations info for completion suggestions)
(use-package marginalia
  :init
  (marginalia-mode))

;; Orderless (fuzzy matching for completion suggestions)
(use-package orderless
  :custom
  (completion-styles '(orderless basic)) ;; basic is a fallback in addition to orderless
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))) ;; partial completion important for file wildcard support

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;

;; Lsp
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         ;(XXX-mode . lsp) ;; lsp-deferred defers lsp startup until the buffer is visible, as opposed to lsp
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp) ;; lsp-deferred defers lsp startup until the buffer is visible, as opposed to lsp

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; GO
(use-package go-mode
  :hook ((go-mode . lsp)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Packages da installare:
;; hl-todo (highlight todo)
;; ligatures
;; nav-flash (blink cursor line after big motions)
;; neotree?
;; ophints (highlight the region an operation acts in)
;; fold (code folding)
;; snippets
;; magit?
;; tree-sitter? lsp?
;; roba org
;; lsp vari




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; relative-line-numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Avoid scrolling half page when reaching margin of screen
(setq scroll-margin 10
      scroll-conservatively 101
      scroll-preserve-screen-position t)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

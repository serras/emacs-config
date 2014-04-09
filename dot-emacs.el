;; Packages
; Add the package repository
(require 'package)
; Use also the packages folder for automatic loading
(add-to-list 'package-directory-list
       (concat (file-name-directory (or load-file-name
                                    (buffer-file-name)))
               "packages"))
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
; Set load path
(require 'cl)
; Add packages to load-path
; Some are in packages/* ...
(defvar packages
  '(popup auto-complete undo-tree
    color-theme-solarized
    rainbow-delimiters ecb
    haskell-mode-1
    hi2 ghci-completion
    idris-mode
    magit magit-modes
    find-file-in-project highlight-indentation
    idomenu nose pyvenv yasnippet elpy
    scala-mode-2 sbt-mode ensime))
(loop for name in packages
  do (add-to-list 'load-path
       (concat (file-name-directory (or load-file-name
                                        (buffer-file-name)))
               "packages/"
               (symbol-name name))))
; ... and others in packages/*/elisp
(defvar packages-elisp
  '(ghc structured-haskell-mode))
(loop for name in packages-elisp
  do (add-to-list 'load-path
       (concat (file-name-directory (or load-file-name
                                        (buffer-file-name)))
               "packages/"
               (symbol-name name)
	       "/elisp")))
(add-to-list 'custom-theme-load-path 
   (concat (file-name-directory (or load-file-name
                                        (buffer-file-name)))
               "packages/color-theme-solarized"))

;; Editor-related packages
; Color theme
(load-theme 'solarized-light t)
; Color matching brackets
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
; Parenthesis, lines, returns, undos
(show-paren-mode 1)
(require 'linum)
(global-linum-mode 1)
(cua-mode 1) ;; Windows shortcuts
(tool-bar-mode -1) ;; Hide toolbar
(define-key global-map (kbd "RET") 'newline-and-indent) ;; Indent on return
; Better undo support
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)
; General autocompletion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs-config/packages/auto-complete/dict")
(ac-config-default)

;; File list
(require 'ecb)
(setq ecb-auto-activate t)
(setq ecb-layout-name "left13")
(setq ecb-new-ecb-frame nil)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 13)

;; Git
(require 'magit)

;; LaTeX
; Needs AucTeX from system
(load "auctex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; Haskell
; Add Cabal to environment path
(setenv "PATH" (concat "~/.cabal/bin:" (getenv "PATH")))
(add-to-list 'exec-path "~/.cabal/bin")
; install ghc-mod, hlint, stylish-haskell from cabal
;(require 'haskell-mode)
(load "haskell-mode-autoloads")
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc)
; hi2 - Haskell indentation
(require 'hi2)
(add-hook 'haskell-mode-hook 'turn-on-hi2)
(setq hi2-show-indentations nil)
; These are other possible indentations
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
; Structured Haskell Mode (now disabled)
;(require 'shm)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
; Extra packages
(require 'ghc)
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
(require 'ghci-completion)
(add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion)

;; Agda
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;; Idris
(require 'idris-mode)

;; Coq
(load-file "~/emacs-config/packages/ProofGeneral-4.2/generic/proof-site.el")

;; Scala
(require 'scala-mode2)
(require 'sbt-mode)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; Python
(require 'find-file-in-project)
(require 'highlight-indentation)
(require 'idomenu)
(require 'nose)
(require 'pyvenv)
(require 'yasnippet)
(require 'elpy)
(elpy-enable)
; Requires ipython
(elpy-use-ipython)

;; Ruby



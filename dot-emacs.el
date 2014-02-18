; Add the package repository
(require 'package)
; Use also the packages folder for automatic loading
(add-to-list 'package-directory-list
       (concat (file-name-directory (or load-file-name
                                    (buffer-file-name)))
               "emacs-config/packages"))
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

; Set load path
(require 'cl)
; Add packages to load-path
(defvar packages
  '(popup auto-complete undo-tree
    color-theme-solarized
    rainbow-delimiters ecb
    hi2 ghci-completion
    magit magit-modes
    scala-mode-2 sbt-mode ensime))
(loop for name in packages
  do (add-to-list 'load-path
       (concat (file-name-directory (or load-file-name
                                        (buffer-file-name)))
               "emacs-config/packages/"
               (symbol-name name))))
(defvar packages-elisp
  '(ghc structured-haskell-mode))
(loop for name in packages-elisp
  do (add-to-list 'load-path
       (concat (file-name-directory (or load-file-name
                                        (buffer-file-name)))
               "emacs-config/packages/"
               (symbol-name name)
	       "/elisp")))
(add-to-list 'custom-theme-load-path 
   (concat (file-name-directory (or load-file-name
                                        (buffer-file-name)))
               "emacs-config/packages/color-theme-solarized"))
; Add Cabal to environment path
(setenv "PATH" (concat "~/.cabal/bin:" (getenv "PATH")))
(add-to-list 'exec-path "~/.cabal/bin")

; Colors
(load-theme 'solarized-light t)
;; install rainbow-delimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
; Parenthesis, lines, returns, undos
(show-paren-mode 1)
(require 'linum)
(global-linum-mode 1)
(cua-mode 1) ;; Windows shortcuts
(tool-bar-mode -1) ;; Hide toolbar
(define-key global-map (kbd "RET") 'newline-and-indent) ;; Indent on return
;; install undo-tree
(require 'undo-tree)
(global-undo-tree-mode 1)
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)

; File list
(require 'ecb)
(setq ecb-auto-activate t)
(setq ecb-layout-name "left13")
(setq ecb-new-ecb-frame nil)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 13)

; Tools
;; install magit
(require 'magit)
;; install auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs-config/packages/auto-complete/dict")
(ac-config-default)

; Haskell
;; install ghc-mod, hlint, stylish-haskell from cabal
;; install haskell-mode
;; - Run 'make all' in packages/haskell-mode-1
;; - Copy 'haskell-mode-pkg.el.in' to 'haskell-mode-pkg.el' changing the version
(require 'haskell-mode)
;(load "haskell-mode-autoloads")
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc)
; hi2 - Haskell indentation
(require 'hi2)
(add-hook 'haskell-mode-hook 'turn-on-hi2)
(setq hi2-show-indentations nil)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; install structured-haskell-mode
;(require 'shm)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
;; install ghc
(require 'ghc)
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
;; install ghci-completion
(require 'ghci-completion)
(add-hook 'inferior-haskell-mode-hook 'turn-on-ghci-completion)

; Agda
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

; Scala
(require 'scala-mode2)
(require 'sbt-mode)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

; Coq
(load-file "~/emacs-config/packages/ProofGeneral-4.2/generic/proof-site.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/home/alejandro/Top/trunk" "Top") ("/home/alejandro/code/sci.f100183.domsted/solver" "solver") ("/home/alejandro/code/sci.f100183.domsted/solver2" "solver2") ("/home/alejandro/code/sci.f100183.domsted/unif-examples" "unif-examples") ("/home/alejandro/teaching/TPT" "TPT") ("/home/alejandro/papers/haskell-2014" "haskell-2014")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shm-current-face ((t (:background "#EBEBEB"))))
 '(shm-quarantine-face ((t (:background "#ECEAEA")))))


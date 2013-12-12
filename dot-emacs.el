(require 'cl)
; Add packages to load-path
(defvar packages
  '(popup auto-complete undo-tree
    color-theme-solarized
    rainbow-delimiters ecb
    haskell-mode ghci-completion
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

; Add the package repository
(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

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
;(require 'haskell-mode)
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list "~/emacs-config/packages/haskell-mode/")
(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;; install structured-haskell-mode
(require 'shm)
(add-hook 'haskell-mode-hook 'structured-haskell-mode)
(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "RET") 'shm/newline-indent))
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path '()))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shm-current-face ((t (:background "#EBEBEB"))))
 '(shm-quarantine-face ((t (:background "#ECEAEA")))))


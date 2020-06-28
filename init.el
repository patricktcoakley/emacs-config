;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
	(company-irony-c-headers flycheck-clang-analyzer irony-eldoc company-irony clang-format cmake-ide helm-flx irony markdown-mode flycheck geiser autopair slime neotree imenu-list auto-complete helm base16-theme cider))))

;; Scratch buffer mode
(setq initial-major-mode 'c++-mode)

;; Option for meta on Mac
(setq mac-option-modifier 'meta)

;; Set theme
(load-theme 'base16-cupertino t)

;; Set font size
(set-face-attribute 'default nil :height 190)

;; Set custom keys
(global-set-key (kbd "M-x") 'helm-M-x)

;; Enable line numbers in every buffer
(global-linum-mode t)

;; Enable column numbers in every buffer
(column-number-mode t)

;; Enable autopair in every buffer
(autopair-global-mode t)

;; Set SLIME settings
(setq slime-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl"))))
(setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-tramp slime-asdf))
(slime-require :swank-listener-hooks)

;; Set geiser settings
(setq geiser-racket-binary "/usr/local/bin/racket")
(setq geiser-chez-binary "/usr/local/bin/scheme")

;; Add exec path
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; 120 column width
(setq-default fill-column 120)

;; Maximize window
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Remove comments from scratch buffer
(setq initial-scratch-message nil)

;; Set auto-save files to temp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Irony mode hooks
(require 'irony)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Tab key
(setq-default tab-always-indent 'complete)

;; CC mode
(setq-default c-default-style "k&r"
			  tab-width 4
			  indent-tabs-mode t)

;; Company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-irony-c-headers)
(require 'company-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;; Flycheck
(require 'flycheck)
(with-eval-after-load 'flycheck
  (require 'flycheck-clang-analyzer)
  (flycheck-clang-analyzer-setup))
(add-hook 'c++-mode-hook
		  (lambda () (setq flycheck-clang-language-standard "c++11")))


(add-hook 'after-init-hook #'global-flycheck-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
 '(custom-safe-themes '(default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(lsp-mode rustic company-glsl company-irony-c-headers flycheck-clang-analyzer irony-eldoc company-irony clang-format cmake-ide helm-flx irony markdown-mode flycheck geiser slime neotree imenu-list auto-complete helm base16-theme cider)))

;; Scratch buffer mode
(setq initial-major-mode 'c-mode)

;; Option for meta on Mac
(setq mac-option-modifier 'meta)

;; Electric pair mode
(add-hook 'c-mode-common-hook 'electric-pair-mode)

;; Set theme
(load-theme 'base16-eighties t)

;; Set font size
(set-face-attribute 'default nil :height 190)

;; Set custom keys
(global-set-key (kbd "M-x") 'helm-M-x)

;; Enable line numbers in every buffer
(global-linum-mode t)

;; Enable column numbers in every buffer
(column-number-mode t)

;; Set LISP settings
(if (eq system-type 'darwin)
	(progn
	  (setq inferior-lisp-program "/usr/local/bin/sbcl")
	  (setq geiser-racket-binary "/usr/local/bin/racket")
	  (setq geiser-chez-binary "/usr/local/bin/chez")))

(if (eq system-type 'gnu/linux)
	(progn
	  (setq inferior-lisp-program "/usr/bin/sbcl")
	  (setq geiser-racket-binary "/usr/bin/racket")
	  (setq geiser-chez-binary "/usr/bin/chez")))

(setq slime-contribs '(slime-fancy))
(slime-setup '(slime-fancy slime-tramp slime-asdf))
(slime-require :swank-listener-hooks)

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
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

;; Flycheck
(require 'flycheck)
(with-eval-after-load 'flycheck
  (require 'flycheck-clang-analyzer)
  (flycheck-clang-analyzer-setup))
(add-hook 'c++-mode-hook
		  (lambda () (setq flycheck-clang-language-standard "c++20")))
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Colors
(set-cursor-color "lightgreen")
(set-background-color "#072626")
(set-face-foreground 'font-lock-builtin-face "lightgreen")
(global-font-lock-mode 1)

;; Theme
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#d3b58d" :background "#041818"))))
 '(custom-group-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(custom-variable-tag-face ((t (:underline t :foreground "lightblue"))) t)
 '(font-lock-builtin-face ((t nil)))
 '(font-lock-comment-delimiter-face ((t (:foreground "#31b72c"))))
 '(font-lock-comment-face ((t (:foreground "#3fdflf"))))
 '(font-lock-function-name-face ((((class color) (background dark)) (:foreground "white"))))
 '(font-lock-keyword-face ((t (:foreground "white"))))
 '(font-lock-preprocessor-face ((t (:foreground "#31b72c"))))
 '(font-lock-string-face ((t (:foreground "#0fdfaf"))))
 '(font-lock-type-face ((t (:foreground "lightgreen"))))
 '(font-lock-variable-name-face ((((class color) (background dark)) (:foreground "#c8d4ec"))))
 '(font-lock-warning-face ((t (:foreground "#504038"))))
 '(highlight ((t (:foreground "navyblue" :background "darkseagreen2"))))
 '(mode-line ((t (:inverse-video t))))
 '(region ((t (:background "blue"))))
 '(rustic-compilation-column ((t (:inherit compilation-column-number))))
 '(rustic-compilation-error ((t (:foreground "red"))))
 '(rustic-compilation-line ((t (:foreground "LimeGreen"))))
 '(widget-field-face ((t (:foreground "white"))) t)
 '(widget-single-line-field-face ((t (:background "darkgray"))) t))

;; Don't show the startup message
(setq inhibit-startup-message t)

;; Hide some gui stuff
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Line numbers
(line-number-mode t)

;;Set all yes or no questions to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; Automacitally update buffers from disk
(global-auto-revert-mode t)

(add-hook 'text-mode-hook #'visual-line-mode)

;; Change where custom code is placed. 
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

;; Chage where abbrevs are stored
(setq abbrev-file-name
      "~/.emacs.d/abbrev_defs")

(setq org-refile-targets '((nil . (:maxlevel . 4))))
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps t)
(setq org-hierarchical-todo-statistics nil)


;; Set up melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package magit
  :ensure t
  :bind
  ("C-x g" . 'magit-status))

(use-package rust-mode
  :ensure t
  :config
  (add-hook 'rust-mode-hook (lambda ()
			      (local-set-key (kbd "C-c <tab>") #'rust-format-buffer))))

(use-package cargo
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package racer
  :ensure t
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'rust-mode-hook #'eldoc-mode)
  (setq racer-rust-source-path "/home/wsl/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))

;;(use-package company
;;  :ensure t
;;  :config
;;  (add-hook 'racer-mode-hook #'company-mode)
;;  (require 'rust-mode)
;;  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
;;  (setq company-tooltip-align-annotations t))


(use-package toml-mode
  :ensure t)

(use-package base16-theme
  :disabled
  :ensure t
  :config
  (load-theme 'base16-embers t))

(use-package zenburn-theme
  :ensure t)

(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))

(use-package markdown-mode
  :ensure t
  :config
  (setq markdown-command "cmark"))

(use-package fountain-mode
  :ensure t
  :disabled)

(use-package web-mode
  :ensure t)

(use-package org-cliplink
  :ensure t
  :bind (("C-c y" . org-cliplink)))

(require 'browse-url)

;; browser     ==== currently not working
(defun browse-url-wsl-windows-chrome (url &optional _new-window)
  "Open a link in the chrome on the windows side of wsl. Currently the proccess is started, but some part of the enviroment causes the window not to"
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (start-process-shell-command
   (concat "google-chrome " url)
   nil
   (concat "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe " url)))
(setq browse-url-browser-function 'browse-url-wsl-windows-chrome)

(put 'narrow-to-region 'disabled nil)

;; Open life.org at startup.
(switch-to-buffer (find-file "~/life.org"))

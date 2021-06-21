(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   '("78e9a3e1c519656654044aeb25acb8bec02579508c145b6db158d2cfad87c44e" default))
 '(default-input-method "korean-hangul3f")
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(go-projectile edit-server jupyter solarized-theme ivy geiser scala-mode ron-mode flycheck-rust cargo rust-mode company-anaconda anaconda-mode slime evil-numbers evil-visualstar evil-surround evil helm-ag helm-descbinds helm-projectile helm selectrum-prescient selectrum smex ido-completing-read+ flx-ido yaml-mode web-mode lsp-ui zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens rainbow-mode rainbow-delimiters projectile operate-on-number nlinum move-text magit lsp-mode json-mode js2-mode imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region exec-path-from-shell elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux counsel company browse-kill-ring anzu ag ace-window))
 '(safe-local-variable-values '((encoding . utf-8)))
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(add-to-list 'auto-mode-alist
             '("\\.psql$" . (lambda ()
                              (sql-mode)
                              (sql-highlight-postgres-keywords))))

(add-hook 'sql-mode-hook 'sqlind-minor-mode)

(add-to-list 'auto-mode-alist
             '("\\.hql$" . (lambda ()
                             (sql-mode))))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (jupyter . t)))

;; (setq org-babel-default-header-args:jupyter-julia '((:async . "yes")
;;                                                     (:session . "jl")
;;                                                     (:kernel . "julia-1.0")))
;;
;; (setq ob-async-no-async-languages-alist '("jupyter-python" "jupyter-julia"))
;;
;; (require 'lsp-python-ms)
;; (setq lsp-python-ms-auto-install-server t)
;; (add-hook 'python-mode-hook #'lsp) ; or lsp-deferred

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)

(when (and (require 'edit-server nil t) (daemonp))
  (edit-server-start))

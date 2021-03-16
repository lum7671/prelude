(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(default-input-method "korean-hangul3f")
 '(doom-modeline-icon t)
 '(doom-modeline-mode t)
 '(gnutls-algorithm-priority "normal:-vers-tls1.3")
 '(package-selected-packages
   '(dockerfile-mode elpy edit-server yasnippet use-package eglot pylint python-docstring doom-themes highlight iedit eldoc merlin doom-themes python-docstring plantuml-mode ggtags cask-mode smex ghub ido-completing-read+ all-the-icons evil-surround helm-ag markdown-mode popup scala-mode doom-modeline py-autopep8 dash dash-functional helm-core lsp-mode transient with-editor pylint pipenv csv-mode julia-mode helm-projectile helm geiser company-anaconda anaconda-mode lsp-ui company-lsp json-mode js2-mode rainbow-mode elisp-slime-nav rainbow-delimiters company counsel swiper ivy exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens operate-on-number move-text magit projectile imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major crux browse-kill-ring beacon anzu ace-window))
 '(safe-local-variable-values '((encoding . utf-8)))
 '(size-indication-mode t)
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(add-hook 'python-mode-hook #'pipenv-mode)
(add-hook 'python-mode-hook #'pyvenv-mode)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

(use-package eglot
             :config
             (add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1))))

(use-package pipenv
             :hook (python-mode . pipenv-mode)
             :init
             (setq
              pipenv-projectile-after-switch-function
              #'pipenv-projectile-after-switch-extended))

(setq py-autopep8-options '("--max-line-length=77"))

(use-package pylint)
(use-package python-docstring
             :config
             (python-docstring-install))
(use-package python
             :bind (:map python-mode-map
                         ("C-c C-p" .  flycheck-previous-error)
                         ("C-c C-n" . flycheck-next-error))
             :hook
             (python-mode . (lambda ()
                              (eglot-ensure)
                              (pipenv-mode)
                              (company-mode))))

;; https://zeph1e.tistory.com/87

(eval-after-load 'auto-complete
  '(ac-ispell-setup))
(add-hook 'text-mode 'ac-ispell-ac-setup)

(define-minor-mode my:flyspell-mode
  "Enable flyspell-mode."
  :variable my:flyspell-mode
  (if my:flyspell-mode
      (progn
        (if (derived-mode-p 'prog-mode) (flyspell-prog-mode)
          (flyspell-mode))
        (if (called-interactively-p) (flyspell-buffer)))
    (flyspell-mode -1)))

(eval-after-load 'auto-complete
  '(ac-flyspell-workaround))

(eval-after-load 'flyspell
  '(progn
     (define-key flyspell-mode-map (kbd "M-$") #'flyspell-popup-correct)
     (add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; [Emacs에서 한글 맞춤법 검사기 사용하기 업데이트](https://hj-lee.github.io/2013/04/30/hunspell-ko/)
;;

(setq-default ispell-program-name "enchant")

;; 사전 목록에 한국어("korean") 추가
(if (>= emacs-major-version 23)
    (setq ispell-local-dictionary-alist
          '(("korean"
             "[가-힣]"
             "[^가-힣]"
             "[0-9a-zA-Z]" nil
             ("-d" "ko_KR")
             nil utf-8)))
  (setq  ispell-local-dictionary-alist
         '(("korean"
            "[가-힝]"
            "[^가-힝]"
            "[0-9a-zA-Z)]" nil
            ("-d" "ko_KR")
            nil utf-8))))

;; 한국어를 기본 사전으로 지정
(setq ispell-dictionary "korean")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'default-frame-alist '(font . "NanumGothicCoding-14"))
(set-face-attribute 'default t :font "NanumGothicCoding-14")

(set-face-attribute 'default nil :font "NanumGothicCoding-14")
(set-frame-font "NanumGothicCoding-14" nil t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'edit-server)
(edit-server-start)



(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dark+ t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist
             '("\\.psql$" . (lambda ()
                              (sql-mode)
                              (sql-highlight-postgres-keywords))))

(add-hook 'sql-mode-hook 'sqlind-minor-mode)

(add-to-list 'auto-mode-alist
             '("\\.hql$" . (lambda ()
                              (sql-mode))))

(defvar prelude-personal-myels-dir (expand-file-name  "myels" prelude-personal-dir)
  "This directory is personal el files.")
(add-to-list 'load-path prelude-personal-myels-dir)

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)


(require 'yasnippet)
(yas-global-mode 1)
(yas-load-directory "~/.emacs.d/snippets")


(setq org-plantuml-jar-path (expand-file-name "/usr/local/Cellar/plantuml/1.2020.15/libexec/plantuml.jar"))
; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(add-to-list 'auto-mode-alist
             '("\\.puml$" . (lambda ()
                              (plantuml-mode))))

; for merlin
(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(defalias 'workon 'pyvenv-workon)

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
;; note that setting `venv-location` is not necessary if you
;; use the default location (`~/.virtualenvs`), or if the
;; the environment variable `WORKON_HOME` points to the right place
;(setq venv-location "/path/to/your/virtualenvs/")

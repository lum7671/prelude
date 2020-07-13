;; * [GitHub - Atman50/emacs-config: A literate emacs configuration for C#, python, ivy, yasnippet, ...](https://github.com/Atman50/emacs-config#org5309cf1)

(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

(setq auto-window-vscroll nil)

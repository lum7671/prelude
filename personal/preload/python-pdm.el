  ;; TODO: Cache result
  (defun linw1995/pdm-get-python-executable (&optional dir)
    (let ((pdm-get-python-cmd "pdm info --python"))
      (string-trim
       (shell-command-to-string
        (if dir
            (concat "cd "
                    dir
                    " && "
                    pdm-get-python-cmd)
          pdm-get-python-cmd)))))

  (defun linw1995/pdm-get-packages-path (&optional dir)
    (let ((pdm-get-packages-cmd "pdm info --packages"))
      (concat (string-trim
               (shell-command-to-string
                (if dir
                    (concat "cd "
                            dir
                            " && "
                            pdm-get-packages-cmd)
                  pdm-get-packages-cmd)))
              "/lib")))

  (use-package lsp-python-ms
    :ensure t
    :init (setq lsp-python-ms-auto-install-server t)
    :hook (python-mode
           . (lambda ()
               (setq lsp-python-ms-python-executable (linw1995/pdm-get-python-executable))
               (setq lsp-python-ms-extra-paths (vector (linw1995/pdm-get-packages-path)))
               (require 'lsp-python-ms)
               (lsp))))  ; or lsp-deferred

;;; private/mitkuijp/config.el -*- lexical-binding: t; -*-

(def-package! zoom-frm
  :config
  ;; Adds a custom zoom-frm function with hydra
  (def-hydra! doom@zoom-frm (:hint t :color red)
    "
      Zoom: _j_:zoom in, _k_:zoom out, _0_:reset
    "
    ("j" zoom-frm-in "in")
    ("k" zoom-frm-out "out")
    ("0" zoom-frm-unzoom "reset")))

(def-package! lispyville
  ;:hook clojure-mode
  :config
  (after! cider
    ;; Apparently this can cause really weird issues and I don't really care i always want to have highlighted code
    (setq cider-font-lock-reader-conditionals nil))
  (lispyville-set-key-theme
   '(operators
     slurp/barf-cp
     additional
     additional-insert
     additional-movement
     additional-wrap))
  (define-key lispy-mode-map-lispy "[" nil)
  (define-key lispy-mode-map-lispy "]" nil)
  (add-hook 'clojure-mode-hook #'lispyville-mode))

(def-package! flycheck-joker
  :after clojure-mode
  :config
  (add-hook 'clojure-mode-hook #'flycheck-mode))

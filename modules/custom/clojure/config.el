;;; custom/clojure/config.el -*- lexical-binding: t; -*-

(defvar clj-modes '(clojure-mode
                    clojurec-mode
                    clojurescript-mode
                    cider-clojure-interaction-mode))

(add-hook! 'lsp-mode-hook
  (defun clj-clojure-set-completion-at-point-h ()
    (when (member major-mode clj-modes)
      (clojure-set-completion-at-point-h))))

;; This gives cider access to java sources this is experimental
(setq cider-enrich-classpath t)

(after! clojure-mode
  ;; Without this option evaluations in comment blocks are always ran in the current ns in the repl, which we never want
  (setq clojure-toplevel-inside-comment-form t)
  (set-formatter! 'zprint '("zprint") :modes '(clojure-mode clojurec-mode clojurescript-mode)))

(use-package! evil-cleverparens
  :config (require 'evil-cleverparens-text-objects)
  :hook ((lisp-mode . evil-cleverparens-mode)
         (emacs-lisp-mode . evil-cleverparens-mode)
         (ielm-mode . evil-cleverparens-mode)
         (scheme-mode . evil-cleverparens-mode)
         (racket-mode . evil-cleverparens-mode)
         (hy-mode . evil-cleverparens-mode)
         (lfe-mode . evil-cleverparens-mode)
         (dune-mode . evil-cleverparens-mode)
         (clojure-mode . evil-cleverparens-mode)
         (fennel-mode . evil-cleverparens-mode)))

;; Hack  to fix that you delete the opening [|] with smartparens
(evil-define-operator evil-cp-delete-char-or-splice-backwards-or-join
  (_count)
  (interactive "p")
  (if (bolp)
      (call-interactively #'evil-delete-backward-char-and-join)
    (call-interactively #'evil-cp-delete-char-or-splice-backwards)))

(after! clojure-mode
  (map! (:localleader
         (:map (clojure-mode-map clojurescript-mode-map clojurec-mode-map)
          :desc "clojure.tools.build repl"
          "b"  #'cider-jack-in-build)))

  (map! :map clojure-mode-map
        :i "<backspace>" #'evil-cp-delete-char-or-splice-backwards-or-join)
  (map! :map cider-repl-mode-map
        :i "<backspace>" #'evil-cp-delete-char-or-splice-backwards-or-join))

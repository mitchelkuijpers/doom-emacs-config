;;; custom/clojure/autoload/cider.el -*- lexical-binding: t; -*-

(defun +cider-complete-at-point ()
  (when (cider-connected-p)
    (cider-complete-at-point)))

;;;###autoload
(defun +lsp-completion-at-point ()
  (when lsp-mode
    (funcall 'lsp-completion-at-point)))

;;;###autoload
(defun clojure-set-completion-at-point-h ()
  (setq-local completion-styles '(orderless
                                  partial-completion
                                  cider))

  (defalias 'cape-cider-lsp-yas
    (cape-capf-super #'+cider-complete-at-point
                     #'+lsp-completion-at-point
                     #'yasnippet-capf))

  (add-to-list 'completion-at-point-functions #'cape-cider-lsp-yas)

  (setq-local completion-at-point-functions
              (seq-difference
               completion-at-point-functions
               '(lsp-completion-at-point
                 cider-complete-at-point
                 yasnippet-capf))))

;;;###autoload
(defun cider-jack-in-build (params)
  (interactive "P")
  (let ((cider-clojure-cli-aliases "build"))
    (cider-jack-in-clj params)))

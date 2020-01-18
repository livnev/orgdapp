(require 'package)
(require 'org)

;; don't make backup~ files
(setq make-backup-files nil)

(defun make-tex (source)
  (interactive "sFile to export: ")
  (with-current-buffer (find-file-noselect source)
    (org-latex-export-to-latex)))

(defun make-html (source target)
  (interactive "sFile to export: \nsFile to save as: ")
  ;; css lives separately
  (setq org-html-htmlize-output-type 'css)
  (with-current-buffer (find-file-noselect source)
    (org-export-to-file 'html target)))

(defun make-css (source target)
  (interactive "sFile to export css from: \nsFile to save as: ")
  ;; load theme for css export
  (require 'solarized-theme)
  (load-theme 'solarized-light t)
  (with-current-buffer (find-file-noselect source)
    (org-html-htmlize-generate-css)
    (with-current-buffer "*html*"
      (write-file target))
    (kill-emacs)))

(defun tangle (source mode)
  (interactive "sFile to tangle: \nsMode to tangle: ")
  (org-babel-tangle-file source nil mode))

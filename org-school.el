;;; org-school.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Ido Merenstein
;;
;; Author: Ido Merenstein <m.ido@campus.technion.ac.il>
;; Maintainer: Ido Merenstein <m.ido@campus.technion.ac.il>
;; Created: July 04, 2023
;; Modified: July 04, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/ido/org-school
;; Package-Requires: ((emacs "28.0"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;  Here I'll add snippets specifically used to make my university studies easier.
;;
;;; Code:

(defun org-school-insert-folder-pdf-exam-checkboxes-under-subheading ()
  "Under some heading for a course, prompt user for a directory
   in which they store its exams. Then create a subheading called \"EXAMS\",
   under which all relevant exam PDF files will appear in the form of
   checkboxes.
   The idea was that I would use this to organize the methodology of
   solving exams.

   This function is obviously very tailored to my use case, and currently
   it does not offer any customization, and is not as clever as I would
   like it to be, but it definitely does the trick.

   I might make an effort to generalize the way it works in the future,
   and might even expand the idea to generate more useful workflows."
  (interactive)
  (let* ((dir (read-file-name "Directory: " "~/Notes/"))
         (bad-regex (rx (and
                         (*? anything)
                         (or "sol" "Sol" "פתרון" "Appendix" "Cover")
                         (*? anything) eol)))
         (pdf-files
          (seq-filter (apply-partially
                       (lambda (ext file) (and (string= ext (file-name-extension file))
                                               (not (string-match bad-regex file)))) "pdf")

                      (directory-files dir))))

    (unless (f-directory? dir)
      (error "Directory does not exist."))
    (when (directory-empty-p dir)
      (error "Directory is empty."))
    (unless pdf-files
      (error "No potential exam PDF files in directory."))
    ;; Place checkboxes
    (save-excursion
      (let* ((file-to-checkbox (lambda (f)
                                 (concat "- [ ] " (org-cliplink-org-mode-link-transformer
                                                   (concat "pdf:" dir f) (file-name-sans-extension f)))))
             (checkbox-seq (mapcar file-to-checkbox pdf-files)))
        (org-insert-subheading (org-current-level))
        (insert (concat  "EXAMS " "[0/" (number-to-string (length pdf-files)) "]"))
        (open-line 1)
        (next-line)
        (set-mark-command nil)
        (insert (string-join checkbox-seq  "\n"))
        (indent-region (region-beginning) (region-end))
        (deactivate-mark)))))


(provide 'org-school)
;;; org-school.el ends here

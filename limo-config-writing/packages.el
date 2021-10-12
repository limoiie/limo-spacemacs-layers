;;; packages.el --- limo-config-writing layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2021 Sylvain Benner & Contributors
;;
;; Author: Li Gengwang <limo.iie4@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `limo-config-writing-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `limo-config-writing/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `limo-config-writing/pre-init-PACKAGE' and/or
;;   `limo-config-writing/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst limo-config-writing-packages
  '(auctex
    (ob :location built-in)
    (org :location built-in)
    (org-agenda :location built-in)
    org-refile
    helm-org-rifle))

(defun limo-config-writing/post-init-ob ()
  (use-package ob
    :if (member 'org limo-config-writing-enabled)
    :defer t
    :custom
    (org-babel-uppercase-example-markers t)
    :config
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (python . t)
       (awk . t)))
    ))

(defun limo-config-writing/post-init-org ()
  (use-package org
    :if (member 'org limo-config-writing-enabled)
    :defer t
    :custom
    ;; customize todo keywords
    (org-todo-keywords
     '((sequence "TODO(t)" "INPROGRESS(i)" "|" "DONE(d)" "CANCELED(c)")
       (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "PERFORMACE(p)" "|" "FIXED(f)")))
    (org-todo-keyword-faces
     '(("TODO" :foreground "#7c7c75" :underline t)
       ("INPROGRESS" :foreground "#0098dd" :underline t)
       ("PAUSED" :foreground "#ff6480" :underline t)
       ("BUG" :foreground "#ff6480" :underline t)
       ("PERFORMACE" :foreground "#9f7efe" :underline t)
       ("CANCELED" :foreground "#ff6480" :strike-through t)))
    ;; customize tag list
    (org-tag-alist '((:startgroup . nil)
                     ("@project" . ?p)
                     ("@paper" . ?a)
                     ("@doc" . ?d)
                     ("@note" . ?n)
                     (:endgroup . nil)
                     ("@ignore" . ?i)))
    ;; customize stuck projects
    ;; see: ~/Projects/notes/emacs/org.org#Variables#org-stuck-projects
    (org-stuck-projects
     ;; 1. project-tags/TODO-keywords/properties for stuck projects
     ;; 2. a list of TODO-keywords for non stuck projects
     ;; 3. a list of tags for non stuck projects
     ;; 4. a regex expression for non stuck projects
     '("+@project|+@paper/-DONE-FIXED-CANCELED"
       ("TODO" "WORKING" "REPORT" "BUG" "KNOWNCAUSE" "PERFORMACE")
       ("@doc")
       "\\<@ignore\\>"))
    ;; customize capture
    (org-capture-templates
     `(("t" "ToDo")

       ("tt" "Quick ToDo" entry
        (file+headline
         ,(spacemacs//limo-config-writing-org/ "capture/task.org") "Tasks")
        "* TODO %?\n  %u\n  %i\n  %a")

       ("tp" "Project ToDo" entry
        (function spacemacs//limo-config-writing-find-org-entry)
        "* TODO %i\n  %u\n  %?\n  %a"
        ;; extra args to function
        :fpath spacemacs//limo-config-writing-get-projectile-todo-fpath
        :maxlevel 9)

       ("j" "Journal" entry
        (file+datetree
         ,(spacemacs//limo-config-writing-org/ "capture/journal.org"))
        "* %?\n  Entered on %u\n  %i\n  %a")

       ("n" "Notes")

       ("nn" "Quick Note" entry
        (function spacemacs//limo-config-writing-find-org-entry)
        "* %?\n  Entered on %u\n  %i\n  %a"
        ;; extra args to function
        :fpath ,(spacemacs//limo-config-writing-org/ "capture/note.org")
        :maxlevel 5)

       ("nm" "Misc Note" entry
        (function spacemacs//limo-config-writing-new-note-under)
        "* %?\n  Entered on %u\n  %i\n  %a"
        ;; extra args to function
        :dir ,(spacemacs//limo-config-writing-org/ "misc/"))

       ("e" "English Grammar" item
        (file+function
         ,(spacemacs//limo-config-writing-org/ "capture/english.org")
         spacemacs//limo-config-writing-find-org-entry-in-current-buffer)
        "- %?\n"
        ;; extra args to function
        :maxlevel 9))
     ))
  )

(defun limo-config-writing/post-init-org-agenda ()
  (use-package org-agenda
    :if (member 'org limo-config-writing-enabled)
    :defer t
    :custom
    (org-agenda-window-setup 'current-window)
    ;; enable diary todo
    (org-agenda-include-diary t)
    ;; add all the org-files into org-agenda-files for searching use
    (org-agenda-files (directory-files-recursively "~/Projects/notes/" "\\.org$"))
    ))

(defun limo-config-writing/post-init-org-refile ()
  (use-package org-refile
    :if (member 'org limo-config-writing-enabled)
    :defer t
    :custom
    (org-refile-targets '((org-agenda-files :maxlevel . 5)))
    (org-refile-use-outline-path 'file)
    ;; makes org-refile outline working with helm/ivy
    (org-outline-path-complete-in-steps nil)
    (org-refile-allow-creating-parent-nodes 'confirm)
    ))

(defun limo-config-writing/post-init-helm-org-rifle ()
  (use-package helm-org-rifle
    :if (member 'org limo-config-writing-enabled)
    :defer t
    ))

(defun limo-config-writing/post-init-auctex ()
  (use-package auctex
    :if (member 'tex limo-config-writing-enabled)
    :defer t
    :init
    ;; latex layer - update PDF buffers after successful LaTeX runs
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)
    ;; latex layer - add more macros as keywords
    (setq fn-on-load (lambda ()
                       (font-latex-add-keywords '(("citep" "*[[{")) 'reference)
                       (font-latex-add-keywords '(("citet" "*[[{")) 'reference)))
    :hook
    (LaTeX-mode . fn-on-load)
    :config
    (TeX-auto-save t)
    (TeX-parse-self t)
    (TeX-view-program-selection '((output-pdf "PDF Tools")))
    (TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
    (TeX-source-correlate-mode t)
    (TeX-source-correlate-method 'syntax)
    (TeX-source-correlate-start-server t)
    )
  )

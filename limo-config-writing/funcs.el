;;; funcs.el --- limo-config-writing layer packages file for Spacemacs.
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

;;; Functions:

(defun spacemacs//limo-config-writing-find-org-entry ()
  "Ask user for a concrete entry path in the given ORG-FPATH.
You must specify :fpath and :maxlevel in capture template entry"
  (let* (;; get args from org-capture-plist
         (fpath (plist-get org-capture-plist :fpath))
         (maxlevel (plist-get org-capture-plist :maxlevel))
         (org-refile-targets `((,fpath :maxlevel . ,maxlevel)))
         (org-refile-use-outline-path 'file)
         (org-outline-path-complete-in-steps nil)
         (org-refile-allow-creating-parent-nodes 'confirm)
         (pa (org-refile-get-location "Put here"))
         (_ (org-refile-check-position pa))
         (selected-fpath (nth 1 pa))
         (selected-point (nth 3 pa)))
    (progn
      (find-file selected-fpath)
      (org-capture-put-target-region-and-position)
      (widen)
      (goto-char selected-point))))

(defun spacemacs//limo-config-writing-find-org-entry-locally ()
  "Ask user for a concrete entry path in the current org buffer.
You must specify :maxlevel in capture template entry"
  (let* ((maxlevel (plist-get org-capture-plist :maxlevel))
         (path buffer-file-name)
         (org-refile-targets `((,path :maxlevel . ,maxlevel)))
         (org-refile-use-outline-path 'file)
         (org-outline-path-complete-in-steps nil)
         (org-refile-allow-creating-parent-nodes 'confirm)
         (pa (org-refile-get-location "Put here"))
         (_ (org-refile-check-position pa))
         (selected-point (nth 3 pa)))
    (progn
      (goto-char selected-point)))
  )

(defun spacemacs//limo-config-writing-new-note-under ()
  "Ask user for a new note under DIR."
  (let* ((default-directory (plist-get org-capture-plist :dir))
         (new-buffer (call-interactively #'find-file)))
    ;; FIXME: save after created and modified
    ;; noop
    ))

(defun spacemacs//limo-config-writing-org/ (relpath)
  "Resolve RELPATH with the configured org dir."
  (concat (file-name-as-directory limo-config-writing-org-dir) relpath))

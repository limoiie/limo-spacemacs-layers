;;; packages.el --- yara layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2021 Sylvain Benner & Contributors
;;
;; Author: Li Gengwang <limo@iie4GPU1>
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
;; added to `yara-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `yara/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `yara/pre-init-PACKAGE' and/or
;;   `yara/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst yara-packages
  '((ob :location built-in)
    (ob-yara :location (recipe
                        :fetcher github
                        :repo "limoiie/ob-yara"))
    yara-mode))

(defun yara/post-init-ob ()
  (use-package ob
    :defer t))

(defun yara/init-ob-yara ()
  (use-package ob-yara
    :defer t
    :after ob
    :config
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((yara . t)))
    ))

(defun yara/init-yara-mode ()
  (use-package yara-mode
    :defer t
    :mode (("\\.yara\\'" . yara-mode)
           ("\\.yar\\'" . yara-mode))))


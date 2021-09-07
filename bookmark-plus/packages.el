;;; packages.el --- bookmark-plus layer packages file for Spacemacs.
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
;; added to `bookmark-plus-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `bookmark-plus/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `bookmark-plus/pre-init-PACKAGE' and/or
;;   `bookmark-plus/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst bookmark-plus-packages
  '((bookmark+ :location (recipe
                         :fetcher wiki
                         :files
                         ("bookmark+.el"
                          "bookmark+-mac.el"
                          "bookmark+-bmu.el"
                          "bookmark+-1.el"
                          "bookmark+-key.el"
                          "bookmark+-lit.el"
                          "bookmark+-doc.el"
                          "bookmark+-chg.el")))))


(defun bookmark-plus/init-bookmark+ ()
  (use-package bookmark+
    :defer t
    :custom
    (bmkp-last-as-first-bookmark-file last-as-first-bookmark-file)
    :hook (prog-mode . (lambda () (require 'bookmark+))))
  )

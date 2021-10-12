;;; packages.el --- limo-config-common layer packages file for Spacemacs.
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
;; added to `limo-config-common-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `limo-config-common/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `limo-config-common/pre-init-PACKAGE' and/or
;;   `limo-config-common/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst limo-config-common-packages
  '(compile
    company
    (clipetty :toggle limo-config-common-clipetty-enable)
    (eterm-256color :toggle limo-config-common-eterm-256color-enable)
    helm
    )
  "The list of Lisp packages required by the limo-config-common layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun limo-config-common/post-init-compile ()
  (use-package compile
    :defer t
    :custom
    (compilation-window-height 15)
    ))

(defun limo-config-common/post-init-company ()
  (use-package company
    :defer t
    :custom
    (company-show-numbers t)))

(defun limo-config-common/init-clipetty ()
  (use-package clipetty
    :config
    (global-clipetty-mode)))

(defun limo-config-common/init-eterm-256color ()
  (use-package eterm-256color-mode
    :defer t
    :hook term-mode))

(defun limo-config-common/post-init-helm ()
  (use-package helm
    :if limo-config-common-helm-float
    :defer t
    :custom
    (helm-display-function 'helm-display-buffer-in-own-frame)
    (helm-display-buffer-reuse-frame t)
    (helm-use-undecorated-frame-option t)
    ))
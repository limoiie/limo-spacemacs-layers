;;; packages.el --- limo-config-binana layer packages file for Spacemacs.
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
;; added to `limo-config-binana-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `limo-config-binana/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `limo-config-binana/pre-init-PACKAGE' and/or
;;   `limo-config-binana/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

;; disabled temporaryly: I still cannot figure out a way to use-package those
;; packages installed in the opam site path.
;; (defun limo-config-binana-opam-user-setup ()
;;   (if (file-exists-p "opam-user-setup/opam-user-setup.el")
;;       t
;;     (progn
;;       (when (file-exists-p "~/.emacs.d/opam-user-setup.el")
;;         (copy-file "~/.emacs.d/opam-user-setup.el" "opam-user-setup/"))
;;       (file-exists-p "opam-user-setup/opam-user-setup.el"))))

(defconst limo-config-binana-packages
  `(;; (opam-user-setup :location local
    ;;                  :toggle ,(limo-config-binana-opam-user-setup))
    (llvm-mode :location local)
    (tablegen-mode :location local)
    bap-mode
    ))

(defun limo-config-binana/init-llvm-mode ()
  (use-package llvm-mode
    :defer t
    :mode "\\.ll\\'"
    )
  )

(defun limo-config-binana/init-tablegen-mode ()
  (use-package tablegen-mode
    :defer t
    :mode "\\.tb\\'"
    )
  )

;; temporaryly disabled
;; (defun limo-config-binana/init-opam-user-setup ()
;;   (use-package opam-user-setup
;;     :defer t
;;     )
;;   )

(defun limo-config-binana/init-bap-mode ()
  (use-package bap-mode
    :defer t
    :mode "\\.bir\\'"))


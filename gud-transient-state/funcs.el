;;; funcs.el --- gud-transient-state layer packages file for Spacemacs.
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

(defun spacemacs//gud-ts-toggle-hint ()
  "Toggle the full hint docstring for the gud transient-state."
  (interactive)
  (setq spacemacs--gud-ts-full-hint-toggle
        (not spacemacs--gud-ts-full-hint-toggle)))

(defun spacemacs//gud-ts-hint ()
  "Return a one liner string containing help hint."
  (if spacemacs--gud-ts-full-hint-toggle
      spacemacs--gud-ts-full-hint
    (concat "  (["
            (propertize "?" 'face 'hydra-face-pink)
            "] help)")))


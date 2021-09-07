;;; packages.el --- limo-config-keymap layer packages file for Spacemacs.
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
;; added to `limo-config-keymap-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `limo-config-keymap/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `limo-config-keymap/pre-init-PACKAGE' and/or
;;   `limo-config-keymap/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst limo-config-keymap-packages
  '(compile))


(defun limo-config-keymap/post-init-compile ()
  (use-package compile
    :defer t
    :init
    (global-set-key (kbd "C-;") 'evil-avy-goto-char-timer)
    (global-set-key (kbd "C-:") 'evil-avy-goto-line)

    (global-set-key (kbd "M-;") 'spacemacs//limo-config-keymap-smart-comment)
    (global-set-key (kbd "C-?") 'company-search-candidates)

    (global-set-key (kbd "C-M-<left>") 'evil-jump-backward)
    (global-set-key (kbd "C-M-<right>") 'evil-jump-forward)

    (message "limo-config-keymap: %s" (spacemacs//limo-config-keymap-env))

    (pcase (spacemacs//limo-config-keymap-env)
      ;; gui
      ('(gui mac) (setq mac-option-key-is-meta nil
                        mac-command-key-is-meta t
                        mac-command-modifier 'none
                        mac-option-modifier 'meta))
      ('(gui win) ())
      ('(gui linux) ())
      ;; term
      ('(term mac "iterm2") ())
      ('(term linux "terminal") ())
      ('(term win "windows-terminal") ())
      ;; term through ssh
      ('(term ssh "iterm2")
       (progn
         (global-set-key (kbd "C-[ [27;6;72~") 'evil-jump-backward)
         (global-set-key (kbd "C-[ [27;6;73~") 'evil-jump-forward)))
      ('(term ssh "terminal") ())
      ('(term ssh "windows-terminal") ())
      ('(term ssh "unknown")
       (progn
         (message "limo-config-keymap: unknown term through ssh"))))
    ))

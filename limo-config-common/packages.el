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
    clipetty
    eterm-256color
    helm
    hl-todo
    git-gutter+)
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
    ;; show fringe on the right side
    (fringe-mode '(0) nil (fringe))
    ;; do not highligh the current line
    (global-hl-line-mode nil)
    ;; widden line number fringe
    (linum-format " %6d ")
    (shell-pop-window-size 20)
    (window-divider-mode nil)
    :hook
    ;; transparent background by overwritting theme's background color
    (window-setup . spacemacs//limo-config-common-config-background)
    ;; enable visual line navigation for textual modes
    (text-mode . spacemacs/toggle-visual-line-navigation-on)
    ;; enable line ruler
    (text-mode . spacemacs/toggle-fill-column-indicator)
    (prog-mode . spacemacs/toggle-fill-column-indicator)
    ))

(defun limo-config-common/post-init-hl-todo ()
  (use-package hl-todo
    :defer t
    :custom
    (hl-todo-keyword-faces
     '(("TODO"     . "#FFD700")  ; gold
       ("FIXME"    . "#FF4500")  ; orange red
       ("HACK"     . "#8B008B")  ; dark magenta
       ("NOTE"     . "#C0C0C0")  ; light gray
       ("IMPROVE"  . "#00FF7F")  ; spring green
       ("OPTIMIZE" . "#00FF7F")  ; spring green
       ("REFACTOR" . "#9966FF")  ; purple
       ("DEBUG"    . "#1E90FF")  ; dodger blue
       ("GOTCHA"   . "#FF69B4")  ; hot pink
       ("STUB"     . "#8F8080")  ; gray
       ))))

(defun limo-config-common/post-init-company ()
  (use-package company
    :defer t
    :custom
    (company-show-numbers t)))

(defun limo-config-common/init-clipetty ()
  (use-package clipetty
    :if limo-config-common-clipetty-enable
    :config
    (global-clipetty-mode)))

(defun limo-config-common/init-eterm-256color ()
  (use-package eterm-256color-mode
    :if limo-config-common-clipetty-enable
    :defer t
    :hook term-mode))

(defun limo-config-common/post-init-helm ()
  (use-package helm
    :if limo-config-common-helm-float
    :defer t
    :custom
    (helm-display-function 'spacemacs//limo-config-common-helm-display-float)
    (helm-display-buffer-reuse-frame t)
    (helm-use-undecorated-frame-option t)
    ))

(defun limo-config-common/post-init-git-gutter+ ()
  (use-package git-gutter+
    :defer t
    :config
    (set-face-background 'git-gutter+-modified "brightblack")
    ))

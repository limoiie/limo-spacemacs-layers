;;; funcs.el --- limo-config layer packages file for Spacemacs.
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

(defun spacemacs//limo-config-keymap-smart-comment (&optional arg)
  "Ask user for a new note under DIR."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position)
                                   (line-end-position))
    (comment-dwim arg))
  )

(defun spacemacs//limo-config-keymap-env ()
  "Get emacs's runtim environment."
  (if (display-graphic-p)
      `(gui ,limo-config-keymap-style)
    (if (spacemacs/limo-config-keymap-is-through-ssh)
        `(term ssh ,(spacemacs/limo-config-keymap-term-name t))
      `(term ,limo-config-keymap-style
             ,(spacemacs/limo-config-keymap-term-name nil))
      )))

(defun spacemacs/limo-config-keymap-is-through-ssh ()
  "Check if current shell session connected throught ssh."
  (or (getenv "SSH_TTY") (getenv "SSH_CLIENT")))

(defun spacemacs/limo-config-keymap-term-name (is-through-ssh)
  "Get the terminal type from environment variable.
If the current shell is controlled by a ssh, try to read the type from
a user customized environment variable."
  (let ((term-name (getenv "REMOTE_TERM")))
    (or term-name
        (if is-through-ssh
            "unknown"  ; we have no idea about the remote term
          ;; guess the preferred term by system
          (spacemacs//limo-config-keymap-default-term-name)))
    ))

(defun spacemacs//limo-config-keymap-default-term-name ()
  "Get default term name by system."
  (cl-case limo-config-keymap-style
    (mac "iterm2")
    (linux "terminal")
    (win "windows-terminal")
    ))

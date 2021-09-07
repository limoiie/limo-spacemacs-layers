;;; packages.el --- gud-transient-state layer packages file for Spacemacs.
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

;;; Code:

(defconst gud-transient-state-packages
  '(compile))


(defun gud-transient-state/post-init-compile ()
  (use-package compile
    :defer t
    :init
    (progn
      (spacemacs|transient-state-format-hint gud
        spacemacs--gud-ts-full-hint
        "\n
Breakpoints^^     Execution^^^^            Eval^^                   View^^
───────────^^───  ─────────^^^^────────    ────^^─────────────────  ────^^──────────
[_bb_] Break      [_n_/_N_]  Next (i)      [_pp_] Print             [_R_] Refresh
[_bd_] Delete     [_i_/_I_]  Step (i)      [_ps_] Print Star        [_W_] Watch
[_bt_] Temporary  [_o_]^^    Finish        [_pe_] Print Emacs Sexp  [_F_] Info
^^                [_u_/_J_]  Until/Jump    ^^                       [_<_] Up Stack
^^                [_r_/_c_]  Run/Cont      ^^                       [_>_] Down Stack
^^                [_go_]^^   Go            ^^                       [_?_] Toggle Help")
      (spacemacs|define-transient-state gud
        :title "Gud Transient State"
        :hint-is-doc t
        :foreign-keys run
        :dynamic-hint (spacemacs//gud-ts-hint)
        :bindings
        ("?" spacemacs//gud-ts-toggle-hint)
        ("q" nil :exit t)
        ;; Execution
        ("n" gud-next) ("N" gud-nexti)
        ("i" gud-step) ("I" gud-stepi)
        ("o" gud-finish)
        ("u" gud-until) ("J" gud-jump)
        ("c" gud-cont) ("r" gud-run)
        ("go" gud-go)
        ;; Breakpoints
        ("bb" gud-break)
        ("bd" gud-remove)
        ("bt" gud-tbreak)
        ;; View
        ("R" gud-refresh)
        ("W" gud-watch)
        ("F" gud-goto-info)
        ("<" gud-up)
        (">" gud-down)
        ;; Eval
        ("pp" gud-print)
        ("ps" gud-pstar)
        ("pe" gud-pp)
        )

      ;; TODO: hook on Mode debugger, Buffer *gud-main*
      (spacemacs/set-leader-keys "md." 'spacemacs/gud-transient-state/body)
      (defadvice gud-display-line (after gud-display-line-centered activate)
        "Center the line in the window"
        (when (and gud-overlay-arrow-position gdb-source-window)
          (with-selected-window gdb-source-window
            ;; (marker-buffer gud-overlay-arrow-position)
            (save-restriction
              (goto-line (ad-get-arg 1))
              (recenter))))))
    ))

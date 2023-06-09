;;; packages.el --- limo-config-coding layer packages file for Spacemacs.
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
;; added to `limo-config-coding-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `limo-config-coding/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `limo-config-coding/pre-init-PACKAGE' and/or
;;   `limo-config-coding/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst limo-config-coding-packages
  '(dap-mode
    lsp-mode
    lsp-ui
    company
    (copilot :location (recipe
                        :fetcher github
                        :repo "zerolfx/copilot.el"
                        :files ("*.el" "dist")))
    pyvenv))


(defun limo-config-coding/post-init-dap-mode ()
  "You need to add ~dap~ layer for enabling this."
  (use-package dap-mode
    :defer t
    :hook
    ;; see also https://emacs-lsp.github.io/dap-mode/page/configuration/#native-debug-gdblldb
    (c++-mode . (lambda () (require 'dap-gdb-lldb))))
  )

(defun limo-config-coding/post-init-lsp-mode ()
  "You need to add ~lsp~ layer for enabling this."
  (use-package lsp-mode
    :defer t
    :custom
    (lsp-headerline-breadcrumb-icons-enable nil)
    :config
    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection "ocamllsp")
      :major-modes '(caml-mode tuareg-mode)
      :server-id 'ocamllsp))
    :hook ((python-mode . lsp)
           (c++-mode . lsp)
           (c-mode . lsp)
           (tuareg-mode . lsp))
    :commands lsp)
  )

(defun limo-config-coding/post-init-lsp-ui ()
  "You need to add ~lsp~ layer for enabling this."
  (use-package lsp-ui
    :defer t
    :after lsp-mode
    :custom
    (lsp-ui-doc-position 'at-point)
    (lsp-ui-sideline-mode nil)
    (lsp-ui-sideline-show-hover nil)
    (lsp-ui-sideline-show-symbol t)
    (lsp-ui-sideline-delay 2.)
    :config
    ;; let top-level `K' call `lsp-ui-doc-glance' -- top-level `K' is bound to
    ;; `evil-smart-doc-help' which will try to call the command bound under Major Mode `h h',
    ;; in lsp-mode it is `lsp-describe-thing-at-point'.
    (define-key lsp-mode-map [remap lsp-describe-thing-at-point] #'lsp-ui-doc-glance)
    ;; prefer `lsp-ui-peek' rather than `xref-find'
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)))

(defun limo-config-coding/post-init-company ()
  "You need to add ~auto-completion~ layer for enabling this."
  (use-package company
    :defer t
    :config
    (define-key company-mode-map (kbd "M-\\") 'company-complete)
    ;; disable inline preview for copilot
    (delq 'company-preview-if-just-one-frontend company-frontends)))

(defun limo-config-coding/init-copilot ()
  (use-package copilot
    :defer t
    :config
    (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
    (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
    (define-key copilot-completion-map (kbd "C-e") 'copilot-accept-completion)
    (define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
    (define-key copilot-completion-map (kbd "C-TAB") 'copilot-accept-completion-by-word)
    (define-key copilot-completion-map (kbd "M-f") 'copilot-accept-completion-by-word)
    (define-key copilot-completion-map (kbd "C-[") 'copilot-previous-completion)
    (define-key copilot-completion-map (kbd "C-]") 'copilot-next-completion)
    (spacemacs|diminish copilot-mode " ⓒ" " c")
    :hook ((prog-mode . copilot-mode))))

(defun limo-config-coding/post-init-pyvenv ()
  "You need to add ~python~ layer for enabling this."

  (when limo-config-coding-pyvenv-workon-home
    (setenv "WORKON_HOME" limo-config-coding-pyvenv-workon-home))

  (use-package pyvenv
    :if limo-config-coding-pyvenv-enabled
    :defer
    :init
    (setq fn-activate
          (lambda ()
            (when limo-config-coding-pyvenv-default-env
              (pyvenv-activate limo-config-coding-pyvenv-default-env))))
    :hook ((python-mode . fn-activate))))

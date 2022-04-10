;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

;; reference: https://github.com/hlissner/doom-emacs/issues/3952
(setq mac-command-modifier       'super
      ns-command-modifier        'super
      mac-option-modifier        'meta
      ns-option-modifier         'meta
      mac-right-option-modifier  'meta   ;; nil by default
      ns-right-option-modifier   'meta   ;; nil by default
      mac-right-command-modifier 'meta
      )

(map!
 "s-}"          (lambda () (interactive) (other-window  1))
 "s-{"          (lambda () (interactive) (other-window -1))
 "s-0"          #'+treemacs/toggle
 "s-1"          #'+workspace/switch-to-0
 "s-2"          #'+workspace/switch-to-1
 "s-3"          #'+workspace/switch-to-2
 "s-4"          #'+workspace/switch-to-3
 "s-5"          #'+workspace/switch-to-4
 "s-6"          #'+workspace/switch-to-5
 "s-7"          #'+workspace/switch-to
 "s-8"          #'+workspace/switch-left
 "s-9"          #'+workspace/switch-right
 ;; "C-c C-;"      #'comment-or-uncomment-region
 ;;"M-x"          #'lsp-rename
 "C-x C-m"      #'counsel-M-x
 "C-x m"        #'counsel-M-x
 "s-x"          #'kill-region
 ;;"C-z C-z"      #'counsel-M-x
 "M-s-."        #'+lookup/definition-other-window
 ;;"C-w"          #'backward-kill-word
 "C-x e"        #'end-of-buffer
 "C-x t"        #'beginning-of-buffer
 ;;"C-c C-c"      #'comment-dwim  ;; in collision with magit commit and shell ctrl-c
 "C-c ;"        #'comment-dwim
 "C-c C-;"      #'comment-dwim
 "s-f"          #'forward-word
 "s-b"          #'backward-word
)

;; Go hooks
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook! go-mode #'lsp-go-install-save-hooks)


;; my private leader key
(map! "C-z" nil)
;;(setq doom-localleader-alt-key "C-z")
;;(setq doom-localleader-alt-key "C-z l")

;;(map! "C-j" nil)
(setq doom-localleader-alt-key "C-j")

(require 'general)
(general-create-definer my-leader-def
  :prefix "C-z")

(my-leader-def
  ;;";" 'comment-or-uncomment-region
  ";" 'comment-dwim
  ;; ";" 'comment-line
  ;; bind nothing but give SPC f a description for which-key
  "r" '(:ignore t :which-key "lsp references")
  "l" '(:ignore t :which-key "local leader")
  "b"  (cmd! (compile "go build"))
  "n" `lsp-rename
  "C-z" `counsel-M-x
)

(general-create-definer my-leader-references-def
  :keymaps 'lsp-mode-map
  :prefix "C-z r")

(my-leader-references-def
  "k" `lsp-ui-peek-find-references
  "r" `lsp-find-references
  "f" `lsp-find-references
  "p" `lsp-ui-find-prev-reference
  "n" `lsp-ui-find-next-reference
 )

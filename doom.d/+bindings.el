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
 ;; copy paste for ubuntu
 "s-z"          #'undo-fu-only-undo
 "s-x"          #'kill-region
 "s-c"          #'copy-region-as-kill
 "s-v"          #'yank
 "s-a"          #'mark-whole-buffer
)

;; macos specific keybindings
;; from: https://github.com/doomemacs/doomemacs/blob/c44bc81a05f3758ceaa28921dd9c830b9c571e61/modules/config/default/config.el#L298

  ;; Fix MacOS shift+tab
  (define-key key-translation-map [S-iso-lefttab] [backtab])
  ;; Fix conventional OS keys in Emacs
  (map! "s-`" #'other-frame  ; fix frame-switching
        ;; fix OS window/frame navigation/manipulation keys
        "s-w" #'delete-window
        "s-W" #'delete-frame
        "s-n" #'+default/new-buffer
        "s-N" #'make-frame
        "s-q" (if (daemonp) #'delete-frame #'save-buffers-kill-terminal)
        "C-s-f" #'toggle-frame-fullscreen
        ;; Restore somewhat common navigation
        "s-l" #'goto-line
        ;; Restore OS undo, save, copy, & paste keys (without cua-mode, because
        ;; it imposes some other functionality and overhead we don't need)
        "s-f" (if (modulep! :completion vertico) #'consult-line #'swiper)
        "s-z" #'undo
        "s-Z" #'redo
        "s-c" (if (featurep 'evil) #'evil-yank #'copy-region-as-kill)
        "s-v" #'yank
        "s-s" #'save-buffer
        "s-x" #'execute-extended-command
        :v "s-x" #'kill-region
        ;; Buffer-local font scaling
        "s-+" #'doom/reset-font-size
        "s-0" #'doom/reset-font-size
        "s-=" #'doom/increase-font-size
        "s--" #'doom/decrease-font-size
        ;; Conventional text-editing keys & motions
        "s-a" #'mark-whole-buffer
        "s-/" (cmd! (save-excursion (comment-line 1)))
        :n "s-/" #'evilnc-comment-or-uncomment-lines
        :v "s-/" #'evilnc-comment-operator
        :gi  [s-backspace] #'doom/backward-kill-to-bol-and-indent
        :gi  [s-left]      #'doom/backward-to-bol-or-indent
        :gi  [s-right]     #'doom/forward-to-last-non-comment-or-eol
        :gi  [M-backspace] #'backward-kill-word
        :gi  [M-left]      #'backward-word
        :gi  [M-right]     #'forward-word)


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

;; add zig build flash command, and shortcut
(defun zig-build-flash ()
  "Compile and flash microcontroller `zig build flash`."
  (interactive)
  (zig--run-cmd "build flash"))


;; ref: https://github.com/doomemacs/doomemacs/blob/master/modules/lang/zig/config.el
(map! :localleader
      :map zig-mode-map
      "m" #'zig-build-flash )


;;(set-face-attribute 'default nil :height 192)

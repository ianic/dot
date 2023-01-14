;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(map!
 ;; "s-}"          (lambda () (interactive) (other-window  1))
 ;; "s-{"          (lambda () (interactive) (other-window -1))
 "s-]"          (lambda () (interactive) (other-window  1))
 "s-["          (lambda () (interactive) (other-window -1))
 "s-1"          #'+workspace/switch-to-0
 "s-2"          #'+workspace/switch-to-1
 "s-3"          #'+workspace/switch-to-2
 "s-4"          #'+workspace/switch-to-3
 "s-5"          #'+workspace/switch-to-4
 "s-6"          #'+workspace/switch-to-5
 "s-o"          #'+workspace/switch-to
 "s-{"          #'+workspace/switch-left
 "s-}"          #'+workspace/switch-right
 ;; "C-c C-;"      #'comment-or-uncomment-region
 "C-x C-m"      #'counsel-M-x
 "C-x m"        #'counsel-M-x
 "s-x"          #'kill-region
 "M-s-."        #'+lookup/definition-other-window
 ;;"C-w"          #'backward-kill-word
 "C-x e"        #'end-of-buffer
 "C-x t"        #'beginning-of-buffer
 "C-c ;"        #'comment-dwim
 "C-c C-;"      #'comment-dwim
 "s-f"          #'forward-word
 "s-b"          #'backward-word
 ;; copy paste
 "s-z"          #'undo-fu-only-undo
 "s-x"          #'kill-region
 "s-c"          #'copy-region-as-kill
 "s-v"          #'yank
 "s-a"          #'mark-whole-buffer
 ;; like pallete in vscode and warp
 "s-p"          #'counsel-M-x
 "s-0"          #'doom/reset-font-size
 "s-r"          #'query-replace
)

(if (eq system-type 'darwin)
    ;; reference: https://github.com/hlissner/doom-emacs/issues/3952
    (setq mac-command-modifier       'super
          ns-command-modifier        'super
          mac-option-modifier        'meta
          ns-option-modifier         'meta
          mac-right-option-modifier  'meta   ;; nil by default
          ns-right-option-modifier   'meta   ;; nil by default
          mac-right-command-modifier 'meta
          )
  ;; macos specific keybindings
  ;; from: https://github.com/doomemacs/doomemacs/blob/c44bc81a05f3758ceaa28921dd9c830b9c571e61/modules/config/default/config.el#L298
  (map! "s-`" #'other-frame  ; fix frame-switching
        ;; fix OS window/frame navigation/manipulation keys
        ;; ovaj mi smeta kada fulam desni option i stisnem command
        ;;"s-w" #'delete-window
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
        :gi  [M-right]     #'forward-word
        )
  )

;; Go hooks
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(add-hook! go-mode #'lsp-go-install-save-hooks)


;; my private leader key
(map! "C-z" nil)

;;(map! "C-j" nil)
(setq doom-localleader-alt-key "C-j")

(require 'general)
(general-create-definer my-leader-def
  :prefix "C-z")

(my-leader-def
  ";" 'comment-dwim
  ;; bind nothing but give SPC f a description for which-key
  "r" '(:ignore t :which-key "lsp references")
  "l" '(:ignore t :which-key "local leader")
  "b"  (cmd! (compile "go build"))
  "n" `lsp-rename
  "C-z" `counsel-M-x
  "o" '+workspace/other
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


(defun zig-build-test ()
  "Create an executable from the current buffer and run it immediately."
  (interactive)
  (zig--run-cmd "build" "test"))

;; ref: https://github.com/doomemacs/doomemacs/blob/master/modules/lang/zig/config.el
(map! :localleader
        :map zig-mode-map
        "b" #'zig-compile
        "f" #'zig-format-buffer
        "r" #'zig-run
        "t" #'zig-build-test
        "s" #'zig-test-buffer
        ;;"m" #'zig-build-flash
        )
(setq zig-return-to-buffer-after-format t)
(setq zig-format-show-buffer nil)
;;(setq lsp-zig-zls-executable "/usr/local/bin/zls_log")
(setq lsp-zig-zls-executable "/usr/local/bin/zls")



(map! :localleader
      :map ruby-mode-map
      "r" #'recompile )

;; show which-key faster (default i 1.0 seconds)
;; ref: https://github.com/doomemacs/doomemacs/issues/1465
(setq which-key-idle-delay 0.2)

;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

(define-key local-function-key-map "\033[27;1;108~" [(super l )])
(define-key local-function-key-map "\033[27;1;112~" [(super p )])
(define-key local-function-key-map "\033[27;1;118~" [(super v )])
(define-key local-function-key-map "\033[27;1;120~" [(super x )])
(define-key local-function-key-map "\033[27;1;122~" [(super z )])

(map!
 ;; window navigation
 "s-]"          (lambda () (interactive) (other-window  1))
 "s-["          (lambda () (interactive) (other-window -1))

 "s-{"          (lambda () (interactive) (other-window  1))
 "s-}"          (lambda () (interactive) (other-window -1))

 ;; tabs/workspaces navigation
 ;; "s-{"          #'+workspace/switch-left
 ;; "s-}"          #'+workspace/switch-right

 ;; "M-["          #'+workspace/switch-left
 ;; "M-]"          #'+workspace/switch-right

 ;; "s-1"          #'+workspace/switch-to-0
 ;; "s-2"          #'+workspace/switch-to-1
 ;; "s-3"          #'+workspace/switch-to-2
 ;; "s-4"          #'+workspace/switch-to-3
 ;; "s-5"          #'+workspace/switch-to-4
 ;; "s-6"          #'+workspace/switch-to-5
 ;; "s-9"          #'+workspace/switch-to
 ;; "s-i"          #'lsp-ui-imenu

 ;; "M-1"          #'+workspace/switch-to-0
 ;; "M-2"          #'+workspace/switch-to-1
 ;; "M-3"          #'+workspace/switch-to-2
 ;; "M-4"          #'+workspace/switch-to-3
 ;; "M-5"          #'+workspace/switch-to-4
 ;; "M-6"          #'+workspace/switch-to-5

 "C-x C-m"      #'execute-extended-command
 "C-x m"        #'execute-extended-command
 "M-s-."        #'+lookup/definition-other-window


 "C-c ;"        #'comment-dwim
 "C-c C-;"      #'comment-dwim
 "C-;"          #'comment-dwim

 "M-;"          #'+company/complete
 "M-'"          #'imenu
 ;; suspended
 ;;"s-f"          #'forward-word
 ;;"s-b"          #'backward-word
 ;; "s-o"          #'+workspace/switch-to
 ;;"C-x e"        #'end-of-buffer
 ;;"C-x t"        #'beginning-of-buffer

 ;; copy paste
 "s-z"          #'undo-fu-only-undo
 "s-x"          #'kill-region
 "s-c"          #'copy-region-as-kill
 "s-v"          #'yank
 "s-a"          #'mark-whole-buffer

 ;; like pallete in vscode and warp
 "s-p"          #'find-file ;;+ivy/projectile-find-file
 "s-P"          #'execute-extended-command

 "s-0"          #'doom/reset-font-size
 "s-r"          #'query-replace
 ;; "C-s"          #'+default/search-buffer

 "s-f"          #'+default/search-buffer
 "s-F"          #'+default/search-project

 "s-E"          #'treemacs-select-window
 "s-O"          #'imenu
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
        ;;"s-x" #'execute-extended-command
        "s-x" #'kill-region
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


;; ;; my private leader key
(map! "C-z" nil)

;; (require 'general)
;; (general-create-definer my-leader-def
;;   :prefix "C-z")

;; (my-leader-def
;;   ";" 'comment-dwim
;;   ;; bind nothing but give SPC f a description for which-key
;;   "r" '(:ignore t :which-key "lsp references")
;;   "l" '(:ignore t :which-key "local leader")
;;   "b"  (cmd! (compile "go build"))
;;   "n" `lsp-rename
;;   "C-z" `counsel-M-x
;;   "o" '+workspace/other
;; )

;; (general-create-definer my-leader-references-def
;;   :keymaps 'lsp-mode-map
;;   :prefix "C-z r")


;; (my-leader-references-def
;;   "k" `lsp-ui-peek-find-references
;;   "r" `lsp-find-references
;;   "f" `lsp-find-references
;;   "p" `lsp-ui-find-prev-reference
;;   "n" `lsp-ui-find-next-reference
;;  )

;; add zig build flash command, and shortcut
(defun zig-build-flash ()
  "Compile and flash microcontroller `zig build flash`."
  (interactive)
  (zig--run-cmd "build flash"))

(defun zig-test-project ()
  "Run projects tests"
  (interactive)
  (zig--run-cmd "build" "test"))

(defun zig-test-single-test ()
  "Run single function test"
  (interactive)
  (let (
        (old-pnt (point-marker)))

    (re-search-backward "^test.*\"\\(.*\\)\".*{")
    (message "Nearest test function: %s" (match-string 1))
    (goto-char old-pnt)

    (zig--run-cmd "test" (buffer-file-name) "--test-filter" (match-string 1) "-O" zig-test-optimization-mode)
    )
  )

(setq doom-localleader-alt-key "C-j")

;; ref: https://github.com/doomemacs/doomemacs/blob/master/modules/lang/zig/config.el
(map! :localleader
      :map zig-mode-map
      :desc "Build"         "b" #'zig-compile
      :desc "Recompile"     "c" #'recompile
      :desc "Format buffer" "f" #'zig-format-buffer
      :desc "Run"           "r" #'zig-run
      :desc "Test buffer"   "t" #'zig-test-buffer
      :desc "Test project"  "p" #'zig-test-project
      :desc "Test function" "s" #'zig-test-single-test
      ;;:desc "Rename"        "n" #'lsp-rename
      :desc "Rename"        "n" #'eglot-rename
      ;; (:prefix-map ("l" . "lsp")
      ;;              "p" #'lsp-ui-peek-find-references
      ;;              "r" #'lsp-find-references
      ;;              ;;"f" #'lsp-find-references
      ;;              "[" #'lsp-ui-find-prev-reference
      ;;              "]" #'lsp-ui-find-next-reference
      ;;              "n" #'lsp-rename
      ;;              )
      (:prefix-map ("e" . "eglot")
                   "a" #'eglot-code-actions
                   "d" #'eglot-find-declaration
                   "i" #'eglot-find-implementation
                   "t" #'eglot-find-typeDefinition
                   "i" #'eglot-code-action-organize-imports
                   "f" #'eglot-format-buffer
                   "n" #'eglot-rename
                   )
      ;; "m" #'zig-build-flash
      )
;; Zig
(setq zig-return-to-buffer-after-format t)
(setq zig-format-show-buffer nil)
(setq lsp-zig-zls-executable "~/.local/bin/zls")

;; Rust
(setq rustic-test-arguments "--nocapture")
(setq rustic-default-test-arguments "--benches --tests --all-features -- --nocapture")

(map! :localleader
      :map ruby-mode-map
      "r" #'recompile )

;; show which-key faster (default i 1.0 seconds)
;; ref: https://github.com/doomemacs/doomemacs/issues/1465
(setq which-key-idle-delay 0.2)

;; fix tooltip with bigger than frame
(setq company-tooltip-maximum-width 120)

(setq lsp-ui-imenu-buffer-position 'left)
(setq lsp-ui-imenu-auto-refresh t)

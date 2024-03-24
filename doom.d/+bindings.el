(unless (display-graphic-p)
  ;; map terminal keycodes to super (command) key
  (define-key local-function-key-map "\033[27;1;108~" [(super l )])
  (define-key local-function-key-map "\033[27;1;112~" [(super p )])
  (define-key local-function-key-map "\033[27;1;118~" [(super v )])
  (define-key local-function-key-map "\033[27;1;120~" [(super x )])
  (define-key local-function-key-map "\033[27;1;122~" [(super z )])
  (define-key local-function-key-map "\033[27;1;97~"  [(super a )])
  (define-key local-function-key-map "\033[27;1;91~"  [(super ?\x5B )]) ;; [ is ascii 91 0x5B
  (define-key local-function-key-map "\033[27;1;93~"  [(super ?\x5D )]) ;; ] is ascii 93 0x5D
  (define-key local-function-key-map "\033[27;1;79~"  [(super o )])

  (xterm-mouse-mode 1)
  )

(map!
 ;; window navigation with super
 ;; "s-["          (lambda () (interactive) (other-window -1))
 ;; "s-]"          (lambda () (interactive) (other-window  1))

 ;; "M-s-["        #'windmove-swap-states-left
 ;; "M-s-]"        #'windmove-swap-states-right

 ;; "M-s-o"        #'occur

 ;; window navigation with control
 "<C-lsb>"      (lambda () (interactive) (other-window  -1))
 "C-]"          (lambda () (interactive) (other-window 1))

 "C-M-["        #'windmove-swap-states-left
 "C-M-]"        #'windmove-swap-states-right

 ;; prebacio se na i3 pa on ima ovaj keybinding, exwm je disabled
 ;; "s-}"          #'exwm/workspace-next
 ;; "s-{"          #'exwm/workspace-previous

 ;; "s-1"          #'winum-select-window-1
 ;; "s-2"          #'winum-select-window-2
 ;; "s-3"          #'winum-select-window-3
 ;; "s-4"          #'winum-select-window-4
 ;; "s-5"          #'winum-select-window-5
 ;; "s-6"          #'winum-select-window-6


 "C-x <C-m>"    #'execute-extended-command
 "C-x C-m"      #'execute-extended-command
 "C-x m"        #'execute-extended-command
 "<C-m>"        #'execute-extended-command
 ;;"M-s-."        #'+lookup/definition-other-window
 "C-x C-o"      #'other-window
 "M-o"          #'other-window
 ;;"<C-i>"        #'other-window
 ;; "C-o"          (lambda () (interactive) (other-window  1))

 ;; comment line or region; do what I mean
 "C-c ;"        #'comment-dwim
 "C-c C-;"      #'comment-dwim
 "C-;"          #'comment-dwim

 ;;"M-;"          #'+company/complete
 ;;"M-i"          #'imenu

 ;; copy paste
 "s-z"          #'undo-fu-only-undo
 "s-x"          #'kill-region
 "s-c"          #'copy-region-as-kill
 "s-v"          #'yank
 "s-a"          #'mark-whole-buffer

 ;; like pallete in vscode and warp
 ;;"s-p"          #'find-file ;;+ivy/projectile-find-file
 ;;"s-P"          #'execute-extended-command
 ;;"s-O"          #'imenu
 ;; "s-w"          #'kill-this-buffer ;; dangerous if I miss a key

 "s-0"          #'doom/reset-font-size
 "s-="          #'doom/increase-font-size
 "s--"          #'doom/decrease-font-size

 "s-r"          #'query-replace
 "s-l"          #'consult-goto-line

 "C-c r"        #'query-replace
 "C-c l"        #'consult-goto-line

 ;; [s-return]     #'start-ghostty
 ;; rethink this
 ;;"s-f"          #'+default/search-buffer
 ;;"s-F"          #'+default/search-project
 ;;"s-E"          #'treemacs-select-window   ;; TODO treemacs not active

 ;;; remove smartparens mapping
 ;;; ref: https://github.com/doomemacs/doomemacs/blob/d509d8bea1ad27ab9b7e9ddca329f494686b336e/modules/config/default/%2Bemacs-bindings.el#L616
 ;;"C-M-a"           nil
 ;;"C-M-e"           nil
 "C-M-f"           #'forward-sexp
 "C-M-b"           #'backward-sexp
 "C-M-n"           #'next-sexp
 "C-M-p"           #'previous-sexp
 "C-M-u"           #'up-sexp
 "C-M-d"           #'down-sexp
 "C-M-k"           #'kill-sexp
 "C-M-t"           #'transpose-sexp
 "C-M-<backspace>" #'splice-sexp
 )

(setq doom-localleader-alt-key "C-j")

(defun start-ghostty ()
  "Start ghostty terminal"
  (interactive)
  (start-process-shell-command "ghostty" nil "ghostty")
  )

(defun zig-test-project ()
  "Run projects tests"
  (interactive)
  (zig--run-cmd "build" "test")
  )

(defun zig-test-single-test ()
  "Run single function test"
  (interactive)
  (let (
        (old-pnt (point-marker)))

    (re-search-backward "^test.*\"\\(.*\\)\".*{")

    (when-let ((test-name (match-string 1)))
      (message "Nearest test function: %s" test-name)
      (setq zig-test-last-test test-name)
      (zig--run-cmd "test" (buffer-file-name) "--test-filter" test-name "-O" zig-test-optimization-mode)
      (goto-char old-pnt)
      )
    )
  )

(defun zig-test-run-last-test ()
  "Run last single function test"
  (interactive)
  (zig--run-cmd "test" (buffer-file-name) "--test-filter" zig-test-last-test "-O" zig-test-optimization-mode)
  )


;; ref: https://github.com/doomemacs/doomemacs/blob/master/modules/lang/zig/config.el
(map! :localleader
      :map zig-mode-map
      :desc "Build"              "b" #'zig-compile
      :desc "Recompile"          "c" #'recompile
      :desc "Format buffer"      "f" #'zig-format-buffer
      :desc "Run"                "x" #'zig-run
      :desc "Test buffer"        "t" #'zig-test-buffer
      :desc "Test project"       "p" #'zig-test-project
      :desc "Test function"      "s" #'zig-test-single-test
      :desc "Test last function" "d" #'zig-test-run-last-test

      :desc "Rename"             "n" #'eglot-rename
      :desc "Find references"    "r" #'xref-find-references

      (:prefix-map ("e" . "eglot")
                   "a" #'eglot-code-actions
                   "d" #'eglot-find-declaration
                   "i" #'eglot-find-implementation
                   "t" #'eglot-find-typeDefinition
                   "i" #'eglot-code-action-organize-imports
                   "f" #'eglot-format-buffer
                   "n" #'eglot-rename
                   )
      ;; :desc "Rename"        "n" #'lsp-rename
      ;; (:prefix-map ("l" . "lsp")
      ;;              "p" #'lsp-ui-peek-find-references
      ;;              "r" #'lsp-find-references
      ;;              ;;"f" #'lsp-find-references
      ;;              "[" #'lsp-ui-find-prev-reference
      ;;              "]" #'lsp-ui-find-next-reference
      ;;              "n" #'lsp-rename
      ;;              )
      )

(map! :after zig-mode
      :map zig-mode-map
      "C-M-a" #'zig-beginning-of-defun
      "C-M-e" #'zig-end-of-defun
      )

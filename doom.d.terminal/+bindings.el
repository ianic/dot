;; map terminal keycodes to super (command) key
(define-key local-function-key-map "\033[27;1;108~" [(super l )])
(define-key local-function-key-map "\033[27;1;112~" [(super p )])
(define-key local-function-key-map "\033[27;1;118~" [(super v )])
(define-key local-function-key-map "\033[27;1;120~" [(super x )])
(define-key local-function-key-map "\033[27;1;122~" [(super z )])
(define-key local-function-key-map "\033[27;1;97~"  [(super a )])

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
 "C-x C-o"      #'other-window

 ;; comment line or region; do what I mean
 "C-c ;"        #'comment-dwim
 "C-c C-;"      #'comment-dwim
 "C-;"          #'comment-dwim

 "M-;"          #'+company/complete
 "M-'"          #'imenu

 ;; copy paste
 "s-z"          #'undo-fu-only-undo
 "s-x"          #'kill-region
 "s-c"          #'copy-region-as-kill
 "s-v"          #'yank
 "s-a"          #'mark-whole-buffer
 "s-l"          #'consult-goto-line

 ;; like pallete in vscode and warp
 "s-p"          #'find-file ;;+ivy/projectile-find-file
 "s-P"          #'execute-extended-command

 "s-0"          #'doom/reset-font-size
 "s-r"          #'query-replace

 "s-f"          #'+default/search-buffer
 "s-F"          #'+default/search-project

 "s-E"          #'treemacs-select-window   ;; TODO treemacs not active
 "s-O"          #'imenu
)

(setq doom-localleader-alt-key "C-j")

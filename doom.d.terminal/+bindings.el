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
 ;; window navigation
 "s-]"          (lambda () (interactive) (other-window  1))
 "s-["          (lambda () (interactive) (other-window -1))
 "s-}"          #'exwm/workspace-next
 "s-{"          #'exwm/workspace-previous

 "C-x C-m"      #'execute-extended-command
 "C-x m"        #'execute-extended-command
 ;;"M-s-."        #'+lookup/definition-other-window
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

 ;; like pallete in vscode and warp
 "s-p"          #'find-file ;;+ivy/projectile-find-file
 "s-P"          #'execute-extended-command
 "s-O"          #'imenu
 "s-w"          #'kill-this-buffer

 "s-0"          #'doom/reset-font-size
 "s-="          #'doom/increase-font-size
 "s--"          #'doom/decrease-font-size

 "s-r"          #'query-replace
 "s-l"          #'consult-goto-line

 [s-return]     #'+vterm/here
 ;; rethink this
 ;;"s-f"          #'+default/search-buffer
 ;;"s-F"          #'+default/search-project
 ;;"s-E"          #'treemacs-select-window   ;; TODO treemacs not active
 )

(setq doom-localleader-alt-key "C-j")

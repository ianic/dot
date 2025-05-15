;;; ../dot/doom/+bindings.el -*- lexical-binding: t; -*-

(map!
 ;;"C-x <C-m>"    #'execute-extended-command
 "C-x C-m"      #'execute-extended-command
 "C-x m"        #'execute-extended-command
 ;;"<C-m>"        #'execute-extended-command

 ;; ;; window navigation with super
 ;; "s-{"          (lambda () (interactive) (other-window -1))
 ;; "s-}"          (lambda () (interactive) (other-window  1))



 ;; ;; cmd-shift-{ / cmd-shift-} is mapped to control-tab / control-shift-tab system wide
 ;; ;; so this is: s-{ s-}
 ;; "C-<iso-lefttab>"  (lambda () (interactive) (other-window  -1))
 ;; "C-<tab>"          (lambda () (interactive) (other-window 1))

 ;; "C-<return>"   #'other-frame
 ;; "s-<return>"   #'other-frame
 ;; "s-t"          #'+vterm/here

 ;; "M-s-["        #'windmove-swap-states-left
 ;; "M-s-]"        #'windmove-swap-states-right

 ;; "s-1"          #'winum-select-window-1
 ;; "s-2"          #'winum-select-window-2
 ;; "s-3"          #'winum-select-window-3
 ;; "s-4"          #'winum-select-window-4
 ;; "s-5"          #'winum-select-window-5
 ;; "s-6"          #'winum-select-window-6

 ;; "M-s-o"        #'occur

 ;; "C-x <C-m>"    #'execute-extended-command
 ;; "C-x C-m"      #'execute-extended-command
 ;; "C-x m"        #'execute-extended-command
 ;; "<C-m>"        #'execute-extended-command
 ;; "C-x C-o"      #'ace-window
 ;; "M-o"          #'other-window

 ;; ;; comment line or region; do what I mean
 ;; "C-c ;"        #'comment-dwim
 ;; "C-c C-;"      #'comment-dwim
 ;; "C-;"          #'comment-dwim

 ;; ;; copy paste
 ;; "s-z"          #'undo-fu-only-undo
 ;; "s-x"          #'kill-region
 ;; "s-c"          #'copy-region-as-kill
 ;; "s-v"          #'yank
 ;; "s-a"          #'mark-whole-buffer


 ;; "s-0"          #'doom/reset-font-size
 ;; "s-="          #'doom/increase-font-size
 ;; "s--"          #'doom/decrease-font-size

 ;; "s-r"          #'query-replace
 ;; "s-l"          #'consult-goto-line
 ;; "s-<"          #'backward-sexp
 ;; "s->"          #'forward-sexp

 ;; "C-c r"        #'query-replace
 ;; "C-c l"        #'consult-goto-line

 ;; "M-/"            #'dabbrev-expand

 ;; "C-M-f"           #'forward-sexp
 ;; "C-M-b"           #'backward-sexp
 ;; "C-M-n"           #'next-sexp
 ;; "C-M-p"           #'previous-sexp
 ;; "C-M-u"           #'up-sexp
 ;; "C-M-d"           #'down-sexp
 ;; "C-M-k"           #'kill-sexp
 ;; "C-M-t"           #'transpose-sexp
 ;; "C-M-<backspace>" #'splice-sexp
 )

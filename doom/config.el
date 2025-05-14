;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 15))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'ef-cyprus)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq doom-modeline-height 35)


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


;; Trying to fix vc gutter
;; Ref: https://github.com/doomemacs/doomemacs/issues/8171
;;(setq shell-file-name (executable-find "bash"))
;;(setq-default vterm-shell (executable-find "zsh"))

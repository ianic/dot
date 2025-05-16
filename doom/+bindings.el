;;; ../dot/doom/+bindings.el -*- lexical-binding: t; -*-

(map!
 "C-x C-m"      #'execute-extended-command
 "C-x m"        #'execute-extended-command
 "C-x C-o"      #'other-window
 )

(setq doom-localleader-alt-key "C-j")

;; ref: https://github.com/doomemacs/doomemacs/blob/master/modules/lang/zig/config.el
(map! :after zig-mode
      :localleader
      :map zig-mode-map
      :desc "Build"              "b" #'zig-compile
      :desc "Recompile"          "c" #'recompile
      :desc "Format buffer"      "f" #'zig-format-buffer
      :desc "Run"                "x" #'zig-run
      :desc "Test buffer"        "t" #'zig-test-buffer
      :desc "Test project"       "p" #'zig-test-project
      :desc "Test function"      "s" #'zig-test-single-test
      :desc "Test last function" "d" #'zig-test-run-last-test

      :desc "Imenu list toggle"  "i" #'imenu-list-smart-toggle
      :desc "Rename"             "n" #'eglot-rename
      :desc "Find references"    "r" #'xref-find-references

      ;; :desc "Beginning of defun" "a" #'zig-beginning-of-defun
      ;; :desc "End of defun"       "e" #'zig-end-of-defun

      (:prefix-map ("e" . "eglot")
                   "a" #'eglot-code-actions
                   "d" #'eglot-find-declaration
                   "i" #'eglot-find-implementation
                   "t" #'eglot-find-typeDefinition
                   "i" #'eglot-code-action-organize-imports
                   "f" #'eglot-format-buffer
                   "n" #'eglot-rename
                   )
      )

(map! :after vterm
      :map vterm-mode-map
      "s-k" #'vterm-clear
      "C-j k" #'vterm-clear
      "C-j j" #'vterm-copy-mode
      "C-j C-j" #'vterm-copy-mode
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

(add-hook! zig-mode
           ;; zig-mode has it's own zig-format-on-save-mode
           (apheleia-mode nil)
           (zig-format-on-save-mode t)
           )

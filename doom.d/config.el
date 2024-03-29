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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

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

(load! "+bindings.el")

;; Themes
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
;; italic comments and keywords
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; Modeline
(if (string-equal (system-name) "io")
    (setq doom-modeline-height 70) ;; retina display in parallels
  (setq doom-modeline-height 35)
  )

(if (eq system-type 'darwin)
    (setq doom-font (font-spec :family "JetBrains Mono" :size 15) doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 15))
  (if (string-equal (system-name) "io")
      (setq doom-font (font-spec :family "JetBrainsMonoNL NFM" :size 31))
    (setq doom-font (font-spec :family "JetBrainsMonoNL NFM" :size 18))
    )
  )

;; Zig
(setq zig-return-to-buffer-after-format t)
(setq zig-format-show-buffer nil)
(setq lsp-zig-zls-executable "~/.local/bin/zls")

;; Projectile
(after! projectile
  (mapc (lambda (item)
          (add-to-list 'projectile-globally-ignored-directories item))
        '("^zig-out$" "^zig-cache$")))


;; Balance windows width on split and close
(advice-add 'split-window-right :after #'balance-windows)
(advice-add '+workspace/close-window-or-workspace :after #'balance-windows)

;; show which-key faster (default i 1.0 seconds)
;; ref: https://github.com/doomemacs/doomemacs/issues/1465
(setq which-key-idle-delay 0.2)

;; exwm window manager
;; (if (display-graphic-p)
;;     (load! "exwm.el")
;;   )

;; mode line is hidden in vterm, making it hard to see which window has focus
;; this disables hide in all buffers
;; ref: https://github.com/doomemacs/doomemacs/issues/6209
(advice-add 'hide-mode-line-mode :around (lambda (orig &optional args) nil))

(load! "dired.el")

(setq isearch-allow-motion t)

;; Display zig compilation below current window
;; Idea from: https://protesilaos.com/codelog/2024-02-08-emacs-window-rules-display-buffer-alist/
(set-popup-rule!
  "^\\*compilation\\*<zig>" ; node dedicated org-roam buffer
  :side 'bottom :width 0.3 :height 0.4 :ttl nil :modeline nil :quit t :select: nil
  :actions '(display-buffer-below-selected)
  )

;; customize theme
(custom-theme-set-faces! 'doom-nord-aurora
  ;; it was original #D8DEE9 which is almost white
  ;; this is same as comment block
  '(font-lock-doc-face :foreground "#9099AB" :slant italic)
  )

;; Emacs 29 ships with an improved global minor mode for scrolling with a mouse or a touchpad
(pixel-scroll-precision-mode)


;; reference:
;; https://emacsnotes.wordpress.com/2022/09/11/three-bonus-keys-c-i-c-m-and-c-for-your-gui-emacs-all-with-zero-headache/
(add-hook
 'after-make-frame-functions
 (defun setup-blah-keys (frame)
   (with-selected-frame frame
     (when (display-graphic-p) ; don't remove this condition, if you want
                                        ; terminal Emacs to be usable
       ;; - When you type `Ctrl-i', Emacs see it as `C-i', and NOT as 'Tab'
       ;; - When you type `Ctrl-m', Emacs see it as `C-m', and NOT as 'Return'
       ;; - When you type `Ctrl-[', Emacs see it as `C-lsb', and not as 'Esc'.
       ;;
       ;; That is,
       ;;
       ;; - `Ctrl-i' and 'Tab' keys are different
       ;; - `Ctrl-m' and 'Return' keys are different
       ;; - `Ctrl-[' and 'Esc' keys are different
       ;;
       ;; The three C keys are the bonus keys.
       ;; (define-key input-decode-map (kbd "C-i") [C-i])
       (define-key input-decode-map (kbd "C-[") [C-lsb]) ; left square bracket
       (define-key input-decode-map (kbd "C-m") [C-m])
       ;; You can replace `C-' above with `BLAH-' or
       ;; `CONTROL-', it doesnt' matter.
       ;;
       ;; C is merely a symbol / name; feel free to change
       ;; it to whatever you like .
       ;;
       ;; Found that above remaps tab also, trying different approach.
       ;; https://stackoverflow.com/questions/4512075/how-to-use-ctrl-i-for-an-emacs-shortcut-without-breaking-tabs
       ;; Translate the problematic keys to the function key Hyper,
       ;; then bind this to the desired ctrl-i behavior
       (keyboard-translate ?\C-i ?\H-i)
       (global-set-key [?\H-i] 'other-window)

       ))))

;; (setq default-directory "~/Code/" )

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Igor Anić"
      user-mail-address "igor.anic@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


(setq dabbrev-case-fold-search nil)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; reference: https://www.youtube.com/watch?v=Ey54ovJUdQ4
;; and his config: https://gitlab.com/dwt1/dotfiles/-/blob/master/.doom.d/config.el

;;(setq doom-font (font-spec :family "SauceCodePro" :size 15)
(if (eq system-type 'darwin)
  (setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 15))
  (setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 31)) ;; for linux retina display
)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; full screen on start
;;(toggle-frame-fullscreen)
(load! "+bindings.el")

(setq default-directory "~/code")

;; disable making links of all go import
(setq lsp-enable-links nil)
(setq lsp-ui-sideline-diagnostic-max-lines 8)
(setq lsp-ui-doc-position "top")
(with-eval-after-load 'lsp-mode
  (push "[/\\\\]\\tmp\\'" lsp-file-watch-ignored-directories)
  (push "[/\\\\]\\.terraform\\'" lsp-file-watch-ignored-directories)
  (push "[/\\\\]\\.state\\'" lsp-file-watch-ignored-directories)
  (push "[/\\\\]\\fork\\'" lsp-file-watch-ignored-directories)

  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "zls")
                     :major-modes '(zig-mode)
                     :remote? t
                     :server-id 'zls-remote))

)

(setq display-line-numbers-type nil)

(setq uniquify-buffer-name-style 'forward)

(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

;; add lookup other window
;; https://github.com/hlissner/doom-emacs/issues/3397
(dolist (fn '(definition references))
  (fset (intern (format "+lookup/%s-other-window" fn))
        (lambda (identifier &optional arg)
          "TODO"
          (interactive (list (doom-thing-at-point-or-region)
                             current-prefix-arg))
          (let ((pt (point)))
            (switch-to-buffer-other-window (current-buffer))
            (goto-char pt)
            (funcall (intern (format "+lookup/%s" fn)) identifier arg)))))


;;(setq lsp-zig-zls-executable "/usr/local/bin/zls")

;;(add-hook 'zig-mode-hook #'zig-toggle-format-on-save)


(add-hook 'ruby-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "ruby " buffer-file-name))))

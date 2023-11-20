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

;; There are two ways to load a themetheme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; Theme gallery: https://github.com/doomemacs/themes/tree/screenshots
(setq doom-theme 'doom-nord-aurora)
;;(setq doom-theme 'doom-one-light)
(doom-themes-visual-bell-config)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


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
    ;;(setq doom-font "-*-Iosevka Term-semibold-normal-expanded-*-15-*-*-*-m-0-iso10646-1")
    ;;(setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 15))
    (setq doom-font (font-spec :family "JetBrains Mono" :size 15)
          doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 15)
	  )
  ;;for Linux retina display
  ;;(setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 15))
  (setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 31))
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

(setq-hook! 'web-mode-hook +format-with :none)

(after! projectile
  (mapc (lambda (item)
          (add-to-list 'projectile-globally-ignored-directories item))
        '("^zig-out$" "^zig-cache$")))


;; balance windows width on split and close
(advice-add 'split-window-right :after #'balance-windows)
(advice-add '+workspace/close-window-or-workspace :after #'balance-windows)


(custom-theme-set-faces! 'doom-nord-aurora
  ;; it was original #D8DEE9 which is almost white
  ;; this is same as comment block
  '(font-lock-doc-face :foreground "#9099AB")
  )



;; beframe configuration
;; ref: https://protesilaos.com/emacs/beframe
(require 'beframe)
(beframe-mode 1)

(defvar consult-buffer-sources)
(declare-function consult--buffer-state "consult")

(with-eval-after-load 'consult
  (defface beframe-buffer
    '((t :inherit font-lock-string-face))
    "Face for `consult' framed buffers.")

  (defvar beframe-consult-source
    `( :name     "Frame-specific buffers (current frame)"
       :narrow   ?F
       :category buffer
       :face     beframe-buffer
       :history  beframe-history
       :items    ,#'beframe-buffer-names
       :action   ,#'switch-to-buffer
       :state    ,#'consult--buffer-state))

  )

(if (eq system-type 'darwin)
    (setq doom-modeline-height 35)
  (setq doom-modeline-height 70)
  )


;; ref: https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        ;;(gomod "https://github.com/camdencheek/tree-sitter-go-mod")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (zig "https://github.com/maxxnino/tree-sitter-zig")
        (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
        )
      )
;; to install them all:
;; (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))

(setq major-mode-remap-alist
      '((yaml-mode . yaml-ts-mode)
        (bash-mode . bash-ts-mode)
        (js2-mode . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (json-mode . json-ts-mode)
        (css-mode . css-ts-mode)
        (python-mode . python-ts-mode)
        (ruby-mode . ruby-ts-mode)
        (go-mode . go-ts-mode)
        )
      )

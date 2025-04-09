;;
;;
(setq prev-vterm-buffers '())
(setq vterm-buffer-no 0)

(defun my-new-vterm-buffer ()
  "Creates new vter buffer named *vterm <no>*"
  (interactive )
  (setq vterm-buffer-no (+ 1 vterm-buffer-no))
  (vterm (format "*vterm <%d>*" vterm-buffer-no))
  (hide-mode-line-mode -1)
  )


;; Returns list of vterm buffers. If there are no new/deleted buffers returns
;; previous list because (buffer-list) gets reordered with each buffer
;; selection.
(defun vterm-buffers ()
  (let* (
         (current (doom-buffers-in-mode 'vterm-mode))
         (s_current (sort-buffers (append current nil)))
         (s_prev    (sort-buffers (append prev-vterm-buffers nil)))
         )
    (if (equal s_current s_prev)
        prev-vterm-buffers
      (setq prev-vterm-buffers current)
      current)
    )
  )

;; Sort buffers by name
(defun sort-buffers (buffers)
  (sort buffers
        (lambda (a b)
          (string< (buffer-name a) (buffer-name b)))))


;; Returns list of all buffers for some major mode
(defun buffers-by-mode (mode)
  (let ((filtered-buffers '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (eq major-mode mode)
          (push buf filtered-buffers))))
    (reverse filtered-buffers)))



(defun vterm-pop-or-new ()
  (let* ((buffers (doom-buffers-in-mode 'vterm-mode))
         (buf (car buffers)))
    (if buf
        ;; pop existing vterm buffer
        (with-current-buffer buf (pop-to-buffer buf))
      ;; create new vterm buffer
      ;;(vterm nil)
      (setq vterm-buffer-no 0)
      (my-new-vterm-buffer)
      )))


(defun my-next-window ()
  "Switch to other window or to next the vterm buffer in the same window."
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (let* (
             (buffers (vterm-buffers)) ;;(buffers-by-mode 'vterm-mode))
             (buf (or (car (cdr (memq (current-buffer) buffers))) (car buffers)))
             )
        ;;(set-window-dedicated-p (selected-window) nil)
        ;;(message "%s" (buffer-name buf))
        (switch-to-buffer buf)
        ;;(set-window-dedicated-p (selected-window) t)
        )
    (other-window 1)))

(defun my-previous-window ()
  "Switch to previous window or to the previous vterm buffer int the same window."
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (let* (
             (buffers (reverse (vterm-buffers)));;(buffers-by-mode 'vterm-mode)))
             (buf (or (car (cdr (memq (current-buffer) buffers))) (car buffers)))
             )
        ;;(set-window-dedicated-p (selected-window) nil)
        (switch-to-buffer buf)
        ;;(set-window-dedicated-p (selected-window) t)
        )
    (other-window -1)))



(defun my-vterm-select-or-back ()
  "Switch to existing vterm window or create new, if in vterm return back"
  (interactive)
  (if (eq major-mode 'vterm-mode)
      ;; if already in vterm return to previous window
      (my-return-from-vterm)

    ;; find first vterm window
    (let ((first-vterm-window (cl-find-if
                               (lambda (window)
                                 (with-current-buffer (window-buffer window) (eq major-mode 'vterm-mode)))
                               (window-list))))
      ;; select that window or create new
      (if first-vterm-window
          (select-window first-vterm-window)
        (vterm-pop-or-new)
        )
      )
    )
  )

(defun my-return-from-vterm ()
  "Switch to the previously active window."
  (interactive)
  (let ((win (get-mru-window t t t)))
    (unless win (error "Last window not found"))
    (let ((frame (window-frame win)))
      (select-frame-set-input-focus frame)
      (select-window win))))

;; Pop another existing vterm buffer on exit
;; ref: https://github.com/doomemacs/doomemacs/blob/master/modules/term/vterm/config.el
;; ref: https://github.com/akermu/emacs-libvterm/issues/24#issuecomment-907660950
(use-package vterm
  :init
  (add-hook 'vterm-exit-functions
            (lambda (_ _)
              (let* ((buffer (current-buffer))
                     (window (get-buffer-window buffer)))
                (kill-buffer buffer)
                (vterm-pop-or-new)))))

;; (use-package! vterm
;;   :config
;;   ;; ref: https://github.com/doomemacs/doomemacs/issues/6651
;;   (setq vterm-buffer-name-string "vterm %s")
;;   ;; remove M-i from vterm--self-insert-meta
;;   (define-key vterm-mode-map (kbd "M-i") nil)
;;   (define-key vterm-mode-map (kbd "M-]") nil)
;;   )

(after! vterm
  (set-popup-rule! "^\\*vterm"              :size 0.25 :vslot -4 :select t :quit nil :ttl 0 :side 'left :modeline: t)
  (set-popup-rule! "*doom:vterm-popup:main" :size 0.25 :vslot -4 :select t :quit nil :ttl 0 :side 'left :modeline: t)
  (set-popup-rule! "vterm "                 :size 0.25 :vslot -4 :select t :quit nil :ttl 0 :side 'left :modeline: t)
  ;; (remove-hook 'vterm-mode-hook 'hide-mode-line-mode nil)
  (setq vterm-max-scrollback 10000)
  (setq vterm-kill-buffer-on-exit nil)

  ;; ref: https://github.com/doomemacs/doomemacs/issues/6651
  ;;(setq vterm-buffer-name-string "*vterm %s")
  ;; remove M-i from vterm--self-insert-meta
  (define-key vterm-mode-map (kbd "M-i") nil)
  (define-key vterm-mode-map (kbd "M-]") nil)

  ;;(add-hook! 'vterm-mode-hook (hide-mode-line-mode))
  )

;; When in vterm list only vterm buffers
(after! consult
  (defvar vterm-source
    (list :name     "vterm buffer"
          :category 'buffer
          :narrow   ?v
          :face     'consult-buffer
          :history  'buffer-name-history
          :state    #'consult--buffer-state
          :new
          (lambda (name)
            (with-current-buffer (get-buffer-create name)
              (insert "#+title: " name "\n\n")
              (vterm-mode)
              (consult--buffer-action (current-buffer))))
          :items
          (lambda ()
            (consult--buffer-query :mode 'vterm-mode :as #'consult--buffer-pair))))

  (add-to-list 'consult-buffer-sources 'vterm-source 'append)

  ;; ref: https://github.com/minad/consult/wiki#start-command-with-initial-narrowing
  (defvar consult-initial-narrow-per-mode-config
    '((vterm-mode . ((consult-buffer . ?v)))))

  (defun consult-initial-narrow ()
    "Narrow consult buffers differently for different major modes.

Allows consult to have initial narrowing for configurable buffer types
and consult command types, contained in
`consult-initial-narrow-per-mode-config'."
    (when minibuffer--original-buffer
      (when-let* ((original-mode (with-current-buffer minibuffer--original-buffer major-mode))
                  (mode-config (alist-get original-mode consult-initial-narrow-per-mode-config))
                  (command-prefix (alist-get this-command mode-config)))
        (setq-local unread-command-events (append unread-command-events (list command-prefix 32))))))

  (add-hook 'minibuffer-setup-hook #'consult-initial-narrow)
  )

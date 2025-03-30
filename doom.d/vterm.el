;;
;;
(setq prev-vterm-buffers '())

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



(defun my-next-window ()
  "Switch to other window or to next the vterm buffer in the same window."
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (let* (
             (buffers (vterm-buffers)) ;;(buffers-by-mode 'vterm-mode))
             (buf (or (car (cdr (memq (current-buffer) buffers))) (car buffers)))
             )
        (set-window-dedicated-p (selected-window) nil)
        ;;(message "%s" (buffer-name buf))
        (switch-to-buffer buf)
        (set-window-dedicated-p (selected-window) t)
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
        (set-window-dedicated-p (selected-window) nil)
        ;; (message "%s" (buffer-name buf))
        (switch-to-buffer buf)
        ;; (dolist (buf buffers)
        ;;   (with-current-buffer buf
        ;;     (message "%s" (buffer-name buf))))
        (set-window-dedicated-p (selected-window) t)
        )
    (other-window -1)))



(defun my-vterm-select-or-back ()
  ""
  (interactive)
  (if (eq major-mode 'vterm-mode)
      ;; if already in vterm return to previous window
      (my-switch-to-previous-window)

    ;; find first vterm window
    (let ((first-vterm-window (cl-find-if
                               (lambda (window)
                                 (with-current-buffer (window-buffer window) (eq major-mode 'vterm-mode)))
                               (window-list))))
      ;; select that window or create new
      (if first-vterm-window
          (select-window first-vterm-window)
        (+vterm/toggle nil)
        )
      )
    )
  )

(defun my-switch-to-previous-window ()
  "Switch to the previously active window."
  (interactive)
  (let ((win (get-mru-window t t t)))
    (unless win (error "Last window not found"))
    (let ((frame (window-frame win)))
      (select-frame-set-input-focus frame)
      (select-window win))))

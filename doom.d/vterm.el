;;
;;
(setq prev-vterm-buffers '())

(defun vterm-buffers ()
  (let* (
         (current (buffers-by-mode 'vterm-mode))
         (s_current (sort-buffers (append current nil)))
         (s_prev    (sort-buffers (append prev-vterm-buffers nil)))
         )
    (if (equal s_current s_prev)
        prev-vterm-buffers
      (setq prev-vterm-buffers current)
      current)
    )
  )

(defun sort-buffers (buffers)
  (sort buffers
        (lambda (a b)
          (string< (buffer-name a) (buffer-name b)))))


(defun buffers-by-mode (mode)
  (let ((filtered-buffers '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (eq major-mode mode)
          (push buf filtered-buffers))))
    (reverse filtered-buffers)))



(defun my-next-buffer-same-major-mode ()
  "Switch to the next buffer with the same major mode as the current buffer."
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (let* (
             (buffers (vterm-buffers)) ;;(buffers-by-mode 'vterm-mode))
             (buf (or (car (cdr (memq (current-buffer) buffers))) (car buffers)))
             )
        (set-window-dedicated-p (selected-window) nil)
        (message "%s" (buffer-name buf))
        (switch-to-buffer buf)
        (set-window-dedicated-p (selected-window) t)
        )
    (other-window 1)))

(defun my-previous-buffer-same-major-mode ()
  "Switch to the previous buffer with the same major mode as the current buffer."
  (interactive)
  (if (eq major-mode 'vterm-mode)
      (let* (
             (buffers (reverse (vterm-buffers)));;(buffers-by-mode 'vterm-mode)))
             (buf (or (car (cdr (memq (current-buffer) buffers))) (car buffers)))
             )
        (set-window-dedicated-p (selected-window) nil)
        ;;(message "----")
        (message "%s" (buffer-name buf))
        (switch-to-buffer buf)
        ;; (dolist (buf buffers)
        ;;   (with-current-buffer buf
        ;;     (message "%s" (buffer-name buf))))
        (set-window-dedicated-p (selected-window) t)
        )
    (other-window -1)))

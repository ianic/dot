;;
;; Inspired by: https://protesilaos.com/codelog/2023-06-26-emacs-file-dired-basics/
;;

;; Automatically hide the detailed listing when visiting a Dired
;; buffer.
;; ( - keybinding in dired mode
(add-hook 'dired-mode-hook #'dired-hide-details-mode)

;; When there are two Dired buffers side-by-side make Emacs
;; automatically suggest the other one as the target of copy or rename
;; operations.  Remember that you can always use M-p and M-n in the
;; minibuffer to cycle through the history, regardless of what this
;; does.  (The "dwim" stands for "Do What I Mean".)
(setq dired-dwim-target t)

;; Do not outright delete files.  Move them to the system trash
;; instead.  The `trashed' package can act on them in a Dired-like
;; fashion.  I use it and can recommend it to either restore (R) or
;; permanently delete (D) the files.
(setq delete-by-moving-to-trash t)

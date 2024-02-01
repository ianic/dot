(require 'exwm)
(require 'exwm-config)
;; removed example config because it uses ido  https://github.com/ch11ng/exwm/wiki/Configuration-Example
;; (exwm-config-example)

;; (require 'exwm-systemtray)
;; (exwm-systemtray-enable)
;; (setq exwm-systemtray-height 30)

(setq exwm-workspace-number 8)
(setq exwm-input-global-keys
      `(

        ;; Bind "s-&" to launch applications ('M-&' also works if the output
        ;; buffer does not bother you).
        ([?\s-&] . (lambda (command)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command command nil command)))

        ;;([?\s-!] . exwm-reset)

        ([?\s-9] . exwm-workspace-switch)
        ;;([?\s-w] . exwm-workspace-switch)
        ;;([?\s-c] . exwm-input-release-keyboard)
        ;;([?\s-H] . buf-move-left)
        ;;([?\s-L] . buf-move-right)
        ;; ([s-return] . vterm)
        ;; ([?\s-f] . (lambda ()
        ;;              (interactive)
        ;;              (start-process "" nil "firefox")))

        ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
        ([?\s- ]
         lambda
         (command)
         (interactive
          (list
           (read-shell-command "$ ")))
         (start-process-shell-command command nil command))
        ,@(mapcar (lambda (i)
                    `(,(kbd (format "M-s-%d" (+ i 1))) .
                      (lambda ()
                        (interactive)
                        (exwm-workspace-switch-create ,i))))
                  (number-sequence 0 8))))

(push ?\  exwm-input-prefix-keys)
(exwm-enable)


(defun exwm/workspace-next ()
  ""
  (interactive)
  (setq last (- (length exwm-workspace--list) 1))
  (setq next (+ 1 exwm-workspace-current-index))
  (if (> next last)
      (setq next 0)
    )
  (message "workspace %d/%d " next last)
  (exwm-workspace-switch next)
  )

(defun exwm/workspace-previous ()
  ""
  (interactive)
  (setq last (- (length exwm-workspace--list) 1))
  (setq next (- exwm-workspace-current-index 1))
  (if (< next 0)
      (setq next last)
    )
  (message "workspace %d/%d " next last)
  (exwm-workspace-switch next)
  )

;; setting dbus enironment for lauching applications
;; export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus
;; ref :https://github.com/systemd/systemd/issues/5247
(setenv "DBUS_SESSION_BUS_ADDRESS" (format "unix:path=%s/bus" (getenv "XDG_RUNTIME_DIR")))
(message "new value %s" (getenv "DBUS_SESSION_BUS_ADDRESS" ))
;; config new session
(start-process-shell-command "fix right alt" "*Messages*" "xmodmap -e 'clear mod5'; xmodmap -e 'keycode 108 = Alt_L'")
(start-process-shell-command "set key rate" "*Messages*" "xset r rate 300 30")

(message nil)

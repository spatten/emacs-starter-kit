(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

(setq load-path (cons  "/usr/local/Cellar/erlang/R14B03/lib/erlang/lib/tools-2.6.6.4/emacs" load-path))
      (setq erlang-root-dir "/usr/local/Cellar/erlang/R14B03/lib/erlang")
      (setq exec-path (cons "/usr/local/bin" exec-path))
      (require 'erlang-start)

(require 'haml-mode)

(setq standard-indent 2)

(mouse-wheel-mode t)

(global-linum-mode)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(require 'ruby-electric)
(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

(setq ido-use-filename-at-point nil)

(auto-fill-mode 0)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(markdown-command "/usr/local/bin/markdown")
 '(nxml-char-ref-display-glyph-flag nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Anonymous_Pro"))))
 '(nobreak-space ((((class color) (min-colors 88)) (:inherit escape-glyph :weight extra-light)))))

(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

;; Lisp-flavored Erlang
(add-to-list 'load-path "~/.emacs.d/vendor/lfe")
(require 'lfe-mode)
(add-to-list 'auto-mode-alist '("\.lfe$" . lfe-mode))
(require 'lfe-start)

(add-to-list 'load-path "~/.emacs.d/vendor/mustache-mode.el")
(setq auto-mode-alist (cons '("\\.tpl$" . tpl-mode) auto-mode-alist))
(autoload 'tpl-mode "tpl-mode" "Major mode for editing CTemplate files." t)
;; (require 'mustache)

 ;; from http://www.enigmacurry.com/2008/12/26/emacs-ansi-term-tricks/
(require 'term)
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))
(global-set-key (kbd "<f2>") 'visit-ansi-term)

;; Haskell!!
;; You can only pick one of the indentation modes
(load "haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; settings help from http://stackoverflow.com/questions/293761/how-do-i-make-emacs-show-blank-spaces
;; make whitespace-mode use just basic coloring
(setq whitespace-style (quote (face spaces newline tabs space-mark tab-mark newline-mark)))
;; http://pastebin.com/ieAcvLTJ
 (make-face 'whitespace-light-face)
  (set-face-attribute 'whitespace-light-face nil
                      :background nil
                      :foreground "#f0f0f0"
                      :weight 'ultra-light)
  (setq whitespace-space 'whitespace-light-face)
;; (setq whitespace-hspace 'underline)
;; (setq whitespace-display-mappings
;;           '((space-mark   ?\    [?\xB7]     [?.])	; space
;;             (space-mark   ?\xA0 [?\xA4]     [?_])	; hard space
;;             (newline-mark ?\n   [?\xB6 ?\n] [?$ ?\n])	; end-of-line
;;             ))
; turn on whitespace mode globally
(global-whitespace-mode 1)

;; SLIME (lisp REPL)
(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
(setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-fancy))

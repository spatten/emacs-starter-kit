(setq initial-scratch-message "")
(setq initial-major-mode 'text-mode)

(load "~/.emacs.d/movelines.el")

(add-to-list 'custom-theme-load-path "~/.emacs.d/vendor/emacs-color-theme-solarized")
(load-theme 'solarized-light t)


(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(require 'textmate)
(textmate-mode)

;; (setq load-path (cons  "/usr/local/Cellar/erlang/R14B03/lib/erlang/lib/tools-2.6.6.4/emacs" load-path))
;;       (setq erlang-root-dir "/usr/local/Cellar/erlang/R14B03/lib/erlang")
;;       (setq exec-path (cons "/usr/local/bin" exec-path))
;;       (require 'erlang-start)

(require 'haml-mode)

(setq standard-indent 2)

(mouse-wheel-mode t)

(global-linum-mode)
;; format for line numbers
(setq linum-format "%3d")


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
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(markdown-command "/Users/spatten/.rbenv/shims/kramdown")
 '(nxml-char-ref-display-glyph-flag nil))

(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)

(set-face-attribute 'default nil :font "Anonymous Pro")
;; Use Lorem-ipsum like this:
;; M-5 M-x Lorem-ipsum-insert-paragraphs
;; This will insert 5 paras of Lorem Ipsum text
(add-to-list 'load-path "~/.emacs.d/vendor")
(require 'lorem-ipsum)

;; Lisp-flavored Erlang
;; (add-to-list 'load-path "~/.emacs.d/vendor/lfe")
;; (require 'lfe-mode)
;; (add-to-list 'auto-mode-alist '("\.lfe$" . lfe-mode))
;; (require 'lfe-start)

(add-to-list 'load-path "~/.emacs.d/vendor/mustache-mode.el")
(setq auto-mode-alist (cons '("\\.tpl$" . tpl-mode) auto-mode-alist))
(autoload 'tpl-mode "tpl-mode" "Major mode for editing CTemplate files." t)
;; (require 'mustache)

;; settings help from http://stackoverflow.com/questions/293761/how-do-i-make-emacs-show-blank-spaces
;; make whitespace-mode use just basic coloring
;; (setq whitespace-style (quote (face spaces newline tabs space-mark tab-mark newline-mark)))
;; http://pastebin.com/ieAcvLTJ
 (make-face 'whitespace-light-face)
  (set-face-attribute 'whitespace-light-face nil
                      :background nil
                      :foreground "#909090"
                      :weight 'ultra-light)
(setq whitespace-trailing 'whitespace-light-face)
(setq trailing-whitespace 'whitespace-light-face)
(setq show-trailing-whitespace 1)
;; (setq whitespace-space 'whitespace-light-face)  
; make whitespace-mode use just basic coloring
(setq whitespace-style (quote
  ( tabs newline space-mark tab-mark newline-mark face)))
(setq whitespace-hspace 'underline)    
(setq whitespace-display-mappings
          '((space-mark   ?\    [? ]     [? ])	; space
            (space-mark   ?\xA0 [?\xA4]     [? ])	; hard space
            (trailing-space-mark   ?\    [?\xB7]     [?.])	; trailing space
            (newline-mark ?\n   [?\xB6 ?\n] [?$ ?\n])	; end-of-line
            ))   
;; ; turn on whitespace mode globally
(global-whitespace-mode 1)   
;; 
;; ;; SLIME (lisp REPL)
;; (add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
;; (setq inferior-lisp-program "/usr/local/bin/sbcl") ; your Lisp system
;; (require 'slime)
;; (slime-setup '(slime-fancy))
;; 
;; (load "my_methods")
;; 
;; ;; set scheme interpreter. Run with "M-x run-scheme"
;; ;; Then, you can send s-expressions to the interpreter from another window with
;; ;; C-x C-e (put your cursor at the end of an S-expression then do this)
;; ;; C-c C-r (send the highlighted region to the scheme interpreter)
;; ;; from http://community.schemewiki.org/?emacs-tutorial
;; (setq scheme-program-name "gsi -:d-")
;; ;; (setq scheme-program-name "mzscheme")
;; 
(server-start)
;; 
;; ;; http://nileshk.com/2009/06/13/prompt-before-closing-emacs.html
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))
;; 
;; ;; Use PCRE regexes instead of emacs regexes
(load "~/.emacs.d/vendor/pcre2el/pcre2el.el")
(global-set-key [(meta %)] 'pcre-query-replace-regexp)
(global-set-key [(ctrl meta %)] 'pcre-query-replace-regexp)
;; 
;; ;; disable minimize window
(global-unset-key "\C-x\C-z")
;; (setq mac-command-modifier 'super) ; sets the Command key as Super, but this is done already, so only left if I move to Unix or something crazy like that.
(global-unset-key (kbd "s-m"))
;; 
;; ;; from http://kieranhealy.org/esk/starter-kit-bindings.html
;; ;; resizing 'windows' (i.e., inside the frame)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)  
;; 

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

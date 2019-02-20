;; Aquamacs location   /Users/emil/Library/Application Support/Aquamacs Emacs
;; ____________________________________________________________________________
;; Aquamacs custom-file warning:
;; Warning: After loading this .emacs file, Aquamacs will also load
;; customizations from `custom-file' (customizations.el). Any settings there
;; will override those made here.
;; Consider moving your startup settings to the Preferences.el file, which
;; is loaded after `custom-file':
;; ~/Library/Preferences/Aquamacs Emacs/Preferences
;; _____________________________________________________________________________

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq custom-file "~/.emacs.d/personal/custom.el")
(if (featurep 'aquamacs)
       ;; Aquamacs customization.
    (setq custom-file "~/.emacs.d/personal/aquamacs-custom.el")
  ;; (require 'tls)
  (with-eval-after-load 'gnutls
    (push "/usr/local/etc/libressl/cert.pem" gnutls-trustfiles))
  )

(require 'gnutls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/libressl/cert.pem")

(setq tls-program
      ;; Defaults:
      ;; '("gnutls-cli --insecure -p %p %h"
      ;;   "gnutls-cli --insecure -p %p %h --protocols ssl3"
      ;;   "openssl s_client -connect %h:%p -no_ssl2 -ign_eof")
      '("gnutls-cli -p %p %h"
        "openssl s_client -connect %h:%p -no_ssl2 -no_ssl3 -ign_eof"))

(setq exec-path (cons "/opt/local/bin:/usr/local/mysql/bin:/opt/local/sbin" exec-path))
(setenv "PATH" (concat "/opt/local/bin:" (getenv "PATH")))
;; Emacs TLS Fix

(setq message-log-max t)
;;(require 'cl)
(setq visible-bell t)
;; (set-specifier default-toolbar-visible-p nil)
;;(set-face-font 'default "Monaco:Regular:12")
(setq default-toolbar-visible-p nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq line-number-mode t)
(setq column-number-mode t)
(tool-bar-mode 0)
(scroll-bar-mode -1)
;; disable select tabs by mode
;; (setq buffers-tab-filter-functions nil)

;; transparency
;; (modify-frame-parameters (selected-frame) '((alpha . 85)))

;; additional load path
(setq load-path (append '("~/.emacs.d") load-path))
;; Environment
;; tabs as spaces
(setq default-indent-tabs-mode nil)
(setq tab-width 2
      indent-tabs-mode nil)             ; tab = 2 spaces
(setq require-final-newline t)          ; always terminate last line in file
(setq default-major-mode 'text-mode)    ; default mode is text mode
(setq next-screen-context-lines 1)      ; # of lines of overlap when scrolling
(setq auto-save-interval 300)           ; autosave every N characters typed
(setq default-fill-column 77)           ; the column beyond which do word wrap
(setq scroll-preserve-screen-position t) ; make pgup/dn remember current line
(setq next-line-add-newlines nil)       ; don't scroll past end of file
(setq ewd-kp-usage 'num)                ; keypad numbers are numbers by default
;; (global-auto-revert-mode 1)             ; autorevert buffers if files change
(if (eq window-system 'w32)
    (setq w32-enable-italics t))        ; enable italics on Windows
(setq transient-mark-mode t)
(setq-default kill-whole-line t)        ; Ctrl-k kills whole line if at col 0
(setq search-highlight t)
(setq query-replace-highlight t)
;; Paren matching
;; (setq show-paren-mode t)                ; highlight matching parens, etc
;; (setq show-paren-style 'parenthesis)    ; highlight character, not expression
;; (setq blink-matching-paren-distance 51200) ; distance to match paren as
;; (setq cursor-in-non-selected-windows nil)
(blink-cursor-mode 0)
(setq x-select-enable-clipboard t)
(delete-selection-mode t)
;; (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(setq dired-recursive-deletes t)
(setq show-trailing-whitespace nil)

(prefer-coding-system 'utf-8)
(modify-coding-system-alist 'file ".*" 'utf-8)

(setq default-toolbar-visible-p nil)

(put 'downcase-region 'disabled nil)

(setq confirm-nonexistent-file-or-buffer nil)

(setq package-check-signature nil)

(setq interprogram-paste-function 'x-selection-value)

      ;; reduce the frequency of garbage(define-key global-map (kbd "M-g") 'goto-line)
(define-key global-map (kbd "M-n") 'aquamacs-page-down)
(define-key global-map (kbd "M-p") 'aquamacs-page-up)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(defalias 'fnd 'find-name-dired)
(defalias 'rr 'replace-regexp)
(defalias 'rs 'replace-string)
(defalias 'rrd 'dired-do-query-replace-regexp)

(defun find-ag (dir search-term)
  "Run an ag search with SEARCH-TERM in the directory.

With an optional prefix argument ARG SEARCH-TERM is interpreted as a
regular expression."
  (interactive "DFind-ag (directory): \nsFind-ag (ag search-term): ")
  (if (fboundp 'ag-regexp)
      (let ((ag-command (if current-prefix-arg 'ag-regexp 'ag))
            ;; reset the prefix arg, otherwise it will affect the ag-command
            (current-prefix-arg nil))
        (funcall ag-command search-term dir))
    (error "Ag is not available")))

(defalias 'fgd 'find-ag)

(define-key isearch-mode-map [(control h)] 'isearch-mode-help)

(setq debug-on-error t)
(setq url-debug 1)
;; reload emacs config
(defun reload-emacs ()
  "reload my .emacs.el file"
  (interactive)
  (load-file "~/.emacs")
  )


;; (toggle-debug-on-error)

;; prelude initialization
(load "prelude-init.el")
;; (load "check-packages.el")

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;
;; Always load newest byte code
(setq load-prefer-newer t)

;; prelude customizations : whitespace etc
(setq prelude-whitespace nil)
(setq prelude-clean-whitespace-on-save nil)
(remove-hook 'prog-mode 'flycheck-mode)
(global-flycheck-mode -1)
(setq prelude-flyspell nil)
(setq prelude-guru nil)

(use-package solarized-theme)

(use-package powerline)

(use-package smart-mode-line-powerline-theme
  :ensure t
  :after powerline
  :after smart-mode-line
  :config
  (sml/setup)
  (sml/apply-theme 'powerline)
  )

(use-package projectile-rails :ensure t :defer t
  :config
  (add-hook 'projectile-mode-hook 'projectile-rails-on))

(defun prelude-prog-mode-defaults ()
  "Default coding hook, useful with any programming language."
  (smartparens-mode -1)
  (prelude-local-comment-auto-fill)
  (projectile-rails-on)
  )
  ;;(counsel-projectile-mode))
  ;;  (counsel-projectile-mode))
;;  (prelude-font-lock-comment-annotations))

(setq prelude-prog-mode-hook 'prelude-prog-mode-defaults)

(add-hook 'prog-mode-hook (lambda ()
                            (run-hooks 'prelude-prog-mode-hook)))

(custom-set-variables '(coffee-tab-width 2))

;;(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; Javascript
(add-to-list 'auto-mode-alist '(".*\.js\'" . rjsx-mode))

(setq auto-mode-alist  (cons '("\\.rjs$" . ruby-mode) auto-mode-alist))


;; helm
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)

(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-quick-update                     t ; do not display invisible candidates
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(global-set-key (kbd "C-x C-r") #'helm-recentf)
(define-key prelude-mode-map (kbd "C-c i") 'helm-imenu-anywhere)
;; end helm

(use-package hippie-exp)
(setq hippie-expand-try-functions-list
'(yas/hippie-try-expand
 try-expand-dabbrev
 try-expand-dabbrev-all-buffers
 try-expand-dabbrev-from-kill
 try-expand-all-abbrevs
 try-expand-list
 try-expand-line
 try-complete-lisp-symbol-partially
 try-complete-lisp-symbol))

;; Save the occur result to a separate buffer with C-x C-s (helm-moccur-run-save-buffer)
;; Change to wgrep mode with C-c C-p (wgrep-change-to-wgrep-mode)
;; Edit the buffer like a normal buffer
;; Apply the changes with C-x C-s (wgrep-finish-edit)
;; By the way, the above is documented via C-h m (helm-help).
(use-package wgrep-helm)
;;;
;; Smart Tab from http://www.emacswiki.org/cgi-bin/wiki/TabCompletion
(use-package smart-tab
  :defer t
  :diminish ""
  :init (global-smart-tab-mode 1)
  :config
  (progn
    (add-to-list 'smart-tab-disabled-major-modes 'mu4e-compose-mode)
    (add-to-list 'smart-tab-disabled-major-modes 'erc-mode)
    (add-to-list 'smart-tab-disabled-major-modes 'shell-mode)))
;;(smart-tab-using-hippie-expand t)

(require 'server)
(server-start)

;; Insertion of Dates.
(defun insert-date-string ()
  "Insert a nicely formated date string."
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

;; C-c i calls insert-date-string
;; (global-set-key (kbd "C-c i") 'insert-date-string)


;;compute the length of the marked region
(defun region-length ()
  "length of a region"
  (interactive)
  (message (format "%d" (- (region-end) (region-beginning)))))


;;tags
(defun find-tag-at-point ()
  "*Find tag whose name contains TAGNAME.
  Identical to `find-tag' but does not prompt for tag when called
  interactively;  instead, uses tag around or before point."
    (interactive)
      (find-tag (if current-prefix-arg
                    (find-tag-tag "Find tag: "))
                (find-tag (find-tag-default))))

(global-set-key [f2] 'find-tag-at-point)

;; mysql
;;(require 'mysql-utils)


;; Org-mode settings
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; lisp interaction mode for a scratch buffer
(with-current-buffer "*scratch*"  (lisp-interaction-mode))

;; shell ansi coloring
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(defun clear-shell ()
   (interactive)
   (let ((comint-buffer-maximum-size 0))
     (comint-truncate-buffer)))
(add-hook 'shell-mode-hook (lambda ()
			     (define-key osx-key-mode-map [A-k] 'clear-shell)
                            ))

(put 'dired-find-alternate-file 'disabled nil)

(put 'scroll-left 'disabled nil)

;; http://emacs-fu.blogspot.com/2009/11/copying-lines-without-slecting-them.html
;; copying lines without selecting them

(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
  "Copied line") (list (line-beginning-position) (line-beginning-position
  2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))


;; http://emacs-fu.blogspot.com/2010/04/navigating-kill-ring.html
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))

;; C-cy - also consider M-y
;; (global-set-key "\C-cy" '(lambda ()
;;    (interactive)
;;    (popup-menu 'yank-menu)))

(put 'narrow-to-region 'disabled nil)


(defun bf-pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Ah, much better!"))

(add-hook 'nxml-mode-hook (lambda ()
                            (local-set-key "\C-\M-\\" 'bf-pretty-print-xml-region)
                            ))
;; disable html auto carriag return
(add-hook 'html-mode-hook 'turn-off-auto-fill)


(global-set-key (kbd "C-M-=") 'er/contract-region)


(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

(global-set-key "\C-co" 'switch-to-minibuffer) ;; Bind to `C-c o'


;; http://irreal.org/blog/?p=1946&utm_source=feedly
(defadvice move-beginning-of-line (around smarter-bol activate)
  ;; Move to requested line if needed.
  (let ((arg (or (ad-get-arg 0) 1)))
    (when (/= arg 1)
      (forward-line (1- arg))))
  ;; Move to indentation on first call, then to actual BOL on second.
  (let ((pos (point)))
    (back-to-indentation)
    (when (= pos (point))
      ad-do-it)))


(defun copy-buffer-file-name-as-kill (choice)
  "Copy the buffer-file-name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
        (name (if (eq major-mode 'dired-mode)
                  (dired-get-filename)
                (or (buffer-file-name) ""))))
    (cond ((eq choice ?f)
           (setq new-kill-string name))
          ((eq choice ?d)
           (setq new-kill-string (file-name-directory name)))
          ((eq choice ?n)
           (setq new-kill-string (file-name-nondirectory name)))
          (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))


;; wgrep-ag
(use-package wgrep-ag)
(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
;;(define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode)

;; Usage:

;; You can edit the text in the grep buffer after typing C-c C-p. After that the changed text is highlighted. The following keybindings are ;;;;;def

;; C-c C-e: Apply the changes to file buffers.
;; C-c C-u: All changes are unmarked and ignored.
;; C-c C-d: Mark as delete to current line (including newline).
;; C-c C-r: Remove the changes in the region (these changes are not applied to the files. Of course, the remaining changes can still be applied to the files.)
;; C-c C-p: Toggle read-only area.
;; C-c C-k: Discard all changes and exit.
;; C-x C-q: Exit wgrep mode.
;; https://github.com/mhayashi1120/Emacs-wgrep#usage

;; url utils
(require 'url-util)

;; Swiper/Ivy
;; (use-package ivy
;;   :ensure t
;;   :diminish ivy-mode
;;   :config
;;   (setq ivy-use-virtual-buffers t)
;;   (ivy-mode 1)
;;   (bind-key "C-c C-r" 'ivy-resume))

(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)

(use-package swiper-helm)

;;advise swiper to recenter on exit
(defun bjm-swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter)
  )
(advice-add 'swiper :after #'bjm-swiper-recenter)
;; Use monospaced font faces in current buffer
;; (defun buffer-face-mode-fixed ()
;;   "Sets a fixed width (monospace) font in current buffer"
;;   (interactive)
;;   (setq buffer-face-mode-face '(:family "Consolas" :height 100))
;;   (buffer-face-mode))

;;(require 'back-button)
(use-package back-button)
(back-button-mode 1)

;; https://stumbles.id.au/auto-starting-emacs-smerge-mode-for-git.html
(defun vc-git-find-file-hook ()
  (when (save-excursion
          (goto-char (point-min))
          (re-search-forward "^<<<<<<< " nil t))
    (smerge-start-session)))


;;; Based on http://arnab-deka.com/posts/2012/09/emacs-change-fonts-dynamically-based-on-screen-resolution/
(defun fontify-frame (&optional frame)
  (interactive)
  (let ((target (or frame (window-frame))))
    (if window-system
        (if (or
             (> (frame-pixel-height) 2000)
             (> (frame-pixel-width) 2000))
            (set-frame-parameter target 'font "Menlo 19")
          (set-frame-parameter target 'font "Menlo 14")))))

;;; Fontify current frame (so that it happens on startup; may be unnecessary if you use focus-in-hook)
(fontify-frame)

;;; Only in Emacs 24.4 (currently available as a pretest)
                                        ; see http://emacsredux.com/blog/2014/03/22/a-peek-at-emacs-24-dot-4-focus-hooks/
(add-hook 'focus-in-hook 'fontify-frame)

;;; For older Emacs versions - instead of changing on focus, this will change when a frame is created
                                        ;(push 'fontify-frame after-make-frame-functions)
(eval-after-load "sql"
  '(load-library "sql-indent"))

(eval-after-load 'url-http'
  '(defun Buffer-menu-mark ()
     "do nothing"
     (interactive)))

;; http://bryan-murdock.blogspot.ca/2018/03/fixing-xref-find-references.html
(define-key global-map [remap xref-find-references] 'ag-project)
(setq ag-arguments (list "--word-regexp" "--smart-case"))

;; GoLang
(defun my-go-mode-hook ()
  (setq tab-width 2 indent-tabs-mode 1)
                                        ; eldoc shows the signature of the function at point in the status bar.
  (go-eldoc-setup)
  (local-set-key (kbd "M-.") #'godef-jump)
  (add-hook 'before-save-hook 'gofmt-before-save)

                                        ; extra keybindings from https://github.com/bbatsov/prelude/blob/master/modules/prelude-go.el
  (let ((map go-mode-map))
    (define-key map (kbd "C-c a") 'go-test-current-project) ;; current package, really
    (define-key map (kbd "C-c m") 'go-test-current-file)
    (define-key map (kbd "C-c .") 'go-test-current-test)
    (define-key map (kbd "C-c b") 'go-run)))


(add-hook 'go-mode-hook 'my-go-mode-hook)

(use-package dumb-jump
  :config (setq dumb-jump-selector 'helm)
  :ensure)
(dumb-jump-mode)

(use-package flymd)
;; https://github.com/mola-T/flymd/blob/master/browser.md
(defun my-flymd-browser-function (url)
  (let ((process-environment (browse-url-process-environment)))
    (apply 'start-process
           (concat "firefox " url)
           nil
           "/usr/bin/open"
           (list "-a" "firefox" url))))
(setq flymd-browser-open-function 'my-flymd-browser-function)

(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)


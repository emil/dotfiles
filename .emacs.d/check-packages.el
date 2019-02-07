(setq package-list
      '(0blayout ace-window avy ag s dash anaconda-mode f dash s s dash pythonic f dash s s dash anzu avy back-button pcache persistent-soft list-utils pcache list-utils ucs-utils list-utils pcache persistent-soft list-utils pcache smartrep nav-flash beacon seq browse-kill-ring cider seq spinner queue pkg-info epl clojure-mode clojure-mode company-inf-ruby inf-ruby company company-shell dash company seq diff-hl diminish discover-my-major makey elisp-slime-nav elixir-mode pkg-info epl popup s dash company exec-path-from-shell expand-region flx-ido flx flycheck seq let-alist pkg-info epl dash geiser gist gh marshal ht dash logito pcache dash s git-timemachine gitconfig-mode gitignore-mode god-mode grizzl guru-mode helm-ag helm helm-core async popup async helm-ag-r helm helm-core async popup async helm-anything anything helm helm-core async popup async helm-cmd-t helm-descbinds helm helm-core async popup async helm-describe-modes helm helm-core async popup async helm-dictionary helm helm-core async popup async helm-dired-recent-dirs helm helm-core async popup async helm-dirset s helm helm-core async popup async f dash s helm-fuzzy-find helm helm-core async popup async helm-git helm-helm-commands helm helm-core async popup async helm-package helm helm-core async popup async helm-projectile projectile pkg-info epl helm helm-core async popup async helm-rails inflections helm helm-core async popup async helm-themes helm-core async ido-ubiquitous ido-completing-read+ imenu-anywhere js2-mode json-mode json-snatcher json-reformat json-reformat json-snatcher let-alist logito magit magit-popup dash async git-commit with-editor dash async dash with-editor dash async dash async magit-popup dash async makey markdown-mode+ markdown-mode markdown-preview-eww markdown-preview-mode markdown-mode websocket marshal ht dash merlin move-text nav-flash operate-on-number ov projectile-direnv projectile pkg-info epl dash s projectile-rails rake dash f dash s f dash s inf-ruby inflections projectile pkg-info epl pythonic f dash s s dash queue rainbow-delimiters rainbow-mode rake dash f dash s restclient-helm helm helm-core async popup async restclient restclient-test restclient ruby-refactor ruby-tools s scala-mode2 seq smart-mode-line rich-minority smart-tab dash smartrep smex sml-mode spinner swiper-helm helm helm-core async popup async swiper ivy tuareg caml ucs-utils list-utils pcache persistent-soft list-utils pcache undo-tree vkill volatile-highlights web-mode websocket wgrep-ag wgrep wgrep-helm wgrep which-key with-editor dash async yaml-mode yari zenburn-theme zop-to-char))

                                        ; activate all the packages (in particular autoloads)
(package-initialize)

                                        ; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

                                        ; install the missing packages
;; (dolist (package package-list)
;;   (unless (package-installed-p package)
;;     (package-install package)))
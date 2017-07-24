
;; cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;; Code:
;; 起動時のメッセージ設定
(setq inhibit-startup-message t)
;; 言語設定
(set-default-coding-systems 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix)
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; グローバルなキーバインド
(define-key global-map "\C-h" 'delete-backward-char)
(define-key global-map "\M-?" 'help-for-help)
(define-key global-map "\C-z" 'undo)

;; 外部で編集された場合でも自動で再読み込みする
(global-auto-revert-mode 1)

;; 行末の空白をハイライト
(setq-default show-trailing-whitespace t)
;; 保存時に行末の空白を自動削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; 自動セーブとバックアップファイルの作成をしない
(setq make-backup-files nil)
(setq auto-save-default nil)

;;メニューバー非表示
(menu-bar-mode 0)

;; defaultのインデント設定
(setq-default tab-width 2 indent-tabs-mode nil)

;; font
(set-face-attribute 'default nil
                    :family "Momaco"
                    :height 120)

;; multi-term
(require 'multi-term)
(setq multi-term-program shell-file-name)
(add-to-list 'term-unbind-key-list '"M-x")

;; elisp-mode hook
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

;; go-mode alist
(setq auto-mode-alist
      (cons (cons "\\.go$" 'go-mode) auto-mode-alist))

(add-hook 'go-mode-hook
          '(lambda()
             (setq indent-tabs-mode t)
             (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
             (local-set-key (kbd "C-c i") 'go-goto-imports)
             (local-set-key (kbd "C-c d") 'godoc)
             (hs-minor-mode 1)))

;; ruby-mode alist
(setq auto-mode-alist
      (cons (cons "\\.rb$" 'ruby-mode) auto-mode-alist))
(require 'ruby-electric nil t)
(setq ruby-insert-encoding-magic-comment nil)
(add-hook 'ruby-mode-hook
          '(lambda()
             (hs-minor-mode 1)))

;; terraform-mode alist
(setq auto-mode-alist
      (cons (cons "\\.tf$" 'terraform-mode) auto-mode-alist))

;; yaml-mode alist
(setq auto-mode-alist
      (cons (cons "\\.yml$" 'yaml-mode) auto-mode-alist))

;; perl-mode alist
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist
      (cons (cons "\\.t$" 'cperl-mode) auto-mode-alist))
(add-hook 'cperl-mode-hook
          '(lambda()
             (hs-minor-mode 1)
             (setq cperl-indent-level 4)))

;; coffee-mode alist
(setq auto-mode-alist
      (cons (cons "\\.coffee$" 'coffee-mode) auto-mode-alist))

;; web-mode alist
;; web-mode-hook
(setq auto-mode-alist
      (cons (cons "\\.erb$" 'web-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons (cons "\\.tx$" 'web-mode) auto-mode-alist))
(add-hook 'web-mode-hook
          '(lambda ()
             (electric-indent-local-mode -1)
             (setq web-mode-code-indent-offset 2)
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             ))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; ag
(require 'ag)

(require 'auto-complete-config)
(global-auto-complete-mode t)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; 範囲選択時の文字数と行数の表示
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ""))

(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))

(define-key global-map (kbd "C-\\") 'hs-toggle-hiding)

;; smart-mode-line
(require 'smart-mode-line)
(setq sml/theme 'respectful)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(put 'upcase-region 'disabled nil)

;;cloudformation-mode
(require 'json-mode)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.template$" . json-mode))

;; C-iで括弧の中身削除
;;(require 'misc)
;;(define-key global-map "\C-i" '(lambda ()
;;                                 (interactive)
;;                                 (goto-char (+ (point) 1))
;;                                 (zap-up-to-char 1 ?) )))

(provide 'init)
;;; init.el ends here

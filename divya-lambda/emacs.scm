;; Emacs builds

(define-module
  (divya-lambda emacs)
  #:use-module
  (guix packages)
  #:use-module
  (guix utils)
  #:use-module
  (guix gexp)
  #:use-module
  (guix git-download)
  #:use-module
  (guix download)

  #:use-module
  (gnu packages xorg)
  #:use-module
  (gnu packages emacs)
  #:use-module
  (gnu packages gtk))


;; Updated from emacs-master channel:
;; https://codeberg.org/akib/guix-channel-emacs-master/src/branch/master/emacs-master.scm

;;; !!! EMACS COMMIT AND HASH BEGIN !!!
(define emacs-master-commit "ab3888515694f89a24f64e94292c578af86eeaee")
(define emacs-master-time "1735225936")
(define emacs-master-hash "0pa13ajj7zfwjiv2g4psh3vknxw8kna55178lfk3m1xa6ycxfc07")
;;; !!! EMACS COMMIT AND HASH END !!!

(define-public emacs-master-minimal
  (package
    (inherit emacs-next-minimal)
    (name "emacs-master-minimal")
    (version (git-version "31.0.50" emacs-master-time emacs-master-commit))
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://git.savannah.gnu.org/cgit/emacs.git/snapshot/emacs-"
             emacs-master-commit ".tar.gz"))
       (sha256 (base32 emacs-master-hash))
       (patches (origin-patches (package-source emacs-next-minimal)))))))

(define* (emacs->emacs-master emacs #:optional name #:key
                              (version (package-version emacs-master-minimal))
                              (source (package-source emacs-master-minimal)))
  (package
    (inherit emacs)
    (name (or name
              (and (string-prefix? "emacs" (package-name emacs))
                   (string-append "emacs-master"
                                  (string-drop (package-name emacs)
                                               (string-length "emacs"))))))
    (version version)
    (source source)
    (arguments
     (substitute-keyword-arguments (package-arguments emacs)
       ((#:phases phases)
        #~(modify-phases #$phases
	    (delete 'validate-comp-integrity)
	    (replace 'patch-program-file-names
	      (lambda* (#:key inputs #:allow-other-keys)
              ;; Substitute "sh" command.
              (substitute* '("src/callproc.c"
                             "lisp/term.el"
                             "lisp/htmlfontify.el"
                             "lisp/mail/feedmail.el"
                             "lisp/obsolete/pgg-pgp.el"
                             "lisp/obsolete/pgg-pgp5.el"
                             ;; "lisp/obsolete/terminal.el"
                             "lisp/org/ob-eval.el"
                             "lisp/textmodes/artist.el"
                             "lisp/progmodes/sh-script.el"
                             "lisp/textmodes/artist.el"
                             "lisp/htmlfontify.el"
                             "lisp/term.el")
                (("\"/bin/sh\"")
                 (format #f "~s" (search-input-file inputs "bin/sh"))))
              (substitute* '("lisp/gnus/mm-uu.el"
                             "lisp/gnus/nnrss.el"
                             "lisp/mail/blessmail.el")
                (("\"#!/bin/sh\\\n\"")
                 (format #f "\"#!~a~%\"" (search-input-file inputs "bin/sh"))))
              (substitute* '("lisp/jka-compr.el"
                             "lisp/man.el")
                (("\"sh\"")
                 (format #f "~s" (search-input-file inputs "bin/sh"))))

              ;; Substitute "awk" command.
              (substitute* '("lisp/gnus/nnspool.el"
                             "lisp/org/ob-awk.el"
                             "lisp/man.el")
                (("\"awk\"")
                 (format #f "~s" (search-input-file inputs "bin/awk"))))

              ;; Substitute "find" command.
              (substitute* '("lisp/gnus/gnus-search.el"
                             "lisp/obsolete/nnir.el"
                             "lisp/progmodes/executable.el"
                             "lisp/progmodes/grep.el"
                             "lisp/filecache.el"
                             "lisp/ldefs-boot.el"
                             "lisp/mpc.el")
                (("\"find\"")
                 (format #f "~s" (search-input-file inputs "bin/find"))))

              ;; Substitute "sed" command.
              (substitute* "lisp/org/ob-sed.el"
                (("org-babel-sed-command \"sed\"")
                 (format #f "org-babel-sed-command ~s"
                         (search-input-file inputs "bin/sed"))))
              (substitute* "lisp/man.el"
                (("Man-sed-command \"sed\"")
                 (format #f "Man-sed-command ~s"
                         (search-input-file inputs "bin/sed"))))

              (substitute* "lisp/doc-view.el"
                (("\"(gs|dvipdf|ps2pdf|pdftotext)\"" all what)
                 (let ((replacement (false-if-exception
                                     (search-input-file
                                      inputs
                                      (string-append "/bin/" what)))))
                   (if replacement
                       (string-append "\"" replacement "\"")
                       all))))
              ;; match ".gvfs-fuse-daemon-real" and ".gvfsd-fuse-real"
              ;; respectively when looking for GVFS processes.
              (substitute* "lisp/net/tramp-gvfs.el"
                (("\\(tramp-compat-process-running-p \"(.*)\"\\)" all process)
                 (format #f "(or ~a (tramp-compat-process-running-p ~s))"
                         all (string-append "." process "-real"))))))))))))


(define-public emacs-lucid
  (package/inherit emacs-no-x
    (name "emacs-lucid")
    (synopsis
     "The extensible, customizable, self-documenting text editor (with Lucid toolkit)")
    (inputs (modify-inputs (package-inputs emacs)
              (delete gtk+)
	      (prepend libxaw)))
    (arguments
     (substitute-keyword-arguments
         (package-arguments emacs-no-x)
       ((#:configure-flags flags #~'())
        #~(cons "--with-x-toolkit=lucid"
                #$flags))))))

(define-public emacs-master-lucid
  (emacs->emacs-master emacs-lucid))


emacs-master

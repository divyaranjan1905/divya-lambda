;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2024 Divya R. Pattanaik <divya@subvertising.org>
;;;
;;; This file is not part of GNU Guix
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.

;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.

;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;
;;; Divya’s Emacs builds for Guix

(define-module (divya-lambda emacs)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix download)

  #:use-module (gnu packages xorg)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gtk))

;; Updated from emacs-master channel:
;; https://codeberg.org/akib/guix-channel-emacs-master/src/branch/master/emacs-master.scm

;;; !!! EMACS COMMIT AND HASH BEGIN !!!
(define emacs-master-commit
  "be8a7c9c882540dd7267f9046166cb680f10fd9d")
(define emacs-master-time
  "1740879684")
(define emacs-master-hash
  "1716hjm52a20945m8mpzi812pcpwnjq0c0c2y2y81i3lxx03p1dm")
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
       (sha256
        (base32 emacs-master-hash))
       (patches (origin-patches (package-source emacs-next-minimal)))))))

(define* (emacs->emacs-master emacs
                              #:optional name
                              #:key (version (package-version
                                              emacs-master-minimal))
                              (source (package-source emacs-master-minimal)))
  (package
    (inherit emacs)
    (name (or name
              (and (string-prefix? "emacs"
                                   (package-name emacs))
                   (string-append "emacs-master"
                                  (string-drop (package-name emacs)
                                               (string-length "emacs"))))))
    (version version)
    (source
     source)
    (arguments
     (substitute-keyword-arguments (package-arguments emacs)
       ((#:phases phases)
        #~(modify-phases #$phases
            (delete 'validate-comp-integrity)
            (replace 'patch-program-file-names
              (lambda* (#:key inputs #:allow-other-keys)
                ;; Substitute "sh" command.
                (substitute* '("src/callproc.c" "lisp/term.el"
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
                   (format #f "~s"
                           (search-input-file inputs "bin/sh"))))
                (substitute* '("lisp/gnus/mm-uu.el" "lisp/gnus/nnrss.el"
                               "lisp/mail/blessmail.el")
                  (("\"#!/bin/sh\\\n\"")
                   (format #f "\"#!~a~%\""
                           (search-input-file inputs "bin/sh"))))
                (substitute* '("lisp/jka-compr.el" "lisp/man.el")
                  (("\"sh\"")
                   (format #f "~s"
                           (search-input-file inputs "bin/sh"))))

                ;; Substitute "awk" command.
                (substitute* '("lisp/gnus/nnspool.el" "lisp/org/ob-awk.el"
                               "lisp/man.el")
                  (("\"awk\"")
                   (format #f "~s"
                           (search-input-file inputs "bin/awk"))))

                ;; Substitute "find" command.
                (substitute* '("lisp/gnus/gnus-search.el"
                               "lisp/obsolete/nnir.el"
                               "lisp/progmodes/executable.el"
                               "lisp/progmodes/grep.el"
                               "lisp/filecache.el"
                               "lisp/ldefs-boot.el"
                               "lisp/mpc.el")
                  (("\"find\"")
                   (format #f "~s"
                           (search-input-file inputs "bin/find"))))

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
                   (let ((replacement (false-if-exception (search-input-file
                                                           inputs
                                                           (string-append
                                                            "/bin/" what)))))
                     (if replacement
                         (string-append "\"" replacement "\"") all))))
                ;; match ".gvfs-fuse-daemon-real" and ".gvfsd-fuse-real"
                ;; respectively when looking for GVFS processes.
                (substitute* "lisp/net/tramp-gvfs.el"
                  (("\\(tramp-compat-process-running-p \"(.*)\"\\)" all
                    process)
                   (format #f "(or ~a (tramp-compat-process-running-p ~s))"
                           all
                           (string-append "." process "-real"))))))))))))

(define-public emacs-master-no-x-toolkit
  (emacs->emacs-master emacs-no-x-toolkit))

(define-public emacs-master
  (emacs->emacs-master emacs))

(define-public emacs-master-xwidgets
  (emacs->emacs-master emacs-xwidgets))

;; New Garbage Collector branch for testing
(define-public emacs-master-igc
  (package
    (inherit emacs-master)
    (name "emacs-master-igc")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.savannah.gnu.org/git/emacs.git")
             (commit "6225610e8af02ece7ef15d182d83f21997197334")))
       (sha256
        (base32 "03v7mvpm79mi2nv4y35ysa7v25mmm4s6qcbx0rksz9520xdgf78i"))
       (patches (origin-patches (package-source emacs-master-minimal)))))))

;; PGTK
(define-public emacs-master-pgtk
  (emacs->emacs-master emacs-pgtk))
(define-public emacs-master-pgtk-xwidgets
  (emacs->emacs-master emacs-pgtk-xwidgets))

;; Motif
(define-public emacs-master-motif
  (emacs->emacs-master emacs-motif))

(define-public emacs-master-lucid
  (emacs->emacs-master emacs-lucid))

;;;; Latest Emacs Stable Release (follows Guix’s emacs-team branch)

(define-public emacs-minimal
  (package
    (name "emacs-minimal")
    (version "30.1")
    ;; Note: When using (replacement …), ensure that comp-native-version-dir
    ;; stays the same across grafts.
    ;; Run `make check-system TESTS=emacs-native-comp' to ensure that grafts
    ;; can meaningfully be applied.
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/emacs/emacs-"
                                  version ".tar.xz"))
              (sha256
               (base32
                "13qkdx515qv7m8b2mpd37p16frs0xgl7bw8xvv397bz6fspc3jkc"))
              (patches (search-patches "emacs-disable-jit-compilation.patch"
                                       "emacs-exec-path.patch"
                                       "emacs-fix-scheme-indent-function.patch"
                                       "emacs-native-comp-driver-options.patch"
                                       "emacs-native-comp-fix-filenames.patch"
                                       "emacs-native-comp-pin-packages.patch"
                                       "emacs-pgtk-super-key-fix.patch"))
              (modules '((guix build utils)))
              (snippet
               '(with-directory-excursion "lisp"
                  ;; Delete the bundled byte-compiled elisp files and generated
                  ;; autoloads.
                  (for-each delete-file
                            (append (find-files "." "\\.elc$")
                                    (find-files "." "loaddefs\\.el$")
                                    (find-files "eshell" "^esh-groups\\.el$")))

                  ;; Make sure Tramp looks for binaries in the right places on
                  ;; remote Guix System machines, where 'getconf PATH' returns
                  ;; something bogus.
                  (substitute* "net/tramp.el"
                    ;; Patch the line after "(defcustom tramp-remote-path".
                    (("\\(tramp-default-remote-path")
                     (format #f "(tramp-default-remote-path ~s ~s ~s ~s "
                             "~/.guix-profile/bin" "~/.guix-profile/sbin"
                             "/run/current-system/profile/bin"
                             "/run/current-system/profile/sbin")))

                  ;; Make sure Man looks for C header files in the right
                  ;; places.
                  (substitute* "man.el"
                    (("\"/usr/local/include\"" line)
                     (string-join
                      (list line
                            "\"~/.guix-profile/include\""
                            "\"/var/guix/profiles/system/profile/include\"")
                      " ")))))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:tests? #f                       ; no check target
      #:modules (%emacs-modules build-system)
      #:configure-flags #~(list "--with-gnutls=no" "--disable-build-details")
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'enable-elogind
            (lambda _
              (substitute* "configure.ac"
                (("libsystemd") "libelogind"))
              (when (file-exists? "configure")
                (delete-file "configure"))))
          (add-after 'unpack 'patch-program-file-names
            (lambda* (#:key inputs #:allow-other-keys)
              ;; Substitute "sh" command.
              (substitute* '("src/callproc.c"
                             "lisp/term.el"
                             "lisp/htmlfontify.el"
                             "lisp/mail/feedmail.el"
                             "lisp/obsolete/pgg-pgp.el"
                             "lisp/obsolete/pgg-pgp5.el"
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
                         all (string-append "." process "-real"))))))
          (add-before 'configure 'fix-/bin/pwd
            (lambda _
              ;; Use `pwd', not `/bin/pwd'.
              (substitute* (find-files "." "^Makefile\\.in$")
                (("/bin/pwd")
                 "pwd"))))
          (add-after 'install 'install-site-start
            ;; Use 'guix-emacs' in "site-start.el", which is used autoload the
            ;; Elisp packages found in EMACSLOADPATH.
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out      (assoc-ref outputs "out"))
                     (lisp-dir (string-append out "/share/emacs/site-lisp"))
                     (emacs    (string-append out "/bin/emacs")))

                ;; This is duplicated from emacs-utils to prevent coupling.
                (define* (emacs-byte-compile-directory dir)
                  (let ((expr `(progn
                                (setq byte-compile-debug t)
                                (byte-recompile-directory
                                 (file-name-as-directory ,dir) 0 1))))
                    (invoke emacs "--quick" "--batch"
                            (format #f "--eval=~s" expr))))

                (copy-file #$(local-file
                              (search-auxiliary-file "emacs/guix-emacs.el"))
                           (string-append lisp-dir "/guix-emacs.el"))
                (with-output-to-file (string-append lisp-dir "/site-start.el")
                  (lambda ()
                    (display
                     (string-append
                      "(when (require 'guix-emacs nil t)\n"
                      "  (guix-emacs-autoload-packages 'no-reload)\n"
                      "  (advice-add 'package-load-all-descriptors"
                      " :after #'guix-emacs-load-package-descriptors))"))))
                ;; Remove the extraneous subdirs.el file, as it causes Emacs to
                ;; add recursively all the the sub-directories of a profile's
                ;; share/emacs/site-lisp union when added to EMACSLOADPATH,
                ;; which leads to conflicts.
                (delete-file (string-append lisp-dir "/subdirs.el"))
                ;; Byte compile the site-start files.
                (emacs-byte-compile-directory lisp-dir))))
          (add-after 'install 'wrap-emacs-paths
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (lisp-dirs (find-files (string-append out "/share/emacs")
                                            "^lisp$"
                                            #:directories? #t)))
                (for-each
                 (lambda (prog)
                   (wrap-program prog
                     ;; Some variants rely on uname being in PATH for Tramp.
                     ;; Tramp paths can't be hardcoded, because they need to
                     ;; be portable.
                     `("PATH" suffix
                       ,(map dirname
                             (list (search-input-file inputs "/bin/gzip")
                                   ;; for coreutils
                                   (search-input-file inputs "/bin/yes"))))
                     `("EMACSLOADPATH" suffix ,lisp-dirs)))
                 (find-files (string-append out "/bin")
                             ;; Matches versioned and unversioned emacs binaries.
                             ;; We don't patch emacsclient, because it takes its
                             ;; environment variables from emacs.
                             ;; Likewise, we don't need to patch helper binaries
                             ;; like etags, ctags or ebrowse.
                             "^emacs(-[0-9]+(\\.[0-9]+)*)?$")))))
          (add-after 'wrap-emacs-paths 'undo-double-wrap
            (lambda* (#:key outputs #:allow-other-keys)
              ;; Directly copy emacs-X.Y to emacs, so that it is not wrapped
              ;; twice.  This also fixes a minor issue, where WMs would not be
              ;; able to track emacs back to emacs.desktop.
              (with-directory-excursion (assoc-ref outputs "out")
                (copy-file
                 (car (find-files "bin" "^emacs-([0-9]+\\.)+[0-9]+$"))
                 "bin/emacs")))))))
    (inputs (list bash-minimal coreutils findutils gawk gzip ncurses sed))
    (native-inputs (list autoconf pkg-config texinfo))
    (home-page "https://www.gnu.org/software/emacs/")
    (synopsis "The extensible text editor (minimal build for byte-compilation)")
    (description
     "GNU Emacs is an extensible and highly customizable text editor.  It is
based on an Emacs Lisp interpreter with extensions for text editing.  Emacs
has been extended in essentially all areas of computing, giving rise to a
vast array of packages supporting, e.g., email, IRC and XMPP messaging,
spreadsheets, remote server editing, and much more.  Emacs includes extensive
documentation on all aspects of the system, from basic editing to writing
large Lisp programs.  It has full Unicode support for nearly all human
languages.")
    (license license:gpl3+)
    (native-search-paths
     (list (search-path-specification
            (variable "EMACSLOADPATH")
            (files '("share/emacs/site-lisp")))
           (search-path-specification
            (variable "EMACSNATIVELOADPATH")
            (files '("lib/emacs/native-site-lisp")))
           (search-path-specification
            (variable "INFOPATH")
            (files '("share/info")))
           ;; Most variants support tree-sitter, so let's include it here.
           (search-path-specification
            (variable "TREE_SITTER_GRAMMAR_PATH")
            (files '("lib/tree-sitter")))))
    (properties `((upstream-name . "emacs")))))

(define-public emacs-no-x
  (package/inherit emacs-minimal
    (name "emacs-no-x")
    (synopsis "The extensible, customizable, self-documenting text
editor (console only)")
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-minimal)
       ((#:configure-flags flags #~'())
        #~(cons* "--with-modules" "--with-native-compilation=aot"
                 (delete "--with-gnutls=no" #$flags)))
       ((#:phases phases)
        #~(modify-phases #$phases
            (add-after 'set-paths 'set-libgccjit-path
              (lambda* (#:key inputs #:allow-other-keys)
                (define (first-subdirectory/absolute directory)
                  (let ((files (scandir
                                directory
                                (lambda (file)
                                  (and (not (member file '("." "..")))
                                       (file-is-directory? (string-append
                                                            directory "/"
                                                            file)))))))
                    (and (not (null? files))
                         (string-append directory "/" (car files)))))
                (let* ((libgccjit-libdir
                        (first-subdirectory/absolute ;; version
                         (first-subdirectory/absolute ;; host type
                          (search-input-directory inputs "lib/gcc")))))
                  (setenv "LIBRARY_PATH"
                          (string-append (getenv "LIBRARY_PATH")
                                         ":" libgccjit-libdir)))))
            (add-after 'unpack 'patch-compilation-driver
              (lambda _
                (substitute* "lisp/emacs-lisp/comp.el"
                  (("\\(defcustom native-comp-driver-options nil")
                   (format
                    #f "(defcustom native-comp-driver-options '(~@{~s~^ ~})"
                    (string-append
                     "-B" #$(this-package-input "binutils") "/bin/")
                    (string-append
                     "-B" #$(this-package-input "glibc") "/lib/")
                    (string-append
                     "-B" #$(this-package-input "libgccjit") "/lib/")
                    (string-append
                     "-B" #$(this-package-input "libgccjit") "/lib/gcc/"))))))
            (add-after 'build 'build-trampolines
              (lambda* (#:key make-flags #:allow-other-keys)
                (apply invoke "make" "trampolines" make-flags)))
            (add-after 'validate-runpath 'validate-comp-integrity
              (lambda* (#:key outputs #:allow-other-keys)
                #$(cond
                   ((%current-target-system)
                    #~(display "Cannot validate native-comp on cross builds.\n"))
                   ((member (%current-system) '("armhf-linux" "i686-linux"))
                    #~(display "Integrity test is broken on armhf.\n"))
                   (else
                    #~(invoke
                       (string-append (assoc-ref outputs "out") "/bin/emacs")
                       "--batch"
                       "--load"
                       #$(local-file
                          (search-auxiliary-file "emacs/comp-integrity.el"))
                       "-f" "ert-run-tests-batch-and-exit")))))))))
    (inputs
     (modify-inputs (package-inputs emacs-minimal)
       (prepend gnutls
                ;; To "unshadow" ld-wrapper in native builds
                (make-ld-wrapper "ld-wrapper" #:binutils binutils)
                ;; For native compilation
                binutils
                (libc-for-target)
                libgccjit

                ;; Avoid Emacs's limited movemail substitute that retrieves POP3
                ;; email only via insecure channels.
                ;; This is not needed for (modern) IMAP.
                mailutils

                acl
                alsa-lib
                elogind
                ghostscript
                gpm
                jansson
                lcms
                libice
                libselinux
                libsm
                libxml2
                m17n-lib
                sqlite
                tree-sitter
                zlib)))))

(define-public emacs
  (package/inherit emacs-no-x
    (name "emacs")
    (synopsis "The extensible, customizable, self-documenting text editor")
    (build-system glib-or-gtk-build-system)
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-no-x)
       ((#:modules _) (%emacs-modules build-system))
       ((#:configure-flags flags #~'())
        #~(cons* "--with-cairo" #$flags))
       ((#:phases phases)
        #~(modify-phases #$phases
            ;; Note: due to the changed #:modules, %standard-phases in #$phases
            ;; refers to glib-or-gtk:%standard-phases, so we don't need to add
            ;; them ourselves.
            (add-after 'glib-or-gtk-wrap 'restore-emacs-pdmp
              ;; Restore the dump file that Emacs installs somewhere in
              ;; libexec/ to its original state.
              (lambda* (#:key outputs target #:allow-other-keys)
                (let* ((libexec (string-append (assoc-ref outputs "out")
                                               "/libexec"))
                       ;; each of these ought to only match a single file,
                       ;; but even if not (find-files) sorts by string<,
                       ;; so the Nth element in one maps to the Nth element of
                       ;; the other
                       (pdmp (find-files libexec "\\.pdmp$"))
                       (pdmp-real (find-files libexec "\\.pdmp-real$")))
                  (for-each rename-file pdmp-real pdmp))))))))
    (inputs (modify-inputs (package-inputs emacs-no-x)
              (prepend
               cairo
               dbus
               gtk+
               giflib
               harfbuzz
               libjpeg-turbo
               libotf
               libpng
               (librsvg-for-system)
               libtiff
               libx11
               libxft
               libxpm
               pango
               poppler)))))
;; PGTK
(define-public emacs-pgtk
  (package/inherit emacs
    (name "emacs-pgtk")
    (arguments
     (substitute-keyword-arguments (package-arguments emacs)
       ((#:configure-flags flags #~'())
        #~(cons* "--with-pgtk" #$flags))))
    (synopsis "Emacs text editor with @code{pgtk} frames")
    (description "This Emacs build implements graphical UI purely in terms
of GTK.")))

;; XWidgets
(define-public emacs-xwidgets
  (package/inherit emacs
    (name "emacs-xwidgets")
    (synopsis "The extensible, customizable, self-documenting text
editor (with xwidgets support)")
    (arguments
     (substitute-keyword-arguments (package-arguments emacs)
       ((#:configure-flags flags #~'())
        #~(cons "--with-xwidgets" #$flags))))
    (inputs
     (modify-inputs (package-inputs emacs)
       (prepend webkitgtk-with-libsoup2 libxcomposite)))))

;; PGTK+XWidgets
(define-public emacs-pgtk-xwidgets
  (package
    (inherit emacs-pgtk)
    (name "emacs-pgtk-xwidgets")
    (synopsis "Emacs text editor with @code{xwidgets} and @code{pgtk} support")
    (arguments
     (substitute-keyword-arguments (package-arguments emacs-pgtk)
       ((#:configure-flags flags #~'())
        #~(cons "--with-xwidgets" #$flags))))
    (inputs
     (modify-inputs (package-inputs emacs-pgtk)
       (prepend gsettings-desktop-schemas webkitgtk-with-libsoup2)))))

;; Lucid
(define-public emacs-lucid
  (package/inherit emacs-no-x
    (name "emacs-lucid")
    (synopsis
     "The extensible, customizable, self-documenting text editor
(with Lucid toolkit)")
    (inputs (modify-inputs (package-inputs emacs)
              (delete gtk+)
              (prepend libxaw)))
    (arguments (substitute-keyword-arguments (package-arguments emacs-no-x)
                 ((#:configure-flags flags
                   #~'())
                  #~(cons "--with-x-toolkit=lucid"
                          #$flags))))))

(define-public emacs-master-lucid
  (emacs->emacs-master emacs-lucid))

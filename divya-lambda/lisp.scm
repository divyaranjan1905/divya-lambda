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
;;; Packages pertaining to common lisp toolchain and compilers

(define-module (divya-lambda lisp)
  #:use-module (gnu packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system haskell)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages dbm)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages groff)
  #:use-module (gnu packages haskell-check)
  #:use-module (gnu packages haskell-web)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages libffcall)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libsigsegv)
  #:use-module (gnu packages libunwind)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages notcurses)
  #:use-module (gnu packages onc-rpc)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages text-editors)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages xorg)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1))

(define-public sbcl
  (package
    (name "sbcl")
    (version "2.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://sourceforge/sbcl/sbcl/" version "/sbcl-"
                           version "-source.tar.bz2"))
       (sha256
        (base32 "1c8ri9mcrwb548lhfxnjlqfx2w751hbjxbkvnwhxz8p4i38ay61f"))
       (modules '((guix build utils)))
       (snippet
        '(begin
           ;; Don't force ARMv5.
           (substitute* "src/runtime/Config.arm-linux"
             (("-march=armv5t") ""))))))
    (build-system gnu-build-system)
    (outputs '("out" "doc"))
    (native-inputs
     ;; From INSTALL:
     ;;     Supported build hosts are:
     ;;       SBCL
     ;;       CMUCL
     ;;       CCL (formerly known as OpenMCL)
     ;;       ABCL (recent versions only)
     ;;       CLISP (only some versions: 2.44.1 is OK, 2.47 is not)
     ;;       XCL
     ;;
     ;; From NEWS:
     ;;     * build enhancement: new host quirks mechanism, support for building under
     ;;     ABCL and ECL (as well as CCL, CMUCL, CLISP and SBCL itself)
     ;;
     ;; CCL is not bootstrappable so it won't do.  CLISP 2.49 seems to work.
     ;; ECL too.  As of 2020-07-01, ECL was last updated in 2020 while CLISP
     ;; was last updated in 2010, and both take about the same time to build SBCL.
     ;;
     ;; For now we stick to CLISP as the default for all systems.  In any event, keep
     ;; the `match' here to make it easier to change the host compiler for various
     ;; architectures.  Consider switching to ECL if it gets faster than CLISP
     ;; (maybe post 2020 release).
     (list (match (%current-system)
             ("powerpc-linux"       ; CLISP fails to build, needs investigating.
              ecl)
             (_
              clisp))
           cl-asdf
           ed
           inetutils         ;for hostname(1)
           texinfo
           (texlive-updmap.cfg (list texlive-texinfo))
           which))
    (inputs
     (list bash-minimal
           gmp                          ; for sb-gmp
           mpfr                         ; for sb-mpfr
           (list zstd "lib")))
    (arguments
     `(#:modules ((guix build gnu-build-system)
                  (guix build utils)
                  (srfi srfi-1))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-after 'unpack 'fix-build-id
           ;; One of the build scripts makes a build id using the current date.
           ;; Replace it with a reproducible id using a part of the output hash.
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((hash (substring (assoc-ref outputs "out")
                                    (+ (string-length (%store-directory)) 1)
                                    (+ (string-length (%store-directory)) 9))))
               (substitute* "make-config.sh"
                 (("echo .* > output/build-id.inc")
                  (string-append "echo '\"'guix-sbcl-"
                                 hash
                                 "'\"' > output/build-id.inc"))))))
         (add-after 'unpack 'replace-asdf
           ;; SBCL developers have not committed to keeping ASDF up to date
           ;; due to breaking changes [1]. Guix can handle this situation
           ;; easily, and it behooves us to have more control over what version
           ;; of ASDF we use to build software; therefore, replace the contrib
           ;; ASDF with the version packaged into Guix.
           ;; [1] - https://bugs.launchpad.net/sbcl/+bug/1823442
           (lambda* (#:key inputs #:allow-other-keys)
             (let* ((cl-asdf (assoc-ref inputs "cl-asdf"))
                    (guix-asdf (string-append
                                cl-asdf
                                "/share/common-lisp/source/asdf/asdf.lisp"))
                    (contrib-asdf "contrib/asdf/asdf.lisp"))
               (copy-file guix-asdf contrib-asdf))))
         (add-before 'build 'patch-unix-tool-paths
           (lambda* (#:key outputs inputs #:allow-other-keys)
             (let ((out (assoc-ref outputs "out"))
                   (bash (assoc-ref inputs "bash"))
                   (coreutils (assoc-ref inputs "coreutils"))
                   (ed (assoc-ref inputs "ed")))
               (define (quoted-path input path)
                 (string-append "\"" input path "\""))
               ;; Patch absolute paths in string literals.  Note that this
               ;; occurs in some .sh files too (which contain Lisp code).  Use
               ;; ISO-8859-1 because some of the files are ISO-8859-1 encoded.
               (with-fluids ((%default-port-encoding #f))
                 ;; The removed file is utf-16-be encoded, which gives substitute*
                 ;; trouble. It does not contain references to the listed programs.
                 (substitute* (delete
                               "./tests/data/compile-file-pos-utf16be.lisp"
                               (find-files "." "\\.(lisp|sh)$"))
                   (("\"/bin/sh\"") (quoted-path bash "/bin/sh"))
                   (("\"/usr/bin/env\"") (quoted-path coreutils "/usr/bin/env"))
                   (("\"/bin/cat\"") (quoted-path coreutils "/bin/cat"))
                   (("\"/bin/ed\"") (quoted-path ed "/bin/ed"))
                   (("\"/bin/echo\"") (quoted-path coreutils "/bin/echo"))
                   (("\"/bin/uname\"") (quoted-path coreutils "/bin/uname"))))
               ;; This one script has a non-string occurrence of /bin/sh.
               (substitute* '("tests/foreign.test.sh")
                 ;; Leave whitespace so we don't match the shebang.
                 ((" /bin/sh ") " sh "))
               ;; This file contains a module that can create executable files
               ;; which depend on the presence of SBCL.  It generates shell
               ;; scripts doing "exec sbcl ..." to achieve this.  We patch both
               ;; the shebang and the reference to "sbcl", tying the generated
               ;; executables to the exact SBCL package that generated them.
               (substitute* '("contrib/sb-executable/sb-executable.lisp")
                 (("/bin/sh") (string-append bash "/bin/sh"))
                 (("exec sbcl") (string-append "exec " out "/bin/sbcl")))
               ;; Disable some tests that fail in our build environment.
               (substitute* '("contrib/sb-bsd-sockets/tests.lisp")
                 ;; This requires /etc/protocols.
                 (("\\(deftest get-protocol-by-name/error" all)
                  (string-append "#+nil ;disabled by Guix\n" all)))
               (substitute* '("contrib/sb-posix/posix-tests.lisp")
                 ;; These assume some users/groups which we don't have.
                 (("\\(deftest pwent\\.[12]" all)
                  (string-append "#+nil ;disabled by Guix\n" all))
                 (("\\(deftest grent\\.[12]" all)
                  (string-append "#+nil ;disabled by Guix\n" all))))))
         (add-before 'build 'fix-contrib-library-path
           (lambda* (#:key inputs #:allow-other-keys)
             (let ((gmp (assoc-ref inputs "gmp"))
                   (mpfr (assoc-ref inputs "mpfr")))
               (substitute* '("contrib/sb-gmp/gmp.lisp")
                 (("\"libgmp\\.so")
                  (string-append "\"" gmp "/lib/libgmp.so")))
               (substitute* '("contrib/sb-mpfr/mpfr.lisp")
                 (("\"libmpfr\\.so")
                  (string-append "\"" mpfr "/lib/libmpfr.so"))))))
         (replace 'build
           (lambda* (#:key outputs #:allow-other-keys)
             (setenv "CC" "gcc")
             (invoke "sh" "make.sh" ,@(match (%current-system)
                                        ("powerpc-linux"
                                         `("ecl"))
                                        (_
                                         `("clisp")))
                     (string-append "--prefix="
                                    (assoc-ref outputs "out"))
                     ,@(if (or (target-ppc32?)
                               (target-x86-32?))
                         ;; 3072 is too much for these architectures.
                         `("--dynamic-space-size=2048")
                         `("--dynamic-space-size=3072"))
                     "--with-sb-core-compression"
                     "--with-sb-xref-for-internals"
                     ;; SB-SIMD will only be built on x86_64 CPUs supporting
                     ;; AVX2 instructions. Some x86_64 CPUs don't, so for reproducibility
                     ;; we disable it.
                     "--without-sb-simd")))
         (add-after 'build 'build-shared-library
           (lambda* (#:key outputs #:allow-other-keys)
             (setenv "CC" "gcc")
             (invoke "sh" "make-shared-library.sh")))
         (replace 'install
           (lambda _
             (invoke "sh" "install.sh")))
         (add-after 'build 'build-doc
           (lambda _
             (with-directory-excursion "doc/manual"
               (and  (invoke "make" "info")
                     (invoke "make" "dist")))))
         (add-after 'build 'build-source
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (rc (string-append out "/lib/sbcl/sbclrc"))
                    (source-dir (string-append out "/share/sbcl")))
               (for-each (lambda (p)
                           (copy-recursively p (string-append source-dir "/" p)))
                         '("src" "contrib"))
               (mkdir-p (dirname rc))
               (with-output-to-file rc
                 (lambda ()
                   (display
                    (string-append "(sb-ext:set-sbcl-source-location \""
                                   source-dir "\")") ))))))
         (add-after 'install 'remove-coreutils-references
           ;; They are only useful on non-Linux, non-SBCL.
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (share-dir (string-append out "/share/sbcl/")))
               (substitute* (string-append share-dir "src/code/run-program.lisp")
                 (("\\(run-program \".*uname\"")
                  "(run-program \"uname\""))
               (substitute* (string-append share-dir "contrib/asdf/asdf.lisp")
                 (("\\(\".*/usr/bin/env\"")
                  "(\"/usr/bin/env\""))
               (substitute* (string-append share-dir "contrib/asdf/uiop.lisp")
                 (("\\(\".*/usr/bin/env\"")
                  "(\"/usr/bin/env\"")))))
         (add-after 'install 'install-shared-library
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (lib-dir (string-append out "/lib")))
               (install-file "src/runtime/libsbcl.so" lib-dir))))
         (add-after 'install 'install-doc
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (doc (assoc-ref outputs "doc"))
                    (old-doc-dir (string-append out "/share/doc"))
                    (new-doc/sbcl-dir (string-append doc "/share/doc/sbcl")))
               (rmdir (string-append old-doc-dir "/sbcl/html"))
               (mkdir-p new-doc/sbcl-dir)
               (copy-recursively (string-append old-doc-dir "/sbcl")
                                 new-doc/sbcl-dir)
               (delete-file-recursively old-doc-dir)))))
       ;; No 'check' target, though "make.sh" (build phase) runs tests.
       #:tests? #f))
    (native-search-paths
     (list (search-path-specification
            (variable "XDG_DATA_DIRS")
            (files '("share")))
           (search-path-specification
            (variable "XDG_CONFIG_DIRS")
            (files '("etc")))))
    (home-page "https://www.sbcl.org/")
    (supported-systems (remove target-hurd? %supported-systems))
    (synopsis "Common Lisp implementation")
    (description "Steel Bank Common Lisp (SBCL) is a high performance Common
Lisp compiler.  In addition to the compiler and runtime system for ANSI Common
Lisp, it provides an interactive environment including a debugger, a
statistical profiler, a code coverage tool, and many other extensions.")
    ;; Public domain in jurisdictions that allow it, bsd-2 otherwise.  MIT
    ;; loop macro has its own license.  See COPYING file for further notes.
    (license (list license:public-domain license:bsd-2
                   (license:x11-style "file://src/code/loop.lisp")))))


sbcl

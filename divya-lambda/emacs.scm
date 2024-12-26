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
  (gnu packages gtk)

  #:use-module
  (emacs-master))


;; Updated from emacs-master channel: https://codeberg.org/akib/guix-channel-emacs-master/src/branch/master/emacs-master.scm

;;; !!! EMACS COMMIT AND HASH BEGIN !!!
(define emacs-master-commit "ab3888515694f89a24f64e94292c578af86eeaee")
(define emacs-master-time "1735225936")
(define emacs-master-hash "0pa13ajj7zfwjiv2g4psh3vknxw8kna55178lfk3m1xa6ycxfc07")
;;; !!! EMACS COMMIT AND HASH END !!!

(define-public emacs-master-minimal
  (package
    (inherit emacs-next-minimal)
    (name "emacs-master-minimal")
    (version (git-version "31.1" emacs-master-time emacs-master-commit))
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
        #~(modify-phases #$phases (delete 'validate-comp-integrity)))))))

(define-public emacs-master (emacs->emacs-master emacs))

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

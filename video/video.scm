;; Packages related to all things video

(define-module
  (video)
  #:use-module
  ((guix licenses) #:prefix license:)
  #:use-module
  (guix build-system cargo)
  #:use-module
  (guix download)
  #:use-module
  (guix git-download)
  #:use-module
  (guix packages)
  #:use-module
  (guix gexp)
  #:use-module
  (gnu packages crates-windows)
  #:use-module
  (gnu packages crates-crypto)
  #:use-module
  (gnu packages crates-gtk)
  #:use-module
  (gnu packages crates-apple)
  #:use-module
  (gnu packages crates-io))

;;; TODO: Manual hash fix: rust-blue-recorder
;;; TODO: Fix home-page, synopsis, description and license for rust-blue-recorder
;;; TODO: Manual hash fix: rust-cairo-rs
;;; TODO: Manual hash fix: rust-cairo-sys-rs
;;; TODO: Manual hash fix: rust-gdk-pixbuf
;;; TODO: Manual hash fix: rust-gdk-pixbuf-sys
;;; TODO: Manual hash fix: rust-gdk4
;;; TODO: Manual hash fix: rust-gdk4-sys
;;; TODO: Manual hash fix: rust-gio
;;; TODO: Manual hash fix: rust-gio-sys
;;; TODO: Manual hash fix: rust-glib
;;; TODO: Manual hash fix: rust-glib-macros
;;; TODO: Manual hash fix: rust-glib-sys
;;; TODO: Manual hash fix: rust-gobject-sys
;;; TODO: Manual hash fix: rust-pango
;;; TODO: Manual hash fix: rust-pango-sys

(define rust-async-attributes-1
  (package
    (name "rust-async-attributes")
    (version "1.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "async-attributes" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "1rcnypqgmlcw9vwh0fk8bivvz8p5v8acy0zd2njdv6yxyiwkw853"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build?
       #t
       #:cargo-inputs
       (("rust-quote" ,rust-quote-1)
        ("rust-syn" ,rust-syn-1))))
    (home-page
     "https://github.com/async-rs/async-attributes")
    (synopsis
     "Experimental language-level polyfills for Async Rust")
    (description
     "This package provides Experimental language-level polyfills for Async Rust.")
    (license (list license:expat license:asl2.0))))

(define rust-async-executor-1
  (package
    (name "rust-async-executor")
    (version "1.5.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-executor" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1684q901f5wkrp6ph91flz0a73dj3zz9scis8l7w1ndbinpa679c"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-lock" ,rust-async-lock-2)
         ("rust-async-task" ,rust-async-task-4)
         ("rust-concurrent-queue"
          ,rust-concurrent-queue-2)
         ("rust-fastrand" ,rust-fastrand-2)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-slab" ,rust-slab-0.4))))
    (home-page
      "https://github.com/smol-rs/async-executor")
    (synopsis "Async executor")
    (description
      "This package provides Async executor.")
    (license (list license:asl2.0 license:expat))))

(define rust-async-global-executor-2
  (package
    (name "rust-async-global-executor")
    (version "2.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-global-executor" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xmpcx23k8k887bzb97p9n0i2gf6rxpcdvpq9542kg97vzbzbdpi"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-async-channel" ,rust-async-channel-1)
         ("rust-async-executor" ,rust-async-executor-1)
         ("rust-async-io" ,rust-async-io-1)
         ("rust-async-lock" ,rust-async-lock-2)
         ("rust-blocking" ,rust-blocking-1)
         ("rust-futures-lite" ,rust-futures-lite-1)
         ("rust-once-cell" ,rust-once-cell-1))))
    (home-page
      "https://github.com/Keruspe/async-global-executor")
    (synopsis
      "global executor built on top of async-executor and async-io")
    (description
      "This package provides a global executor built on top of async-executor and\nasync-io.")
    (license (list license:asl2.0 license:expat))))

(define rust-async-lock-2
  (package
    (name "rust-async-lock")
    (version "2.8.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-lock" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0asq5xdzgp3d5m82y5rg7a0k9q0g95jy6mgc7ivl334x7qlp4wi8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-event-listener" ,rust-event-listener-2))))
    (home-page
      "https://github.com/smol-rs/async-lock")
    (synopsis "Async synchronization primitives")
    (description
      "This package provides Async synchronization primitives.")
    (license (list license:asl2.0 license:expat))))

(define rust-async-recursion-1
  (package
    (name "rust-async-recursion")
    (version "1.0.5")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-recursion" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1l2vlgyaa9a2dd0y1vbqyppzsvpdr1y4rar4gn1qi68pl5dmmmaz"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/dcchut/async-recursion")
    (synopsis "Recursion for async functions")
    (description
      "This package provides Recursion for async functions.")
    (license (list license:expat license:asl2.0))))

(define rust-async-task-4
  (package
    (name "rust-async-task")
    (version "4.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "async-task" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "08f9vf1s9ym3rhgl0zjvkvh1rwqd9p1l82k8pz1afa715xmiqi5r"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/smol-rs/async-task")
    (synopsis
      "Task abstraction for building executors")
    (description
      "This package provides Task abstraction for building executors.")
    (license (list license:asl2.0 license:expat))))

(define rust-atk-sys-0.15
  (package
    (name "rust-atk-sys")
    (version "0.15.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "atk-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1dmg7aq3f533cczkhcyyp929daqpwdz1r5w9h3dhd3k9zf4v1bjq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-gobject-sys" ,rust-gobject-sys-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libatk-1")
    (description
      "This package provides FFI bindings to libatk-1.")
    (license license:expat)))

(define rust-bumpalo-3
  (package
    (name "rust-bumpalo")
    (version "3.14.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "bumpalo" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1v4arnv9kwk54v5d0qqpv4vyw2sgr660nk0w3apzixi1cm3yfc3z"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/fitzgen/bumpalo")
    (synopsis "fast bump allocation arena for Rust.")
    (description
      "This package provides a fast bump allocation arena for Rust.")
    (license (list license:expat license:asl2.0))))

(define rust-cairo-sys-rs-0.20
  (package
    (name "rust-cairo-sys-rs")
    (version "0.20.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "cairo-sys-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "13x85l52nl2izmdb48zzpkhhh1a4dsgqlp8gys4n1f5r2kwr10j2"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libcairo")
    (description
      "This package provides FFI bindings to libcairo.")
    (license license:expat)))

(define rust-cairo-rs-0.20
  (package
    (name "rust-cairo-rs")
    (version "0.20.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "cairo-rs" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
	 ;; "1mf73q33w6y40cb1p6fbpnw119zy1mvc412rg3wq687kqbfv40v0"
	 ;; "14m7vf3qfg3wi05yzvzp5cggnf6x3llqbnrlds1qndkxvc3ps298"
	 "0ifir739h0d2gm5x773mivc3d8mhvsagfgaqgl6svc6w6jkdazvr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:skip-build?
       #t
       #:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-2)
        ("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
        ("rust-glib" ,rust-glib-0.19)
        ("rust-libc" ,rust-libc-0.2)
        ("rust-once-cell" ,rust-once-cell-1)
        ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://gtk-rs.org/")
    (synopsis "Rust bindings for the Cairo library")
    (description
     "This package provides Rust bindings for the Cairo library.")
    (license license:expat)))

(define rust-dark-light-1
  (package
    (name "rust-dark-light")
    (version "1.0.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "dark-light" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0ignyqydr3lx4ljai6b90snx418z8dj39p9kqy4cvcqmank0f856"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-dconf-rs" ,rust-dconf-rs-0.3)
         ("rust-detect-desktop-environment"
          ,rust-detect-desktop-environment-0.2)
         ("rust-dirs" ,rust-dirs-4)
         ("rust-objc" ,rust-objc-0.2)
         ("rust-rust-ini" ,rust-rust-ini-0.18)
         ("rust-web-sys" ,rust-web-sys-0.3)
         ("rust-winreg" ,rust-winreg-0.10)
         ("rust-zbus" ,rust-zbus-3)
         ("rust-zvariant" ,rust-zvariant-3))))
    (home-page
      "https://github.com/frewsxcv/rust-dark-light")
    (synopsis
      "Detect if dark mode or light mode is enabled")
    (description
      "This package provides Detect if dark mode or light mode is enabled.")
    (license (list license:expat license:asl2.0))))

(define rust-dconf-rs-0.3
  (package
    (name "rust-dconf-rs")
    (version "0.3.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "dconf_rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "12swi0npq88kbdwnc3n324dzknir674agrh13h305876h654cikh"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/kylecorry31/dconf_rs")
    (synopsis "Rust API for interacting with dconf.")
    (description
      "This package provides a Rust API for interacting with dconf.")
    (license license:expat)))

(define rust-detect-desktop-environment-0.2
  (package
    (name "rust-detect-desktop-environment")
    (version "0.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "detect-desktop-environment" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0408nmfgb54wqigjpqxwcxy5jp4ni1fjvynqdgpa84svvmhavn11"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/demurgos/detect-desktop-environment")
    (synopsis "Autodetect the desktop environment")
    (description
      "This package provides Autodetect the desktop environment.")
    (license license:expat)))

(define rust-dirs-sys-0.3
  (package
    (name "rust-dirs-sys")
    (version "0.3.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "dirs-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "19md1cnkazham8a6kh22v12d8hh3raqahfk6yb043vrjr68is78v"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-redox-users" ,rust-redox-users-0.4)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page
      "https://github.com/dirs-dev/dirs-sys-rs")
    (synopsis
      "System-level helper functions for the dirs and directories crates")
    (description
      "This package provides System-level helper functions for the dirs and directories crates.")
    (license (list license:expat license:asl2.0))))

(define rust-enumflags2-0.7
  (package
    (name "rust-enumflags2")
    (version "0.7.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "enumflags2" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0f9r5i4fqj3vwzy2hm5pcl2cbnmz47w3mxkjxlxdkj900grv962r"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-enumflags2-derive"
          ,rust-enumflags2-derive-0.7)
         ("rust-serde" ,rust-serde-1))))
    (home-page
      "https://github.com/meithecatte/enumflags2")
    (synopsis "Enum-based bit flags")
    (description
      "This package provides Enum-based bit flags.")
    (license (list license:expat license:asl2.0))))

(define rust-enumflags2-derive-0.7
  (package
    (name "rust-enumflags2-derive")
    (version "0.7.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "enumflags2_derive" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0il2856z9qxzm11m6i9kr2jh75mfwmpcwlrr7qd4lp9mrl0jhppr"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page
      "https://github.com/meithecatte/enumflags2")
    (synopsis
      "Do not use directly, use the reexport in the `enumflags2` crate. This allows for better compatibility across versions")
    (description
      "This package provides Do not use directly, use the reexport in the `enumflags2` crate.  This allows\nfor better compatibility across versions.")
    (license (list license:expat license:asl2.0))))

(define rust-field-offset-0.3
  (package
    (name "rust-field-offset")
    (version "0.3.6")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "field-offset" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0zq5sssaa2ckmcmxxbly8qgz3sxpb8g1lwv90sdh1z74qif2gqiq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-memoffset" ,rust-memoffset-0.9)
         ("rust-rustc-version" ,rust-rustc-version-0.4))))
    (home-page
      "https://github.com/Diggsey/rust-field-offset")
    (synopsis
      "Safe pointer-to-member implementation")
    (description
      "This package provides Safe pointer-to-member implementation.")
    (license (list license:expat license:asl2.0))))

(define rust-filename-0.1
  (package
    (name "rust-filename")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "filename" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1s7byy8c939qrm6hsjqq0vicfv6rkxb3yrhslg7zkggyxw1xzr33"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page
      "https://github.com/flier/rust-filename")
    (synopsis
      "Get filename from a raw file descriptor")
    (description
      "This package provides Get filename from a raw file descriptor.")
    (license license:expat)))

(define rust-gdk-pixbuf-0.19
  (package
    (name "rust-gdk-pixbuf")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk-pixbuf" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "13r0dyrpc7djk883s2hsr58wbknpfhkpks1m2gg8f6q501wc84f3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gdk-pixbuf-sys" ,rust-gdk-pixbuf-sys-0.19)
         ("rust-gio" ,rust-gio-0.19)
         ("rust-glib" ,rust-glib-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-once-cell" ,rust-once-cell-1))))
    (home-page "https://gtk-rs.org/")
    (synopsis
      "Rust bindings for the GdkPixbuf library")
    (description
      "This package provides Rust bindings for the @code{GdkPixbuf} library.")
    (license license:expat)))

(define rust-gdk-pixbuf-sys-0.19
  (package
    (name "rust-gdk-pixbuf-sys")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk-pixbuf-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "15lg08i5cbilwvyyy9ldp21j81kxj6y2hj4b03638j1c3d6d1jrx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gio-sys" ,rust-gio-sys-0.19)
         ("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-gobject-sys" ,rust-gobject-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libgdk_pixbuf-2.0")
    (description
      "This package provides FFI bindings to libgdk_pixbuf-2.0.")
    (license license:expat)))

(define rust-gdk-sys-0.15
  (package
    (name "rust-gdk-sys")
    (version "0.15.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "121s0wk24kflj7m13g578gvqj5lcgdvimrdpgwbz81lg3s6a1rrj"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
         ("rust-gdk-pixbuf-sys" ,rust-gdk-pixbuf-sys-0.15)
         ("rust-gio-sys" ,rust-gio-sys-0.15)
         ("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-gobject-sys" ,rust-gobject-sys-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango-sys" ,rust-pango-sys-0.15)
         ("rust-pkg-config" ,rust-pkg-config-0.3)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libgdk-3")
    (description
      "This package provides FFI bindings to libgdk-3.")
    (license license:expat)))

(define rust-gdk4-0.4
  (package
    (name "rust-gdk4")
    (version "0.4.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk4" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xh8b3ms20xmmp2gkvrfmsljggy0s2avp2nnln2v09iwhk7vgasg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-cairo-rs" ,rust-cairo-rs-0.15)
         ("rust-gdk-pixbuf" ,rust-gdk-pixbuf-0.15)
         ("rust-gdk4-sys" ,rust-gdk4-sys-0.4)
         ("rust-gio" ,rust-gio-0.15)
         ("rust-glib" ,rust-glib-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango" ,rust-pango-0.15))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "Rust bindings of the GDK 4 library")
    (description
      "This package provides Rust bindings of the GDK 4 library.")
    (license license:expat)))

(define rust-gdk4-0.8
  (package
    (name "rust-gdk4")
    (version "0.8.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk4" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "01nqska6w7ps0fsskasj9amry6s0wjar6wv41hiamgm2hlpr8wb7"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cairo-rs" ,rust-cairo-rs-0.20)
         ("rust-gdk-pixbuf" ,rust-gdk-pixbuf-0.19)
         ("rust-gdk4-sys" ,rust-gdk4-sys-0.8)
         ("rust-gio" ,rust-gio-0.19)
         ("rust-glib" ,rust-glib-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango" ,rust-pango-0.19))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "Rust bindings of the GDK 4 library")
    (description
      "This package provides Rust bindings of the GDK 4 library.")
    (license license:expat)))

(define rust-gdk4-sys-0.4
  (package
    (name "rust-gdk4-sys")
    (version "0.4.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk4-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1wnfv62n9dmpzg9rpy3hj1aldpkkavyans9zzymsw02w9ysdrrzg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
         ("rust-gdk-pixbuf-sys" ,rust-gdk-pixbuf-sys-0.15)
         ("rust-gio-sys" ,rust-gio-sys-0.15)
         ("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-gobject-sys" ,rust-gobject-sys-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango-sys" ,rust-pango-sys-0.15)
         ("rust-pkg-config" ,rust-pkg-config-0.3)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "FFI bindings of GDK 4")
    (description
      "This package provides FFI bindings of GDK 4.")
    (license license:expat)))

(define rust-gdk4-sys-0.8
  (package
    (name "rust-gdk4-sys")
    (version "0.8.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gdk4-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1bpnpmw1q32l1h5pqa2wwkb73d9x017l653q78174l5nz9a5if8y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
         ("rust-gdk-pixbuf-sys" ,rust-gdk-pixbuf-sys-0.19)
         ("rust-gio-sys" ,rust-gio-sys-0.19)
         ("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-gobject-sys" ,rust-gobject-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango-sys" ,rust-pango-sys-0.19)
         ("rust-pkg-config" ,rust-pkg-config-0.3)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "FFI bindings of GDK 4")
    (description
      "This package provides FFI bindings of GDK 4.")
    (license license:expat)))

(define rust-gettext-sys-0.21
  (package
    (name "rust-gettext-sys")
    (version "0.21.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gettext-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "17c3qdbirxsf9csqzp4z4jaqck2n72z4nw3nh9vhd8jn1zhf4g66"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cc" ,rust-cc-1)
         ("rust-temp-dir" ,rust-temp-dir-0.1))))
    (home-page
      "https://github.com/gettext-rs/gettext-rs")
    (synopsis "Raw FFI bindings for gettext")
    (description
      "This package provides Raw FFI bindings for gettext.")
    (license license:expat)))

(define rust-gio-0.19
  (package
    (name "rust-gio")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gio" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "10nbn3d2zl6904kdsx0iny9v64qmdf024n5kyckhlw96v6iamldk"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-io" ,rust-futures-io-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-gio-sys" ,rust-gio-sys-0.19)
         ("rust-glib" ,rust-glib-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-pin-project-lite"
          ,rust-pin-project-lite-0.2)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://gtk-rs.org/")
    (synopsis "Rust bindings for the Gio library")
    (description
      "This package provides Rust bindings for the Gio library.")
    (license license:expat)))

(define rust-gio-sys-0.19
  (package
    (name "rust-gio-sys")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gio-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1r0wp34aacf4jgs79fic0qra1s6162q0glskcxir9clv47cy3y5w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-gobject-sys" ,rust-gobject-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libgio-2.0")
    (description
      "This package provides FFI bindings to libgio-2.0.")
    (license license:expat)))

(define rust-glib-0.19
  (package
    (name "rust-glib")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glib" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "0wafjcc5mfg6qjycg15v0f1w7ppay1n1v5zl3kyvbcs4kcmyh3hp"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-2)
         ("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-executor"
          ,rust-futures-executor-0.3)
         ("rust-futures-task" ,rust-futures-task-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-gio-sys" ,rust-gio-sys-0.19)
         ("rust-glib-macros" ,rust-glib-macros-0.19)
         ("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-gobject-sys" ,rust-gobject-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-memchr" ,rust-memchr-2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://gtk-rs.org/")
    (synopsis "Rust bindings for the GLib library")
    (description
      "This package provides Rust bindings for the GLib library.")
    (license license:expat)))

(define rust-glib-macros-0.19
  (package
    (name "rust-glib-macros")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glib-macros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "11fy2jcfw6wkrvqc70r4f5qn5iy8j2xyji77i9cvh6sdgvzjzx9g"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-heck" ,rust-heck-0.4)
         ("rust-proc-macro-crate"
          ,rust-proc-macro-crate-2)
         ("rust-proc-macro-error"
          ,rust-proc-macro-error-1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-2))))
    (home-page "https://gtk-rs.org/")
    (synopsis
      "Rust bindings for the GLib library, proc macros crate")
    (description
      "This package provides Rust bindings for the GLib library, proc macros crate.")
    (license license:expat)))

(define rust-glib-sys-0.19
  (package
    (name "rust-glib-sys")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "glib-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1m6fzq9lh5snmgchmrm0py5wjzdlay0lxpsq6axs1iypfdvhj3v3"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libglib-2.0")
    (description
      "This package provides FFI bindings to libglib-2.0.")
    (license license:expat)))

(define rust-gobject-sys-0.19
  (package
    (name "rust-gobject-sys")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gobject-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "0ya9wn6x4md9wsyhgvz08c1h69n8lniqsjcbqp88shdrh082npn8"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libgobject-2.0")
    (description
      "This package provides FFI bindings to libgobject-2.0.")
    (license license:expat)))

(define rust-graphene-rs-0.15
  (package
    (name "rust-graphene-rs")
    (version "0.15.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "graphene-rs" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "0w2mz098dr8mlz18ssmlnln1x6c3byizqbc9kz4n5nzgpvxzjm3w"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib" ,rust-glib-0.15)
         ("rust-graphene-sys" ,rust-graphene-sys-0.15)
         ("rust-libc" ,rust-libc-0.2))))
    (home-page "https://gtk-rs.org/")
    (synopsis
      "Rust bindings for the Graphene library")
    (description
      "This package provides Rust bindings for the Graphene library.")
    (license license:expat)))

(define rust-graphene-sys-0.15
  (package
    (name "rust-graphene-sys")
    (version "0.15.10")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "graphene-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "12h2qcdhvzxhkc75fqkky6rz212wp2yc6mgvk9cxz8bv6g3iysgs"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pkg-config" ,rust-pkg-config-0.3)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libgraphene-1.0")
    (description
      "This package provides FFI bindings to libgraphene-1.0.")
    (license license:expat)))

(define rust-gsk4-0.4
  (package
    (name "rust-gsk4")
    (version "0.4.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gsk4" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1r0vnrgdpkavxkq67bgixcp72l4vz9dlk5nl72mb701j6c6h5s85"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-cairo-rs" ,rust-cairo-rs-0.15)
         ("rust-gdk4" ,rust-gdk4-0.4)
         ("rust-glib" ,rust-glib-0.15)
         ("rust-graphene-rs" ,rust-graphene-rs-0.15)
         ("rust-gsk4-sys" ,rust-gsk4-sys-0.4)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango" ,rust-pango-0.15))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "Rust bindings of the GSK 4 library")
    (description
      "This package provides Rust bindings of the GSK 4 library.")
    (license license:expat)))

(define rust-gsk4-sys-0.4
  (package
    (name "rust-gsk4-sys")
    (version "0.4.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gsk4-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1sizv9dy5ch1nxmfmdb3xm35q10zr7fa4hw6hf650y00yv63kpbs"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
         ("rust-gdk4-sys" ,rust-gdk4-sys-0.4)
         ("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-gobject-sys" ,rust-gobject-sys-0.15)
         ("rust-graphene-sys" ,rust-graphene-sys-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango-sys" ,rust-pango-sys-0.15)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "FFI bindings of GSK 4")
    (description
      "This package provides FFI bindings of GSK 4.")
    (license license:expat)))

(define rust-gstreamer-0.20
  (package
    (name "rust-gstreamer")
    (version "0.20.7")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gstreamer" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1jcg143f5k1s4p8knqw0cc8x81shgax0spx1dypiranl4021b960"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-cfg-if" ,rust-cfg-if-1)
         ("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-futures-core" ,rust-futures-core-0.3)
         ("rust-futures-util" ,rust-futures-util-0.3)
         ("rust-glib" ,rust-glib-0.17)
         ("rust-gstreamer-sys" ,rust-gstreamer-sys-0.20)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-muldiv" ,rust-muldiv-1)
         ("rust-num-integer" ,rust-num-integer-0.1)
         ("rust-num-rational" ,rust-num-rational-0.4)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-option-operations"
          ,rust-option-operations-0.5)
         ("rust-paste" ,rust-paste-1)
         ("rust-pretty-hex" ,rust-pretty-hex-0.3)
         ("rust-smallvec" ,rust-smallvec-1)
         ("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "Rust bindings for GStreamer")
    (description
      "This package provides Rust bindings for GStreamer.")
    (license (list license:expat license:asl2.0))))

(define rust-gstreamer-sys-0.20
  (package
    (name "rust-gstreamer-sys")
    (version "0.20.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gstreamer-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1ll6ax5wjbvhccq7cx35w4jw6lyvzm017g58mzdlfzggmm3y0vz5"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.17)
         ("rust-gobject-sys" ,rust-gobject-sys-0.17)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gstreamer.freedesktop.org")
    (synopsis "FFI bindings to libgstreamer-1.0")
    (description
      "This package provides FFI bindings to libgstreamer-1.0.")
    (license license:expat)))

(define rust-gtk-sys-0.15
  (package
    (name "rust-gtk-sys")
    (version "0.15.3")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gtk-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "113wp3x7xh2zjv8i5pn3mcz77yr5zq8wm8260bv4g8nbhw2jzg6m"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-atk-sys" ,rust-atk-sys-0.15)
         ("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
         ("rust-gdk-pixbuf-sys" ,rust-gdk-pixbuf-sys-0.15)
         ("rust-gdk-sys" ,rust-gdk-sys-0.15)
         ("rust-gio-sys" ,rust-gio-sys-0.15)
         ("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-gobject-sys" ,rust-gobject-sys-0.15)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango-sys" ,rust-pango-sys-0.15)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libgtk-3")
    (description
      "This package provides FFI bindings to libgtk-3.")
    (license license:expat)))

(define rust-gtk4-0.4
  (package
    (name "rust-gtk4")
    (version "0.4.9")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gtk4" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1g5v9wwf9sgz9vx0vwfc3sxm9pm5cah3ypjy3daw6fvryapfb2jf"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-cairo-rs" ,rust-cairo-rs-0.15)
         ("rust-field-offset" ,rust-field-offset-0.3)
         ("rust-futures-channel"
          ,rust-futures-channel-0.3)
         ("rust-gdk-pixbuf" ,rust-gdk-pixbuf-0.15)
         ("rust-gdk4" ,rust-gdk4-0.4)
         ("rust-gio" ,rust-gio-0.15)
         ("rust-glib" ,rust-glib-0.15)
         ("rust-graphene-rs" ,rust-graphene-rs-0.15)
         ("rust-gsk4" ,rust-gsk4-0.4)
         ("rust-gtk4-macros" ,rust-gtk4-macros-0.4)
         ("rust-gtk4-sys" ,rust-gtk4-sys-0.4)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-pango" ,rust-pango-0.15))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "Rust bindings of the GTK 4 library")
    (description
      "This package provides Rust bindings of the GTK 4 library.")
    (license license:expat)))

(define rust-gtk4-macros-0.4
  (package
    (name "rust-gtk4-macros")
    (version "0.4.10")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gtk4-macros" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0v42i8xpg9f84iq1d0k2sb7vh94n9v9rk7i7iq3579wi9ra0pfka"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-anyhow" ,rust-anyhow-1)
         ("rust-proc-macro-crate"
          ,rust-proc-macro-crate-1)
         ("rust-proc-macro-error"
          ,rust-proc-macro-error-1)
         ("rust-proc-macro2" ,rust-proc-macro2-1)
         ("rust-quick-xml" ,rust-quick-xml-0.22)
         ("rust-quote" ,rust-quote-1)
         ("rust-syn" ,rust-syn-1))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "Macros helpers for GTK 4 bindings")
    (description
      "This package provides Macros helpers for GTK 4 bindings.")
    (license license:expat)))

(define rust-gtk4-sys-0.4
  (package
    (name "rust-gtk4-sys")
    (version "0.4.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "gtk4-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0qqgxfbmygsl3xd3qal37cdz4ibfc0j9xxrzv9r7qjv3x9p01j2v"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cairo-sys-rs" ,rust-cairo-sys-rs-0.20)
         ("rust-gdk-pixbuf-sys" ,rust-gdk-pixbuf-sys-0.15)
         ("rust-gdk4-sys" ,rust-gdk4-sys-0.4)
         ("rust-gio-sys" ,rust-gio-sys-0.15)
         ("rust-glib-sys" ,rust-glib-sys-0.15)
         ("rust-gobject-sys" ,rust-gobject-sys-0.15)
         ("rust-graphene-sys" ,rust-graphene-sys-0.15)
         ("rust-gsk4-sys" ,rust-gsk4-sys-0.4)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-pango-sys" ,rust-pango-sys-0.15)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/gtk4-rs")
    (synopsis "FFI bindings of GTK 4")
    (description
      "This package provides FFI bindings of GTK 4.")
    (license license:expat)))

(define rust-io-lifetimes-1
  (package
    (name "rust-io-lifetimes")
    (version "1.0.11")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "io-lifetimes" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1hph5lz4wd3drnn6saakwxr497liznpfnv70via6s0v8x6pbkrza"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-hermit-abi" ,rust-hermit-abi-0.3)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page
      "https://github.com/sunfishcode/io-lifetimes")
    (synopsis
      "low-level I/O ownership and borrowing library")
    (description
      "This package provides a low-level I/O ownership and borrowing library.")
    (license
      (list license:asl2.0
            license:asl2.0
            license:expat))))

(define rust-linux-raw-sys-0.3
  (package
    (name "rust-linux-raw-sys")
    (version "0.3.8")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "linux-raw-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "068mbigb3frrxvbi5g61lx25kksy98f2qgkvc4xg8zxznwp98lzg"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/sunfishcode/linux-raw-sys")
    (synopsis
      "Generated bindings for Linux's userspace API")
    (description
      "This package provides Generated bindings for Linux's userspace API.")
    (license
      (list license:asl2.0
            license:asl2.0
            license:expat))))

(define rust-linux-raw-sys-0.4
  (package
    (name "rust-linux-raw-sys")
    (version "0.4.13")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "linux-raw-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "172k2c6422gsc914ig8rh99mb9yc7siw6ikc3d9xw1k7vx0s3k81"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/sunfishcode/linux-raw-sys")
    (synopsis
      "Generated bindings for Linux's userspace API")
    (description
      "This package provides Generated bindings for Linux's userspace API.")
    (license
      (list license:asl2.0
            license:asl2.0
            license:expat))))

(define rust-option-operations-0.5
  (package
    (name "rust-option-operations")
    (version "0.5.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "option-operations" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1l13n9487gk6063zzjdwzqbig78n8mh6dxsbiq9nbaxfn5xx49kw"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-paste" ,rust-paste-1))))
    (home-page
      "https://github.com/fengalin/option-operations")
    (synopsis
      "Traits and auto-implementations to improve arithmetic operations usability when dealing with `Option`s")
    (description
      "This package provides Traits and auto-implementations to improve arithmetic operations usability when\ndealing with `Option`s.")
    (license (list license:expat license:asl2.0))))

(define rust-pango-0.19
  (package
    (name "rust-pango")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pango" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "17nnh9rfir40vb10rigbjakvx849dpx0s1hszms8qwjpp5wzgmvq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-gio" ,rust-gio-0.19)
         ("rust-glib" ,rust-glib-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-once-cell" ,rust-once-cell-1)
         ("rust-pango-sys" ,rust-pango-sys-0.19))))
    (home-page "https://gtk-rs.org/")
    (synopsis "Rust bindings for the Pango library")
    (description
      "This package provides Rust bindings for the Pango library.")
    (license license:expat)))

(define rust-pango-sys-0.19
  (package
    (name "rust-pango-sys")
    (version "0.19.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "pango-sys" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
	    "1sj0ycchs4f384wq9v6v56xamb0isk5gaka8n7ivz7y1h6lgcbpm"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-glib-sys" ,rust-glib-sys-0.19)
         ("rust-gobject-sys" ,rust-gobject-sys-0.19)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-system-deps" ,rust-system-deps-6))))
    (home-page "https://gtk-rs.org/")
    (synopsis "FFI bindings to libpango-1.0")
    (description
      "This package provides FFI bindings to libpango-1.0.")
    (license license:expat)))

(define rust-proc-macro-crate-1
  (package
    (name "rust-proc-macro-crate")
    (version "1.3.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "proc-macro-crate" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "069r1k56bvgk0f58dm5swlssfcp79im230affwk6d9ck20g04k3z"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-once-cell" ,rust-once-cell-1)
         ("rust-toml-edit" ,rust-toml-edit-0.19))))
    (home-page
      "https://github.com/bkchr/proc-macro-crate")
    (synopsis
      "Replacement for crate (macro_rules keyword) in proc-macros")
    (description
      "This package provides Replacement for crate (macro_rules keyword) in proc-macros.")
    (license (list license:expat license:asl2.0))))

(define rust-rust-ini-0.16
  (package
    (name "rust-rust-ini")
    (version "0.16.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rust-ini" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1iiswwbjcvi6m9nap3lwyc1d5rwwmilyak1syy3b1q47g9v39cam"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-cfg-if" ,rust-cfg-if-0.1)
         ("rust-ordered-multimap"
          ,rust-ordered-multimap-0.3))))
    (home-page
      "https://github.com/zonyitoo/rust-ini")
    (synopsis
      "An Ini configuration file parsing library in Rust")
    (description
      "This package provides An Ini configuration file parsing library in Rust.")
    (license license:expat)))

(define rust-rustix-0.37
  (package
    (name "rust-rustix")
    (version "0.37.25")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "rustix" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0dd0alaz1q5hwpbg22kjiw5xigij6hf50ky2ww1jqk14a6c5gsyl"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-bitflags" ,rust-bitflags-1)
         ("rust-errno" ,rust-errno-0.3)
         ("rust-io-lifetimes" ,rust-io-lifetimes-1)
         ("rust-libc" ,rust-libc-0.2)
         ("rust-linux-raw-sys" ,rust-linux-raw-sys-0.3)
         ("rust-windows-sys" ,rust-windows-sys-0.48))))
    (home-page
      "https://github.com/bytecodealliance/rustix")
    (synopsis
      "Safe Rust bindings to POSIX/Unix/Linux/Winsock-like syscalls")
    (description
      "This package provides Safe Rust bindings to POSIX/Unix/Linux/Winsock-like syscalls.")
    (license
      (list license:asl2.0
            license:asl2.0
            license:expat))))

(define rust-secfmt-0.1
  (package
    (name "rust-secfmt")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "secfmt" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0710fwskvbgz5kzsa3c29j47bs5lbhkn27qabmy9j48phqr39iy8"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://crates.io/crates/secfmt")
    (synopsis
      "Converts seconds into a human readable format (struct) containing years, days, hours, minutes and seconds")
    (description
      "This package provides Converts seconds into a human readable format (struct) containing years, days,\nhours, minutes and seconds.")
    (license license:expat)))

(define rust-signal-hook-registry-1
  (package
    (name "rust-signal-hook-registry")
    (version "1.4.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "signal-hook-registry" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "18crkkw5k82bvcx088xlf5g4n3772m24qhzgfan80nda7d3rn8nq"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2))))
    (home-page
      "https://github.com/vorner/signal-hook")
    (synopsis "Backend crate for signal-hook")
    (description
      "This package provides Backend crate for signal-hook.")
    (license (list license:asl2.0 license:expat))))

(define rust-slab-0.4
  (package
    (name "rust-slab")
    (version "0.4.9")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "slab" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0rxvsgir0qw5lkycrqgb1cxsvxzjv9bmx73bk5y42svnzfba94lg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-autocfg" ,rust-autocfg-1))))
    (home-page "https://github.com/tokio-rs/slab")
    (synopsis
      "Pre-allocated storage for a uniform data type")
    (description
      "This package provides Pre-allocated storage for a uniform data type.")
    (license license:expat)))

(define rust-socket2-0.4
  (package
    (name "rust-socket2")
    (version "0.4.9")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "socket2" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0qnn1r41jqj20m0a2nzzjgzndlmpg5maiyjchccaypfqxq8sk934"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-libc" ,rust-libc-0.2)
         ("rust-winapi" ,rust-winapi-0.3))))
    (home-page
      "https://github.com/rust-lang/socket2")
    (synopsis
      "Utilities for handling networking sockets with a maximal amount of configuration\npossible intended.")
    (description
      "This package provides Utilities for handling networking sockets with a maximal amount of configuration\npossible intended.")
    (license (list license:expat license:asl2.0))))

(define rust-temp-dir-0.1
  (package
    (name "rust-temp-dir")
    (version "0.1.11")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "temp-dir" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1arxa8vfc1gj1w5njm7q2s0q3dngav29ymk5453lpsnidlb7nm5g"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://gitlab.com/leonhard-llc/ops")
    (synopsis
      "Simple temporary directory with cleanup")
    (description
      "This package provides Simple temporary directory with cleanup.")
    (license license:asl2.0)))

(define rust-typenum-1
  (package
    (name "rust-typenum")
    (version "1.17.0")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "typenum" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "09dqxv69m9lj9zvv6xw5vxaqx15ps0vxyy5myg33i0kbqvq0pzs2"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page "https://github.com/paholg/typenum")
    (synopsis
      "Typenum is a Rust library for type-level numbers evaluated at\n    compile time. It currently supports bits, unsigned integers, and signed\n    integers. It also provides a type-level array of type-level numbers, but its\n    implementation is incomplete")
    (description
      "This package provides Typenum is a Rust library for type-level numbers evaluated at compile time.  It\ncurrently supports bits, unsigned integers, and signed integers.  It also\nprovides a type-level array of type-level numbers, but its implementation is\nincomplete.")
    (license (list license:expat license:asl2.0))))

(define rust-version-compare-0.0.10
  (package
    (name "rust-version-compare")
    (version "0.0.10")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "version-compare" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "18ack6rx18rp700h1dncljmpzchs3p2dfh76a8ds6vmfbfi5cdfn"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://timvisee.com/projects/version-compare/")
    (synopsis
      "Rust library to easily compare version numbers with no specific format, and test against various comparison operators")
    (description
      "This package provides Rust library to easily compare version numbers with no specific format, and test\nagainst various comparison operators.")
    (license license:expat)))

(define rust-version-compare-0.1
  (package
    (name "rust-version-compare")
    (version "0.1.1")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "version-compare" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0acg4pmjdbmclg0m7yhijn979mdy66z3k8qrcnvn634f1gy456jp"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://timvisee.com/projects/version-compare/")
    (synopsis
      "Rust library to easily compare version numbers with no specific format, and test against various comparison operators")
    (description
      "This package provides Rust library to easily compare version numbers with no specific format, and test\nagainst various comparison operators.")
    (license license:expat)))

(define rust-windows-targets-0.52
  (package
    (name "rust-windows-targets")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows-targets" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "06sdd7fin3dj9cmlg6n1dw0n1l10jhn9b8ckz1cqf0drb9z7plvx"))))
    (build-system cargo-build-system)
    (arguments
      `(#:skip-build?
        #t
        #:cargo-inputs
        (("rust-windows-aarch64-gnullvm"
          ,rust-windows-aarch64-gnullvm-0.52)
         ("rust-windows-aarch64-msvc"
          ,rust-windows-aarch64-msvc-0.52)
         ("rust-windows-i686-gnu"
          ,rust-windows-i686-gnu-0.52)
         ("rust-windows-i686-msvc"
          ,rust-windows-i686-msvc-0.52)
         ("rust-windows-x86-64-gnu"
          ,rust-windows-x86-64-gnu-0.52)
         ("rust-windows-x86-64-gnullvm"
          ,rust-windows-x86-64-gnullvm-0.52)
         ("rust-windows-x86-64-msvc"
          ,rust-windows-x86-64-msvc-0.52))))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import libs for Windows")
    (description
      "This package provides Import libs for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-aarch64-gnullvm-0.52
  (package
    (name "rust-windows-aarch64-gnullvm")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_aarch64_gnullvm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1jfam5qfngg8v1syxklnvy8la94b5igm7klkrk8z5ik5qgs6rx5w"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-aarch64-msvc-0.52
  (package
    (name "rust-windows-aarch64-msvc")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_aarch64_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xdn6db0rk8idn7dxsyflixq2dbj9x60kzdzal5rkxmwsffjb7ys"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-i686-gnu-0.52
  (package
    (name "rust-windows-i686-gnu")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_i686_gnu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1lq1g35sbj55ms86by4c080jcqrlfjy9bw5r4mgrkq4riwkdhx5l"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-i686-msvc-0.52
  (package
    (name "rust-windows-i686-msvc")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_i686_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00lfzw88dkf3fdcf2hpfhp74i9pwbp7rwnj1nhy79vavksifj58m"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-gnu-0.52
  (package
    (name "rust-windows-x86-64-gnu")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_gnu" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "00qs6x33bf9lai2q68faxl56cszbv7mf7zqlslmc1778j0ahkvjy"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-gnullvm-0.52
  (package
    (name "rust-windows-x86-64-gnullvm")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_gnullvm" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "0xr13xxakp14hs4v4hg2ynjcv7wrzr3hg7zk5agglj8v8pr7kjkp"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define rust-windows-x86-64-msvc-0.52
  (package
    (name "rust-windows-x86-64-msvc")
    (version "0.52.4")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "windows_x86_64_msvc" version))
        (file-name
          (string-append name "-" version ".tar.gz"))
        (sha256
          (base32
            "1n0yc7xiv9iki1j3xl8nxlwwkr7dzsnwwvycvgxxv81d5bjm5drj"))))
    (build-system cargo-build-system)
    (arguments `(#:skip-build? #t))
    (home-page
      "https://github.com/microsoft/windows-rs")
    (synopsis "Import lib for Windows")
    (description
      "This package provides Import lib for Windows.")
    (license (list license:expat license:asl2.0))))

(define-public blue-recorder
  (package
    (name "blue-recorder")
    (version "0.2.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
	      (url "https://github.com/xlmnxp/blue-recorder")
	      (commit "1cfa3bbb1b5ea845b3e4c51eba269745f0c3e271")))
        (file-name
          (git-file-name name version))
        (sha256
          (base32
	    "0fz5l1z5rq8gx2vhrpfnf5l5karlqa7m8fdwx7ixlvy5klywwa5y"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-build-flags '("--release")
	#:phases (modify-phases %standard-phases
		     (add-after 'configure 'cargo-patch
		       (lambda _
			 (let ((p (open-file "Cargo.toml" "a")))
			   (display "\n[net]\ngit-fetch-with-cli = true" p)
			   (close-port p))))
		     (add-after 'build 'fail
		       (lambda _ (error "fail for me baby"))))
        #:cargo-inputs
        (("rust-async-std" ,rust-async-std-1)
         ("rust-chrono" ,rust-chrono-0.4)
         ("rust-dark-light" ,rust-dark-light-1)
         ("rust-dirs" ,rust-dirs-4)
         ("rust-filename" ,rust-filename-0.1)
         ("rust-gdk-pixbuf" ,rust-gdk-pixbuf-0.9)
         ("rust-gdk4" ,rust-gdk4-0.8)
         ("rust-gettext-rs" ,rust-gettext-rs-0.7)
         ("rust-gio" ,rust-gio-0.15)
         ("rust-glib" ,rust-glib-0.10)
         ("rust-gstreamer" ,rust-gstreamer-0.20)
         ("rust-gtk-sys" ,rust-gtk-sys-0.15)
         ("rust-gtk4" ,rust-gtk4-0.4)
         ("rust-regex" ,rust-regex-1)
         ("rust-rust-ini" ,rust-rust-ini-0.16)
         ("rust-secfmt" ,rust-secfmt-0.1)
         ("rust-subprocess" ,rust-subprocess-0.2)
         ("rust-tempfile" ,rust-tempfile-3)
         ("rust-zbus" ,rust-zbus-3))))
    (home-page "https://github.com/xlmnxp/blue-recorder/")
    (synopsis "Simple Screen Recorder written in Rust based on Green Recorder")
    (description "A simple desktop recorder for Linux systems.
Built using GTK4 and ffmpeg.  It supports recording audio and video on almost all Linux
interfaces with support for Wayland display server on GNOME session.")
    (license license:gpl3)))

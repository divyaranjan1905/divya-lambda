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
;;; Rust crates related to IO
(define-module (divya-lambda crates-io)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)

  #:use-module (gnu packages shells)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-web)
  #:use-module (gnu packages crates-crypto)
  #:use-module (gnu packages crates-tls)
  #:use-module (gnu packages crates-vcs)
  #:use-module (gnu packages crates-windows)
  #:use-module (gnu packages crates-apple)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages crates-compression)
  #:use-module (gnu packages crates-shell)
  #:use-module (gnu packages crates-database)
  #:use-module ((guix licenses) #:prefix license:))

(define-public rust-serial-windows-0.4
  (package
    (name "rust-serial-windows")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial-windows" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0ql1vjy57g2jf218bhmgr98i41faq0v5vzdx3g9payi6fsvx7ihm"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-serial-core" ,rust-serial-core-0.4))))
    (home-page "https://github.com/dcuddeback/serial-rs")
    (synopsis "Serial port implementation for Windows")
    (description
     "This package provides Serial port implementation for Windows.")
    (license license:expat)))

(define-public rust-termios-0.2
  (package
    (name "rust-termios")
    (version "0.2.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "termios" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0fk8nl0rmk43jrh6hjz6c6d83ri7l6fikag6lh0ffz3di9cwznfm"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/dcuddeback/termios-rs")
    (synopsis "Safe bindings for the termios library")
    (description
     "This package provides Safe bindings for the termios library.")
    (license license:expat)))

(define-public rust-ioctl-rs-0.1
  (package
    (name "rust-ioctl-rs")
    (version "0.1.6")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "ioctl-rs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0zdrgqxblrwm4ym8pwrr7a4dwjzxrvr1k0qjx6rk1vjwi480b5zp"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/dcuddeback/ioctl-rs")
    (synopsis "Rust bindings for system ioctls")
    (description "This package provides Rust bindings for system ioctls.")
    (license license:expat)))

(define-public rust-serial-unix-0.4
  (package
    (name "rust-serial-unix")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial-unix" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1dyaaca8g4q5qzc2l01yirzs6igmhc9agg4w8m5f4rnqr6jbqgzh"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-ioctl-rs" ,rust-ioctl-rs-0.1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-serial-core" ,rust-serial-core-0.4)
                       ("rust-termios" ,rust-termios-0.2))))
    (home-page "https://github.com/dcuddeback/serial-rs")
    (synopsis "Serial port implementation for Unix")
    (description "This package provides Serial port implementation for Unix.")
    (license license:expat)))

(define-public rust-serial-core-0.4
  (package
    (name "rust-serial-core")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial-core" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "10a5lvllz3ljva66bqakrn8cxb3pkaqyapqjw9x760al6jdj0iiz"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page "https://github.com/dcuddeback/serial-rs")
    (synopsis "Rust abstractions for serial ports")
    (description "This package provides Rust abstractions for serial ports.")
    (license license:expat)))

(define-public rust-serial-0.4
  (package
    (name "rust-serial")
    (version "0.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "serial" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "11iyvc1z123hn7zl6bk5xpf6xdlsb33qh6xa7g0pghqgayb7l8x1"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-serial-core" ,rust-serial-core-0.4)
                       ("rust-serial-unix" ,rust-serial-unix-0.4)
                       ("rust-serial-windows" ,rust-serial-windows-0.4))))
    (home-page "https://github.com/dcuddeback/serial-rs")
    (synopsis "Rust library for accessing serial ports")
    (description
     "This package provides Rust library for accessing serial ports.")
    (license license:expat)))

(define-public rust-portable-pty-0.8
  (package
    (name "rust-portable-pty")
    (version "0.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "portable-pty" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1gmh9ij90qwxx8gzvs6dj2vlc1ackv8zhd4mzfly3nq3586fhvl0"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-bitflags" ,rust-bitflags-1)
                       ("rust-downcast-rs" ,rust-downcast-rs-1)
                       ("rust-filedescriptor" ,rust-filedescriptor-0.8)
                       ("rust-lazy-static" ,rust-lazy-static-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nix" ,rust-nix-0.25)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-serial" ,rust-serial-0.4)
                       ("rust-shared-library" ,rust-shared-library-0.1)
                       ("rust-shell-words" ,rust-shell-words-1)
                       ("rust-winapi" ,rust-winapi-0.3)
                       ("rust-winreg" ,rust-winreg-0.10))))
    (home-page "https://github.com/wez/wezterm")
    (synopsis "Cross platform pty interface")
    (description "This package provides Cross platform pty interface.")
    (license license:expat)))

(define-public rust-unicode-ellipsis-0.2
  (package
    (name "rust-unicode-ellipsis")
    (version "0.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "unicode-ellipsis" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1zsdzmy6x1p8s35rgfmc7nx1qcs6j4bcfbfyiimrdngyqfwbajlj"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/ClementTsang/unicode-ellipsis")
    (synopsis
     "crate to truncate Unicode strings to a certain width, automatically adding an ellipsis if the string is too long.")
    (description
     "This package provides a crate to truncate Unicode strings to a certain width,
automatically adding an ellipsis if the string is too long.")
    (license (list license:expat license:asl2.0))))

(define-public rust-uom-0.36
  (package
    (name "rust-uom")
    (version "0.36.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "uom" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "176dszv02ki1a49hvv2nkszjcn4m8ccfjgh5hhji2pd6a19nxlzz"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-num-bigint" ,rust-num-bigint-0.4)
                       ("rust-num-complex" ,rust-num-complex-0.4)
                       ("rust-num-rational" ,rust-num-rational-0.4)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-typenum" ,rust-typenum-1))))
    (home-page "https://github.com/iliekturtles/uom")
    (synopsis "Units of measurement")
    (description "This package provides Units of measurement.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-starship-battery-0.9
  (package
    (name "rust-starship-battery")
    (version "0.9.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "starship-battery" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0gzldhpfhqh12wgrahfdl2vma3qmrv434c4xcj7qndclcxs1ayfs"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-core-foundation" ,rust-core-foundation-0.9)
                       ("rust-lazycell" ,rust-lazycell-1)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-mach2" ,rust-mach2-0.4)
                       ("rust-nix" ,rust-nix-0.29)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-plist" ,rust-plist-1)
                       ("rust-schemars" ,rust-schemars-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-uom" ,rust-uom-0.36)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/starship/rust-battery")
    (synopsis "Cross-platform information about the notebook batteries")
    (description
     "This package provides Cross-platform information about the notebook batteries.")
    (license license:isc)))

(define-public rust-unicode-truncate-1
  (package
    (name "rust-unicode-truncate")
    (version "1.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "unicode-truncate" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1gr7arjjhrhy8dww7hj8qqlws97xf9d276svr4hs6pxgllklcr5k"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-itertools" ,rust-itertools-0.13)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page "https://github.com/Aetf/unicode-truncate")
    (synopsis
     "Unicode-aware algorithm to pad or truncate `str` in terms of displayed width.")
    (description
     "This package provides Unicode-aware algorithm to pad or truncate `str` in terms of displayed width.")
    (license (list license:expat license:asl2.0))))

(define-public rust-termion-4
  (package
    (name "rust-termion")
    (version "4.0.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "termion" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "19r3r56cfhl2qvlphw1vrwga37la16rdi15q1d7wz8ji1rb9iaky"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-libredox" ,rust-libredox-0.1)
                       ("rust-numtoa" ,rust-numtoa-0.2)
                       ("rust-redox-termios" ,rust-redox-termios-0.1)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://gitlab.redox-os.org/redox-os/termion")
    (synopsis "bindless library for manipulating terminals.")
    (description
     "This package provides a bindless library for manipulating terminals.")
    (license license:expat)))

(define-public rust-stability-0.2
  (package
    (name "rust-stability")
    (version "0.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "stability" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1b7w6qknq0w5y7s358j62pzi9kbh6g73lal3jx9aydpikl0ff16r"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/sagebind/stability")
    (synopsis "Rust API stability attributes for the rest of us")
    (description
     "This package provides Rust API stability attributes for the rest of us.")
    (license license:expat)))

(define-public rust-strum-0.26
  (package
    (name "rust-strum")
    (version "0.26.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "strum" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "01lgl6jvrf4j28v5kmx9bp480ygf1nhvac8b4p7rcj9hxw50zv4g"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-phf" ,rust-phf-0.10)
                       ("rust-strum-macros" ,rust-strum-macros-0.26))
       #:cargo-development-inputs (("rust-strum-macros" ,rust-strum-macros-0.26))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description
     "This package provides Helpful macros for working with enums and strings.")
    (license license:expat)))

(define-public rust-sysinfo-0.30
  (package
    (name "rust-sysinfo")
    (version "0.30.13")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "sysinfo" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1csbkx1hdlacgzw5ynjyfvgc1xg58w3h1rgh5gm2pysmxvd4snqa"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-core-foundation-sys" ,rust-core-foundation-sys-0.8)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-ntapi" ,rust-ntapi-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-windows" ,rust-windows-0.52))
       #:cargo-development-inputs (("rust-serde-json" ,rust-serde-json-1)
                                   ("rust-tempfile" ,rust-tempfile-3))))
    (home-page "https://github.com/GuillaumeGomez/sysinfo")
    (synopsis
     "Library to get system information such as processes, CPUs, disks, components and networks")
    (description
     "This package provides Library to get system information such as processes, CPUs, disks, components and
networks.")
    (license license:expat)))

(define-public rust-assert-cmd-2
  (package
    (name "rust-assert-cmd")
    (version "2.0.15")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "assert_cmd" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0dwx3700czqixqwinc4hrzyzny52p5b9kvgjpaqknlrmsj6h8rdw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-anstream" ,rust-anstream-0.6)
                       ("rust-anstyle" ,rust-anstyle-1)
                       ("rust-bstr" ,rust-bstr-1)
                       ("rust-doc-comment" ,rust-doc-comment-0.3)
                       ("rust-predicates" ,rust-predicates-3)
                       ("rust-predicates-core" ,rust-predicates-core-1)
                       ("rust-predicates-tree" ,rust-predicates-tree-1)
                       ("rust-wait-timeout" ,rust-wait-timeout-0.2))
       #:cargo-development-inputs (("rust-automod" ,rust-automod-1)
                                   ("rust-escargot" ,rust-escargot-0.5))))
    (home-page "https://github.com/assert-rs/assert_cmd")
    (synopsis "Test CLI Applications")
    (description "This package provides Test CLI Applications.")
    (license (list license:expat license:asl2.0))))

(define-public rust-ratatui-0.27
  (package
   (name "rust-ratatui")
   (version "0.27.0")
   (source
    (origin
     (method url-fetch)
     (uri (crate-uri "ratatui" version))
     (file-name (string-append name "-" version ".tar.gz"))
     (sha256
      (base32 "1lv8r99miibk6np2d2m0y6vf62jf5dr1x272ws6byalnnp2lcrfi"))))
   (build-system cargo-build-system)
   (arguments
    `(
      #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                      ("rust-cassowary" ,rust-cassowary-0.3)
                      ("rust-compact-str" ,rust-compact-str-0.7)
                      ("rust-crossterm" ,rust-crossterm-0.27)
                      ("rust-document-features" ,rust-document-features-0.2)
                      ("rust-itertools" ,rust-itertools-0.13)
                      ("rust-lru" ,rust-lru-0.12)
                      ("rust-palette" ,rust-palette-0.7)
                      ("rust-paste" ,rust-paste-1)
                      ("rust-serde" ,rust-serde-1)
                      ("rust-stability" ,rust-stability-0.2)
                      ("rust-strum" ,rust-strum-0.26)
                      ("rust-strum-macros" ,rust-strum-macros-0.26)
                      ("rust-termion" ,rust-termion-4)
                      ("rust-termwiz" ,rust-termwiz-0.22)
                      ("rust-time" ,rust-time-0.3)
                      ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                      ("rust-unicode-truncate" ,rust-unicode-truncate-1)
                      ("rust-unicode-width" ,rust-unicode-width-0.1))))
   (home-page "https://ratatui.rs")
   (synopsis "library that's all about cooking up terminal user interfaces")
   (description
    "This package provides a library that's all about cooking up terminal user
interfaces.")
   (license license:expat)))

(define-public rust-wrapcenum-derive-0.4
  (package
    (name "rust-wrapcenum-derive")
    (version "0.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "wrapcenum-derive" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0vi67wxkpw40cch5jx010wvwf0rjc5f13yxfzd60acimadcz4vx7"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-darling" ,rust-darling-0.20)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-syn" ,rust-syn-2))))
    (home-page "https://github.com/Cldfire/wrapcenum-derive")
    (synopsis "Derive macro for nvml-wrapper, not for general use")
    (description
     "This package provides Derive macro for nvml-wrapper, not for general use.")
    (license (list license:expat license:asl2.0))))

(define-public rust-nvml-wrapper-sys-0.8
  (package
    (name "rust-nvml-wrapper-sys")
    (version "0.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nvml-wrapper-sys" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1dgw2dpldxik2gn3m3aqgl2qj1da5sz6wav5g571ly18dwalb3b9"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libloading" ,rust-libloading-0.8))))
    (home-page "https://github.com/Cldfire/nvml-wrapper")
    (synopsis "Generated bindings to the NVIDIA Management Library")
    (description
     "This package provides Generated bindings to the NVIDIA Management Library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-nvml-wrapper-0.10
  (package
    (name "rust-nvml-wrapper")
    (version "0.10.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nvml-wrapper" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1i9q80f8x5zy646wvz1wkaydryvnfnwsi8jy72hh92fll45gz6qc"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-bitflags" ,rust-bitflags-2)
                       ("rust-libloading" ,rust-libloading-0.8)
                       ("rust-nvml-wrapper-sys" ,rust-nvml-wrapper-sys-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-derive" ,rust-serde-derive-1)
                       ("rust-static-assertions" ,rust-static-assertions-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-wrapcenum-derive" ,rust-wrapcenum-derive-0.4))))
    (home-page "https://github.com/Cldfire/nvml-wrapper")
    (synopsis
     "safe and ergonomic Rust wrapper for the NVIDIA Management Library")
    (description
     "This package provides a safe and ergonomic Rust wrapper for the NVIDIA
Management Library.")
    (license (list license:expat license:asl2.0))))

(define-public rust-concat-string-1
  (package
    (name "rust-concat-string")
    (version "1.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "concat-string" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "02c6hfxsvs1ff2j58f3qzr526w1yg8d2nf6yyjv81ixgbz5vwfbl"))))
    (build-system cargo-build-system)
    (home-page "https://github.com/FaultyRAM/concat-string")
    (synopsis
     "Provides macros for concatenating string slices into owned strings")
    (description
     "This package provides macros for concatenating string slices into owned strings.")
    (license (list license:asl2.0 license:expat))))

(define-public rust-roxmltree-0.18
  (package
    (name "rust-roxmltree")
    (version "0.18.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "roxmltree" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "00mkd2xyrxm8ap39sxpkhzdzfn2m98q3zicf6wd2f6yfa7il08w6"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-xmlparser" ,rust-xmlparser-0.13))))
    (home-page "https://github.com/RazrFalcon/roxmltree")
    (synopsis "Represent an XML as a read-only tree")
    (description "This package provides Represent an XML as a read-only tree.")
    (license (list license:expat license:asl2.0))))

(define-public rust-nu-term-grid-0.88
  (package
    (name "rust-nu-term-grid")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-term-grid" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1b40z6wz8gbs4gpw29ig48yw94b6xsbwlb3fqj2z6cl8fc3h8ldw"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-unicode-width" ,rust-unicode-width-0.1))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-term-grid")
    (synopsis "Nushell grid printing")
    (description "This package provides Nushell grid printing.")
    (license license:expat)))

(define-public rust-nu-table-0.88
  (package
    (name "rust-nu-table")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-table" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "18r72vvk0y354gfc8fna2p2awdgq63s345cw8pb96dcb4w31k0sn"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-fancy-regex" ,rust-fancy-regex-0.11)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49)
                       ("rust-nu-color-config" ,rust-nu-color-config-0.88)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-tabled" ,rust-tabled-0.14))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-table")
    (synopsis "Nushell table printing")
    (description "This package provides Nushell table printing.")
    (license license:expat)))

(define-public rust-nu-pretty-hex-0.88
  (package
    (name "rust-nu-pretty-hex")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-pretty-hex" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "12i534984736spygc21n9qn0mmparmpjlprpf9wgxrn9blncmjb0"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-pretty-hex")
    (synopsis "Pretty hex dump of bytes slice in the common style")
    (description
     "This package provides Pretty hex dump of bytes slice in the common style.")
    (license license:expat)))

(define-public rust-calamine-0.22
  (package
    (name "rust-calamine")
    (version "0.22.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "calamine" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0ixbak0wag0whhfl2sa7gv4s1bzwz9giqz3gznzwidlvcldaa2zy"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-byteorder" ,rust-byteorder-1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-codepage" ,rust-codepage-0.1)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-quick-xml" ,rust-quick-xml-0.30)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-zip" ,rust-zip-0.6))))
    (home-page "https://github.com/tafia/calamine")
    (synopsis
     "An Excel/OpenDocument Spreadsheets reader and deserializer in pure rust")
    (description
     "This package provides An Excel/@code{OpenDocument} Spreadsheets reader and deserializer in pure rust.")
    (license license:expat)))

(define-public rust-nu-command-0.88
  (package
    (name "rust-nu-command")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-command" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0vsdj1sx0kfr4cql5l44hbiqkqcf0v63i6nbhl2dma933nzc98yf"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-alphanumeric-sort" ,rust-alphanumeric-sort-1)
                       ("rust-base64" ,rust-base64-0.21)
                       ("rust-bracoxide" ,rust-bracoxide-0.1)
                       ("rust-byteorder" ,rust-byteorder-1)
                       ("rust-bytesize" ,rust-bytesize-1)
                       ("rust-calamine" ,rust-calamine-0.22)
                       ("rust-chardetng" ,rust-chardetng-0.1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-chrono-humanize" ,rust-chrono-humanize-0.2)
                       ("rust-chrono-tz" ,rust-chrono-tz-0.8)
                       ("rust-crossterm" ,rust-crossterm-0.27)
                       ("rust-csv" ,rust-csv-1)
                       ("rust-dialoguer" ,rust-dialoguer-0.11)
                       ("rust-digest" ,rust-digest-0.10)
                       ("rust-dtparse" ,rust-dtparse-2)
                       ("rust-encoding-rs" ,rust-encoding-rs-0.8)
                       ("rust-fancy-regex" ,rust-fancy-regex-0.11)
                       ("rust-filesize" ,rust-filesize-0.2)
                       ("rust-filetime" ,rust-filetime-0.2)
                       ("rust-fs-extra" ,rust-fs-extra-1)
                       ("rust-htmlescape" ,rust-htmlescape-0.3)
                       ("rust-human-date-parser" ,rust-human-date-parser-0.1)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-indicatif" ,rust-indicatif-0.17)
                       ("rust-itertools" ,rust-itertools-0.11)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-lscolors" ,rust-lscolors-0.15)
                       ("rust-md-5" ,rust-md-5-0.10)
                       ("rust-miette" ,rust-miette-5)
                       ("rust-mime" ,rust-mime-0.3)
                       ("rust-mime-guess" ,rust-mime-guess-2)
                       ("rust-native-tls" ,rust-native-tls-0.2)
                       ("rust-nix" ,rust-nix-0.27)
                       ("rust-notify-debouncer-full" ,rust-notify-debouncer-full-0.3)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49)
                       ("rust-nu-cmd-base" ,rust-nu-cmd-base-0.88)
                       ("rust-nu-color-config" ,rust-nu-color-config-0.88)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-glob" ,rust-nu-glob-0.88)
                       ("rust-nu-json" ,rust-nu-json-0.88)
                       ("rust-nu-parser" ,rust-nu-parser-0.88)
                       ("rust-nu-path" ,rust-nu-path-0.88)
                       ("rust-nu-pretty-hex" ,rust-nu-pretty-hex-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-system" ,rust-nu-system-0.88)
                       ("rust-nu-table" ,rust-nu-table-0.88)
                       ("rust-nu-term-grid" ,rust-nu-term-grid-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-num" ,rust-num-0.4)
                       ("rust-num-format" ,rust-num-format-0.4)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-open" ,rust-open-5)
                       ("rust-os-pipe" ,rust-os-pipe-1)
                       ("rust-pathdiff" ,rust-pathdiff-0.2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-print-positions" ,rust-print-positions-0.6)
                       ("rust-procfs" ,rust-procfs-0.16)
                       ("rust-quick-xml" ,rust-quick-xml-0.30)
                       ("rust-rand" ,rust-rand-0.8)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-roxmltree" ,rust-roxmltree-0.18)
                       ("rust-rusqlite" ,rust-rusqlite-0.29)
                       ("rust-same-file" ,rust-same-file-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-serde-urlencoded" ,rust-serde-urlencoded-0.7)
                       ("rust-serde-yaml" ,rust-serde-yaml-0.9)
                       ("rust-sha2" ,rust-sha2-0.10)
                       ("rust-sysinfo" ,rust-sysinfo-0.29)
                       ("rust-tabled" ,rust-tabled-0.14)
                       ("rust-terminal-size" ,rust-terminal-size-0.3)
                       ("rust-titlecase" ,rust-titlecase-2)
                       ("rust-toml" ,rust-toml-0.8)
                       ("rust-trash" ,rust-trash-3)
                       ("rust-umask" ,rust-umask-2)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-ureq" ,rust-ureq-2)
                       ("rust-url" ,rust-url-2)
                       ("rust-uu-cp" ,rust-uu-cp-0.0.23)
                       ("rust-uu-mkdir" ,rust-uu-mkdir-0.0.23)
                       ("rust-uu-mktemp" ,rust-uu-mktemp-0.0.23)
                       ("rust-uu-whoami" ,rust-uu-whoami-0.0.23)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-wax" ,rust-wax-0.6)
                       ("rust-which" ,rust-which-5)
                       ("rust-windows" ,rust-windows-0.48)
                       ("rust-winreg" ,rust-winreg-0.52))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-command")
    (synopsis "Nushell's built-in commands")
    (description "This package provides Nushell's built-in commands.")
    (license license:expat)))

(define-public rust-tzdb-0.5
  (package
    (name "rust-tzdb")
    (version "0.5.10")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tzdb" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0sfrl86nxag6y59kl5bzs758kbd50h46an8qsj1xccrlvrdyw63a"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-iana-time-zone" ,rust-iana-time-zone-0.1)
                       ("rust-tz-rs" ,rust-tz-rs-0.6)
                       ("rust-tzdb" ,rust-tzdb-0.6))))
    (home-page "https://github.com/Kijewski/tzdb")
    (synopsis "Static time zone information for tz-rs")
    (description
     "This package provides Static time zone information for tz-rs.")
    (license license:asl2.0)))

(define-public rust-shadow-rs-0.24
  (package
    (name "rust-shadow-rs")
    (version "0.24.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "shadow-rs" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0xqcw27hf8ybxlzhnnx5k0dvb5lq6yydsjv6yrfilky9y6pqq6gr"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-const-format" ,rust-const-format-0.2)
                       ("rust-document-features" ,rust-document-features-0.2)
                       ("rust-git2" ,rust-git2-0.18)
                       ("rust-is-debug" ,rust-is-debug-1)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-tzdb" ,rust-tzdb-0.5))))
    (home-page "https://github.com/baoyachi/shadow-rs")
    (synopsis "build-time information stored in your rust project")
    (description
     "This package provides a build-time information stored in your rust project.")
    (license (list license:expat license:asl2.0))))

(define-public rust-nu-cmd-lang-0.88
  (package
    (name "rust-nu-cmd-lang")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-cmd-lang" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "133dhwbxajvj5lidkcdl6m8l3g639h2485s1hsr77yhdzzhi3jv3"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-fancy-regex" ,rust-fancy-regex-0.11)
                       ("rust-itertools" ,rust-itertools-0.11)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-parser" ,rust-nu-parser-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-shadow-rs" ,rust-shadow-rs-0.24)
                       ("rust-shadow-rs" ,rust-shadow-rs-0.24))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-cmd-lang")
    (synopsis "Nushell's core language commands")
    (description "This package provides Nushell's core language commands.")
    (license license:expat)))

(define-public rust-xcb-0.8
  (package
    (name "rust-xcb")
    (version "0.8.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "xcb" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1ph27r9nxyfy3hh1c7x85g6dciwxcinf6514pvw9ybhl4hzpm4ay"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-libc" ,rust-libc-0.2)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-x11" ,rust-x11-2))))
    (home-page "https://github.com/rust-x-bindings/rust-xcb")
    (synopsis "Rust safe bindings for XCB")
    (description "This package provides Rust safe bindings for XCB.")
    (license license:expat)))

(define-public rust-x11-clipboard-0.3
  (package
    (name "rust-x11-clipboard")
    (version "0.3.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "x11-clipboard" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1smwyr23jns0dncm6bwv00xfxxy99bv6qlx6df7dkdcydk04kgc9"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-xcb" ,rust-xcb-0.8))))
    (home-page "https://github.com/quininer/x11-clipboard")
    (synopsis "x11 clipboard support for Rust")
    (description "This package provides x11 clipboard support for Rust.")
    (license license:expat)))

(define-public rust-clipboard-win-2
  (package
    (name "rust-clipboard-win")
    (version "2.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clipboard-win" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0svqk0lrw66abaxd6h7l4k4g2s5vd1dcipy34kzfan6mzvb97873"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/DoumanAsh/clipboard-win")
    (synopsis "Provides simple way to interact with Windows clipboard")
    (description
     "This package provides simple way to interact with Windows clipboard.")
    (license license:expat)))

(define-public rust-clipboard-0.5
  (package
    (name "rust-clipboard")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clipboard" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1rxjfn811h09g6jpjjs2vx7z52wj6dxnflbwryfj6h03dij09a95"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-clipboard-win" ,rust-clipboard-win-2)
                       ("rust-objc" ,rust-objc-0.2)
                       ("rust-objc-foundation" ,rust-objc-foundation-0.1)
                       ("rust-objc-id" ,rust-objc-id-0.1)
                       ("rust-x11-clipboard" ,rust-x11-clipboard-0.3))))
    (home-page "https://github.com/aweinstock314/rust-clipboard")
    (synopsis
     "rust-clipboard is a cross-platform library for getting and setting the contents of the OS-level clipboard")
    (description
     "This package provides rust-clipboard is a cross-platform library for getting and setting the contents
of the OS-level clipboard.")
    (license (list license:expat license:asl2.0))))

(define-public rust-strum-macros-0.26
  (package
    (name "rust-strum-macros")
    (version "0.26.3")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "strum_macros" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "11zak1qw2p5xwmln9xw8l0iv349cablslss8a41s124y7a73m6gp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-heck" ,rust-heck-0.5)
                       ("rust-proc-macro2" ,rust-proc-macro2-1)
                       ("rust-quote" ,rust-quote-1)
                       ("rust-rustversion" ,rust-rustversion-1)
                       ("rust-syn" ,rust-syn-2))
       #:cargo-development-inputs (("rust-strum" ,rust-strum-0.26))))
    (home-page "https://github.com/Peternator7/strum")
    (synopsis "Helpful macros for working with enums and strings")
    (description
     "This package provides Helpful macros for working with enums and strings.")
    (license license:expat)))

(define-public rust-reedline-0.27
  (package
   (name "rust-reedline")
   (version "0.27.1")
   (source
    (origin
     (method url-fetch)
     (uri (crate-uri "reedline" version))
     (file-name (string-append name "-" version ".tar.gz"))
     (sha256
      (base32 "0g9397dfqh0d19jbk2cs7417g2rarmf513v3igxac9nb9j06y107"))))
   (build-system cargo-build-system)
   (arguments
    `(
      #:cargo-inputs (("rust-chrono" ,rust-chrono-0.4)
                      ("rust-clipboard" ,rust-clipboard-0.5)
                      ("rust-crossbeam" ,rust-crossbeam-0.8)
                      ("rust-crossterm" ,rust-crossterm-0.27)
                      ("rust-fd-lock" ,rust-fd-lock-3)
                      ("rust-itertools" ,rust-itertools-0.10)
                      ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49)
                      ("rust-rusqlite" ,rust-rusqlite-0.29)
                      ("rust-serde" ,rust-serde-1)
                      ("rust-serde-json" ,rust-serde-json-1)
                      ("rust-strip-ansi-escapes" ,rust-strip-ansi-escapes-0.2)
                      ("rust-strum" ,rust-strum-0.25)
                      ("rust-strum-macros" ,rust-strum-macros-0.25)
                      ("rust-thiserror" ,rust-thiserror-1)
                      ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                      ("rust-unicode-width" ,rust-unicode-width-0.1))))
   (home-page "https://github.com/nushell/reedline")
   (synopsis "readline-like crate for CLI text input")
   (description
    "This package provides a readline-like crate for CLI text input.")
   (license license:expat)))

(define-public rust-nu-json-0.88
  (package
    (name "rust-nu-json")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-json" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "10cdqvvmchmgb3isd6c7d9qfmiapcwri9y6x066zq8s411fq5rvn"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-linked-hash-map" ,rust-linked-hash-map-0.5)
                       ("rust-num-traits" ,rust-num-traits-0.2)
                       ("rust-serde" ,rust-serde-1))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-json")
    (synopsis "Fork of serde-hjson")
    (description "This package provides Fork of serde-hjson.")
    (license license:expat)))

(define-public rust-nu-color-config-0.88
  (package
    (name "rust-nu-color-config")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-color-config" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0byaa3wmh584pgrvvsxsxagif4mnmd2j4qllxb841hr1wd5klw03"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-json" ,rust-nu-json-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-serde" ,rust-serde-1))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-color-config")
    (synopsis "Color configuration code used by Nushell")
    (description
     "This package provides Color configuration code used by Nushell.")
    (license license:expat)))

(define-public rust-nu-plugin-0.88
  (package
    (name "rust-nu-plugin")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-plugin" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0l42m2ky6iczkmv412s5ayira952fq146fpd10hjv9jq9h1g2zdj"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-bincode" ,rust-bincode-1)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-rmp-serde" ,rust-rmp-serde-1)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-plugin")
    (synopsis "Functionality for building Nushell plugins")
    (description
     "This package provides Functionality for building Nushell plugins.")
    (license license:expat)))

(define-public rust-nu-parser-0.88
  (package
    (name "rust-nu-parser")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-parser" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "07ahgrlqd3bkapxnyiq8mhcpgix50j8qy6wcyyx085d3qzc2gnq1"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-bytesize" ,rust-bytesize-1)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-itertools" ,rust-itertools-0.11)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-path" ,rust-nu-path-0.88)
                       ("rust-nu-plugin" ,rust-nu-plugin-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-serde-json" ,rust-serde-json-1))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-parser")
    (synopsis "Nushell's parser")
    (description "This package provides Nushell's parser.")
    (license license:expat)))

(define-public rust-lscolors-0.15
  (package
    (name "rust-lscolors")
    (version "0.15.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "lscolors" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "039jl8lwcw84cii5zpngs4i7jxhy2pnpjjvynympib8386h1aw5z"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-ansi-term" ,rust-ansi-term-0.12)
                       ("rust-crossterm" ,rust-crossterm-0.26)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49))))
    (home-page "https://github.com/sharkdp/lscolors")
    (synopsis "Colorize paths using the LS_COLORS environment variable")
    (description
     "This package provides Colorize paths using the LS_COLORS environment variable.")
    (license (list license:expat license:asl2.0))))

(define-public rust-nu-utils-0.88
  (package
    (name "rust-nu-utils")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-utils" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1g84zbs7c4yyc3x1wbml683amh13y9v917ags6y5jv3zvn0yv7ik"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-crossterm-winapi" ,rust-crossterm-winapi-0.9)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-lscolors" ,rust-lscolors-0.15)
                       ("rust-num-format" ,rust-num-format-0.4)
                       ("rust-strip-ansi-escapes" ,rust-strip-ansi-escapes-0.2)
                       ("rust-sys-locale" ,rust-sys-locale-0.3)
                       ("rust-unicase" ,rust-unicase-2))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-utils")
    (synopsis "Nushell utility functions")
    (description "This package provides Nushell utility functions.")
    (license license:expat)))

(define-public rust-nu-system-0.88
  (package
    (name "rust-nu-system")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-system" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1l6aaqz06vg0znyr088pbn4n35psgk784v6yjhkpnmm6v5zcvqn8"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-chrono" ,rust-chrono-0.4)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-libproc" ,rust-libproc-0.14)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mach2" ,rust-mach2-0.4)
                       ("rust-nix" ,rust-nix-0.27)
                       ("rust-ntapi" ,rust-ntapi-0.4)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-procfs" ,rust-procfs-0.16)
                       ("rust-sysinfo" ,rust-sysinfo-0.29)
                       ("rust-winapi" ,rust-winapi-0.3))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-system")
    (synopsis "Nushell system querying")
    (description "This package provides Nushell system querying.")
    (license license:expat)))

(define-public rust-nu-protocol-0.88
  (package
    (name "rust-nu-protocol")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-protocol" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0jarr4xfzppy2hvw4i74h83mxhnjlv0xbzg0s8yifqvvk5h5lfi4"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-byte-unit" ,rust-byte-unit-4)
                       ("rust-chrono" ,rust-chrono-0.4)
                       ("rust-chrono-humanize" ,rust-chrono-humanize-0.2)
                       ("rust-fancy-regex" ,rust-fancy-regex-0.11)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-lru" ,rust-lru-0.12)
                       ("rust-miette" ,rust-miette-5)
                       ("rust-nu-path" ,rust-nu-path-0.88)
                       ("rust-nu-system" ,rust-nu-system-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-num-format" ,rust-num-format-0.4)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-thiserror" ,rust-thiserror-1)
                       ("rust-typetag" ,rust-typetag-0.2))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-protocol")
    (synopsis
     "Nushell's internal protocols, including its abstract syntax tree")
    (description
     "This package provides Nushell's internal protocols, including its abstract syntax tree.")
    (license license:expat)))

(define-public rust-nu-path-0.88
  (package
    (name "rust-nu-path")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-path" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0agarl4ywszlwsiipqspd4yp7la6fsls0fw9zdfwjdr6vzird6xq"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-dirs-next" ,rust-dirs-next-2)
                       ("rust-omnipath" ,rust-omnipath-0.1)
                       ("rust-pwd" ,rust-pwd-1))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-path")
    (synopsis "Path handling library for Nushell")
    (description "This package provides Path handling library for Nushell.")
    (license license:expat)))

(define-public rust-nu-glob-0.88
  (package
    (name "rust-nu-glob")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-glob" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1zb22s6d1x56h09jybwv2n5hfb9q7g39ngsy11s3a39yxqbf5ilg"))))
    (build-system cargo-build-system)
    (arguments
     `())
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-glob")
    (synopsis
     "Fork of glob. Support for matching file paths against Unix shell style patterns.")
    (description
     "This package provides Fork of glob.  Support for matching file paths against Unix shell style
patterns.")
    (license (list license:expat license:asl2.0))))

(define-public rust-nu-engine-0.88
  (package
    (name "rust-nu-engine")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-engine" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "12vwwamp78qwbnnw06572ya8z6abjjjrg7md3g5qj789bhh4j5gk"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-nu-glob" ,rust-nu-glob-0.88)
                       ("rust-nu-path" ,rust-nu-path-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-engine")
    (synopsis "Nushell's evaluation engine")
    (description "This package provides Nushell's evaluation engine.")
    (license license:expat)))

(define-public rust-nu-cmd-base-0.88
  (package
    (name "rust-nu-cmd-base")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-cmd-base" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "172picvxcj37wwfzmribkyfa23fxjnm2b6jrf561dlhiw99dgxg1"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-indexmap" ,rust-indexmap-2)
                       ("rust-miette" ,rust-miette-5)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-glob" ,rust-nu-glob-0.88)
                       ("rust-nu-parser" ,rust-nu-parser-0.88)
                       ("rust-nu-path" ,rust-nu-path-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88))))
    (home-page
     "https://github.com/nushell/nushell/tree/main/crates/nu-cmd-base")
    (synopsis "The foundation tools to build Nushell commands")
    (description
     "This package provides The foundation tools to build Nushell commands.")
    (license license:expat)))

(define-public rust-nu-cli-0.88
  (package
    (name "rust-nu-cli")
    (version "0.88.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "nu-cli" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1h0dzmaaxzmc3198v0q5n0pp5arjbppdplv9pjmvz5dqhvjdyva3"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-chrono" ,rust-chrono-0.4)
                       ("rust-crossterm" ,rust-crossterm-0.27)
                       ("rust-fancy-regex" ,rust-fancy-regex-0.11)
                       ("rust-fuzzy-matcher" ,rust-fuzzy-matcher-0.3)
                       ("rust-is-executable" ,rust-is-executable-1)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-miette" ,rust-miette-5)
                       ("rust-nu-ansi-term" ,rust-nu-ansi-term-0.49)
                       ("rust-nu-cmd-base" ,rust-nu-cmd-base-0.88)
                       ("rust-nu-color-config" ,rust-nu-color-config-0.88)
                       ("rust-nu-engine" ,rust-nu-engine-0.88)
                       ("rust-nu-parser" ,rust-nu-parser-0.88)
                       ("rust-nu-path" ,rust-nu-path-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-nu-utils" ,rust-nu-utils-0.88)
                       ("rust-once-cell" ,rust-once-cell-1)
                       ("rust-pathdiff" ,rust-pathdiff-0.2)
                       ("rust-percent-encoding" ,rust-percent-encoding-2)
                       ("rust-reedline" ,rust-reedline-0.27)
                       ("rust-sysinfo" ,rust-sysinfo-0.29)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-uuid" ,rust-uuid-1)
                       ("rust-which" ,rust-which-5))))
    (home-page "https://github.com/nushell/nushell/tree/main/crates/nu-cli")
    (synopsis "CLI-related functionality for Nushell")
    (description
     "This package provides CLI-related functionality for Nushell.")
    (license license:expat)))

(define-public rust-completest-nu-0.4
  (package
    (name "rust-completest-nu")
    (version "0.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "completest-nu" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "08vcq18m92xlsfyaikks1ql3ipj42gqa2psnr9hmmnlcnkr1pk7z"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-completest" ,rust-completest-0.4)
                       ("rust-dunce" ,rust-dunce-1)
                       ("rust-nu-cli" ,rust-nu-cli-0.88)
                       ("rust-nu-cmd-lang" ,rust-nu-cmd-lang-0.88)
                       ("rust-nu-command" ,rust-nu-command-0.88)
                       ("rust-nu-parser" ,rust-nu-parser-0.88)
                       ("rust-nu-protocol" ,rust-nu-protocol-0.88)
                       ("rust-reedline" ,rust-reedline-0.27))))
    (home-page "https://github.com/assert-rs/completest")
    (synopsis "Run completions for your program")
    (description "This package provides Run completions for your program.")
    (license (list license:expat license:asl2.0))))

(define-public rust-clap-complete-nushell-4
  (package
    (name "rust-clap-complete-nushell")
    (version "4.5.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "clap_complete_nushell" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "12miqxh9g7q37w11bgv55b32s0hdf6avf0lhagzc5psp6icv3a66"))))
    (build-system cargo-build-system)
    (arguments
     `(
       #:cargo-inputs (("rust-clap" ,rust-clap-4)
                       ("rust-clap-complete" ,rust-clap-complete-4)
                       ("rust-completest" ,rust-completest-0.4)
                       ("rust-completest-nu" ,rust-completest-nu-0.4))))
    (home-page "https://github.com/clap-rs/clap")
    (synopsis
     "generator library used with clap for Nushell completion scripts")
    (description
     "This package provides a generator library used with clap for Nushell completion
scripts.")
    (license (list license:expat license:asl2.0))))

(define-public rust-hashbrown-0.14
  (package
    (name "rust-hashbrown")
    (version "0.14.5")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "hashbrown" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "1wa1vy1xs3mp11bn3z9dv0jricgr6a2j0zkf1g19yz3vw4il89z5"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-ahash" ,rust-ahash-0.8)
                       ("rust-allocator-api2" ,rust-allocator-api2-0.2)
                       ("rust-compiler-builtins" ,rust-compiler-builtins-0.1)
                       ("rust-equivalent" ,rust-equivalent-1)
                       ("rust-rayon" ,rust-rayon-1)
                       ("rust-rkyv" ,rust-rkyv-0.7)
                       ("rust-rustc-std-workspace-alloc" ,rust-rustc-std-workspace-alloc-1)
                       ("rust-rustc-std-workspace-core" ,rust-rustc-std-workspace-core-1)
                       ("rust-serde" ,rust-serde-1))
       #:cargo-development-inputs (("rust-bumpalo" ,rust-bumpalo-3)
                                   ("rust-doc-comment" ,rust-doc-comment-0.3)
                                   ("rust-fnv" ,rust-fnv-1)
                                   ("rust-lazy-static" ,rust-lazy-static-1)
                                   ("rust-rand" ,rust-rand-0.8)
                                   ("rust-rayon" ,rust-rayon-1)
                                   ("rust-rkyv" ,rust-rkyv-0.7)
                                   ("rust-serde-test" ,rust-serde-test-1))))
    (home-page "https://github.com/rust-lang/hashbrown")
    (synopsis "Rust port of Google's SwissTable hash map")
    (description
     "This package provides a Rust port of Google's @code{SwissTable} hash map.")
    (license (list license:expat license:asl2.0))))

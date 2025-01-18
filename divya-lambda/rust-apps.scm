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
;;; Rust applications packaged by Divya

(define-module (divya-lambda rust-apps)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system cargo)

  #:use-module (divya-lambda crates-io)

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

(define-public bottom
  (package
    (name "bottom")
    (version "0.10.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "bottom" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
        (base32 "0y9wjbzrmcvh0fvfr5cizzwzy6f18hagk970mljwhccrwdsbaapg"))))
    (build-system cargo-build-system)
    (arguments
     `(#:install-source? #f
       #:cargo-test-flags
       '("--"
         "--skip=valid_config_tests::test_all_proc"
         "--skip=valid_config_tests::test_basic"
         "--skip=valid_config_tests::test_cpu_doughnut"
         "--skip=valid_config_tests::test_empty"
         "--skip=valid_config_tests::test_filtering"
         "--skip=valid_config_tests::test_many_proc"
         "--skip=valid_config_tests::test_styling_sanity_check"
         "--skip=valid_config_tests::test_styling_sanity_check_2"
         "--skip=valid_config_tests::test_theme")
       #:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
                       ("rust-backtrace" ,rust-backtrace-0.3)
                       ("rust-cfg-if" ,rust-cfg-if-1)
                       ("rust-clap" ,rust-clap-4)
                       ("rust-clap-complete" ,rust-clap-complete-4)
                       ("rust-clap-complete-fig" ,rust-clap-complete-fig-4)
                       ("rust-clap-complete-nushell" ,rust-clap-complete-nushell-4)
                       ("rust-clap-mangen" ,rust-clap-mangen-0.2)
                       ("rust-concat-string" ,rust-concat-string-1)
                       ("rust-core-foundation" ,rust-core-foundation-0.9)
                       ("rust-crossterm" ,rust-crossterm-0.27)
                       ("rust-ctrlc" ,rust-ctrlc-3)
                       ("rust-dirs" ,rust-dirs-5)
                       ("rust-fern" ,rust-fern-0.6)
                       ("rust-filedescriptor" ,rust-filedescriptor-0.8)
                       ("rust-hashbrown" ,rust-hashbrown-0.14)
                       ("rust-humantime" ,rust-humantime-2)
                       ("rust-indexmap" ,rust-indexmap-2)
                       ("rust-indoc" ,rust-indoc-2)
                       ("rust-itertools" ,rust-itertools-0.13)
                       ("rust-libc" ,rust-libc-0.2)
                       ("rust-log" ,rust-log-0.4)
                       ("rust-mach2" ,rust-mach2-0.4)
                       ("rust-nvml-wrapper" ,rust-nvml-wrapper-0.10)
                       ("rust-ratatui" ,rust-ratatui-0.27)
                       ("rust-regex" ,rust-regex-1)
                       ("rust-rustix" ,rust-rustix-0.38)
                       ("rust-schemars" ,rust-schemars-0.8)
                       ("rust-serde" ,rust-serde-1)
                       ("rust-serde-json" ,rust-serde-json-1)
                       ("rust-starship-battery" ,rust-starship-battery-0.9)
                       ("rust-strum" ,rust-strum-0.26)
                       ("rust-sysctl" ,rust-sysctl-0.5)
                       ("rust-sysinfo" ,rust-sysinfo-0.30)
                       ("rust-time" ,rust-time-0.3)
                       ("rust-toml-edit" ,rust-toml-edit-0.22)
                       ("rust-unicode-ellipsis" ,rust-unicode-ellipsis-0.2)
                       ("rust-unicode-segmentation" ,rust-unicode-segmentation-1)
                       ("rust-unicode-width" ,rust-unicode-width-0.1)
                       ("rust-windows" ,rust-windows-0.58))
       #:cargo-development-inputs (("rust-assert-cmd" ,rust-assert-cmd-2)
                                   ("rust-cargo-husky" ,rust-cargo-husky-1)
                                   ("rust-portable-pty" ,rust-portable-pty-0.8)
                                   ("rust-predicates" ,rust-predicates-3))
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'enable-building-completions
           (lambda _
             (setenv "BTM_GENERATE" "true")))
         (add-after 'install 'install-extras
           (lambda* (#:key native-inputs outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (share (string-append out "/share"))
                    (man1 (string-append share "/man/man1"))
                    (bash-completions-dir
                     (string-append out "/etc/bash_completion.d/"))
                    (zsh-completions-dir
                     (string-append share "/zsh/site-functions"))
                    (fish-completions-dir
                     (string-append share "/fish/vendor_completions.d"))
                    (elvish-completions-dir
                     (string-append share "/elvish/lib"))
                    (nu-completions-dir
                     (string-append share "/nushell/vendor/autoload")))
               (install-file "target/tmp/bottom/manpage/btm.1" man1)
               (install-file "target/tmp/bottom/completion/_btm"
                             zsh-completions-dir)
               (install-file "target/tmp/bottom/completion/btm.fish"
                             fish-completions-dir)
               (mkdir-p bash-completions-dir)
               (copy-file "target/tmp/bottom/completion/btm.bash"
                          (string-append bash-completions-dir "/btm"))
               (mkdir-p elvish-completions-dir)
               (copy-file "target/tmp/bottom/completion/btm.elv"
                          (string-append elvish-completions-dir "/btm"))
               (mkdir-p nu-completions-dir)
               (copy-file "target/tmp/bottom/completion/btm.nu"
                          (string-append nu-completions-dir "/btm"))))))))
    (home-page "https://github.com/ClementTsang/bottom")
    (synopsis "Customizable graphical process/system monitor for the terminal")
    (description
     "This package provides a customizable graphical process/system monitor for
the terminal.")
    (license license:expat)))

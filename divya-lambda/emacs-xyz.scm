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
;;; Emacs packages for Guix

(define-module (divya-lambda emacs-xyz)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system emacs)
  #:use-module
  ((guix licenses) #:prefix license:)

  #:use-module (gnu packages xorg)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gtk))

(define-public emacs-binder
  (package
    (name "emacs-binder")
    (version "20241023.1154")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://melpa.org/packages/binder-" version ".tar"))
       (sha256
        (base32 "1nvsmmg9wwan5y38dpcpffzxxvivi4708ri64f03gwcq66g1k49m"))))
    (build-system emacs-build-system)
    (home-page "https://codeberg.org/divyaranjan/binder")
    (synopsis
     "Binder is a global minor mode to facilitate working on multiple files")
    (description "Primarily, Binder provides a global minor mode binder-mode.
This allows working with files in the current binder-project-directory.
Data concerning these files is saved in a .binder.el file in the project directory.")
    (license license:gpl3+)))

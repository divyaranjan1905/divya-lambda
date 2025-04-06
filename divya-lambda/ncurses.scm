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

(define-module (divya-lambda ncurses)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (guix licenses)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system perl)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages linux)
  #:use-module (guix utils)
  #:use-module (gnu packages ncurses))

(define-public ncurses/tinfo
  (package/inherit ncurses
    (name "ncurses-with-tinfo")
    (arguments
     (substitute-keyword-arguments (package-arguments ncurses)
       ((#:configure-flags cf)
        #~(cons (string-append "--with-termlib=tinfo" "--with-versioned-syms")  #$cf))))))

ncurses/tinfo

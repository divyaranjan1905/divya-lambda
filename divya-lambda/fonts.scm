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
;;; Divya’s favorite fonts for Guix

(define-module (divya-lambda fonts)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix build-system font)
  #:use-module
  ((guix licenses) #:prefix license:))

(define-public font-spline-sans
  (let ((commit "5196436e0714c188c70f30a93b4759e8ed8afb69")
        (revision "0"))
    (package
      (name "font-spline-sans")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/SorkinType/SplineSans")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1hs0215fhas9vc6pn1vjizv746lifwwdwjf04lclyz93raqza1id"))))
      (build-system font-build-system)
      (home-page "https://fonts.google.com/specimen/Spline+Sans")
      (synopsis
       "Grotesque sans serif typeface family, purpose-built for UI interfaces")
      (description
       "Spline Sans is a Grotesque purpose-built for UI interfaces, checkout processes,
and paragraphs of text.  Space efficiency is accomplished by condensing traditional
grotesque proportions.  The cool and restrained tone is accented with strategic \"thorn\"
traps, which blossom into view when set at larger sizes.")
      (license license:silofl1.1))))

(define-public font-spline-sans-mono
  (let ((commit "b167db03b7d7ae754bf7071c13415e7aeee7d073")
        (revision "0"))
    (package
      (name "font-spline-sans-mono")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/SorkinType/SplineSansMono")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "10ymg4mrihyfidwcszf4aiw2jlhm4j1sdmyybcmqmhx0pbzalkv1"))))
      (build-system font-build-system)
      (home-page "https://fonts.google.com/specimen/Spline+Sans+Mono")
      (synopsis
       "Monospaced Grotesque purpose-built for UI interfaces, and programming")
      (description
       "Spline Sans Mono is a Monospaced Grotesque purpose-built for UI interfaces,
checkout processes, and programming.  Space efficiency is accomplished by condensing
traditional grotesque proportions.")
      (license license:silofl1.1))))

;; (define-public font-elstob
;;   (package
;;     (name "font-elsob")
;;     (version "3.001")
;;     (source )))
font-spline-sans-mono

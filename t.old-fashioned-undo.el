;;; t.old-fashioned-undo.el -- Tests for old-fashioned-undo.el

;; Copyright (C) 2010 K-talo Miyazaki, all rights reserved.
;; Author: K-talo Miyazaki <Keitaro dot Miyazaki at gmail dot com>
;; Created: Fri Nov 19 14:13:19 2010 JST
;; Keywords: emulation wp
;; Revision: $Id$
;; URL: 
;; GitHub: http://github.com/k-talo/old-fashioned-undo.el

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; TODO
;;  - Write more tests.

(eval-when-compile
  (require 'el-test-more))

(require 'old-fashioned-undo)

;; Test `old-fashioned-undo/lst/split'.
;;
(let ((lst nil))
  (etm/eq (old-fashioned-undo/lst/get-next lst :chunk-p nil)
          nil
          "old-fashioned-undo/lst/get-next: 1"))

(let ((lst nil))
  (etm/eq (old-fashioned-undo/lst/get-next lst :chunk-p t)
          nil
          "old-fashioned-undo/lst/get-next: 2"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d"))))
  (etm/equal (old-fashioned-undo/lst/get-next lst :chunk-p nil)
             '(("b") ("c") nil ("d"))
             "old-fashioned-undo/lst/get-next: 3"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d"))))
  (etm/equal (old-fashioned-undo/lst/get-next lst :chunk-p t)
             '(nil ("d"))
             "old-fashioned-undo/lst/get-next: 4"))


;; Test `old-fashioned-undo/lst/split'.
;;
(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 0)
             0
             "old-fashioned-undo/lst/split: 0")
  (etm/equal lst
             '(nil ("a") ("b") ("c") nil ("d") ("e"))
             "old-fashioned-undo/lst/split: 0"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 1)
             1
             "old-fashioned-undo/lst/split: 1")
  (etm/equal lst
             '(nil ("a") nil ("b") ("c") nil ("d") ("e"))
             "old-fashioned-undo/lst/split: 1"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 2)
             2
             "old-fashioned-undo/lst/split: 2")
  (etm/equal lst
             '(nil ("a") nil ("b") nil ("c") nil ("d") ("e"))
             "old-fashioned-undo/lst/split: 2"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 3)
             2
             "old-fashioned-undo/lst/split: 3")
  (etm/equal lst
             '(nil ("a") nil ("b") nil ("c") nil ("d") ("e"))
             "old-fashioned-undo/lst/split: 3"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 3)
             2
             "old-fashioned-undo/lst/split: 3")
  (etm/equal lst
             '(nil ("a") nil ("b") nil ("c") nil ("d") ("e"))
             "old-fashioned-undo/lst/split: 3"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 4)
             3
             "old-fashioned-undo/lst/split: 4")
  (etm/equal lst
             '(nil ("a") nil ("b") nil ("c") nil ("d") nil ("e"))
             "old-fashioned-undo/lst/split: 4"))

(let ((lst '(nil ("a") ("b") ("c") nil ("d") ("e"))))
  (etm/=     (old-fashioned-undo/lst/split lst :limit 5)
             3
             "old-fashioned-undo/lst/split: 5")
  (etm/equal lst
             '(nil ("a") nil ("b") nil ("c") nil ("d") nil ("e"))
             "old-fashioned-undo/lst/split: 5"))

;; t.lenear-undo.el ends here

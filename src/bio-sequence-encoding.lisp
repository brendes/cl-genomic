;;;
;;; Copyright (C) 2007-2008, Keith James. All rights reserved.
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;

(in-package :bio-sequence)

(defun complement-dna (base)
  "Returns the complentary DNA base to that represented by the
character BASE."
  (ecase base
    ((#\t #\T) #\a)
    ((#\c #\C) #\g)
    ((#\a #\A) #\t)
    ((#\g #\G) #\c)
    ((#\r #\R) #\y)
    ((#\y #\Y) #\r)
    ((#\k #\K) #\m)
    ((#\m #\M) #\k)
    ((#\s #\S) #\s)
    ((#\w #\W) #\w)
    ((#\b #\B) #\v)
    ((#\d #\D) #\h)
    ((#\h #\H) #\d)
    ((#\v #\V) #\b)
    ((#\n #\N) #\n)))

(defun complement-rna (base)
  "Returns the complentary RNA base to that represented by the
character BASE."
  (ecase base
    ((#\u #\U) #\a)
    ((#\c #\C) #\g)
    ((#\a #\A) #\u)
    ((#\g #\G) #\c)
    ((#\r #\R) #\y)
    ((#\y #\Y) #\r)
    ((#\k #\K) #\m)
    ((#\m #\M) #\k)
    ((#\s #\S) #\s)
    ((#\w #\W) #\w)
    ((#\b #\B) #\v)
    ((#\d #\D) #\h)
    ((#\h #\H) #\d)
    ((#\v #\V) #\b)
    ((#\n #\N) #\n)))

(declaim (inline complement-dna-2bit))
(defun complement-dna-2bit (encoded-base)
  "Returns the complentary encoded DNA base to that represented by
ENCODED-BASE."
  (ecase encoded-base
    (#b00 #b10)
    (#b01 #b11)
    (#b10 #b00)
    (#b11 #b01)))

(declaim (inline complement-rna-2bit))
(defun complement-rna-2bit (encoded-base)
  "Returns the complentary encoded RNA base to that represented by
ENCODED-BASE."
  (ecase encoded-base
    (#b00 #b10)
    (#b01 #b11)
    (#b10 #b00)
    (#b11 #b01)))

(declaim (inline complement-dna-4bit))
(defun complement-dna-4bit (encoded-base)
  "Returns the complentary encoded DNA base to that represented by
ENCODED-BASE."
  (ecase encoded-base
    (#b0001 #b0100)
    (#b0010 #b1000)
    (#b0100 #b0001)
    (#b1000 #b0010)
    (#b1100 #b0011)
    (#b0011 #b1100)
    (#b1001 #b0110)
    (#b0110 #b1001)
    (#b1010 #b1010)
    (#b0101 #b0101)
    (#b1011 #b1110)
    (#b1101 #b0111)
    (#b0111 #b1101)
    (#b1110 #b1011)
    (#b1111 #b1111)))

(declaim (inline complement-rna-4bit))
(defun complement-rna-4bit (encoded-base)
  "Returns the complentary encoded RNA base to that represented by
ENCODED-BASE."
  (ecase encoded-base
    (#b0001 #b0100)
    (#b0010 #b1000)
    (#b0100 #b0001)
    (#b1000 #b0010)
    (#b1100 #b0011)
    (#b0011 #b1100)
    (#b1001 #b0110)
    (#b0110 #b1001)
    (#b1010 #b1010)
    (#b0101 #b0101)
    (#b1011 #b1110)
    (#b1101 #b0111)
    (#b0111 #b1101)
    (#b1110 #b1011)
    (#b1111 #b1111)))

(declaim (inline encode-dna-2bit))
(defun encode-dna-2bit (base)
  "Encodes DNA standard-char BASE as a 2-bit byte, representing T as
00, C as 01, A as 10 G and 11. The first base is in the most
significant 2-bit byte and the last base is in the least significant
2-bit byte."
  (ecase base
    ((#\t #\T) #b00)
    ((#\c #\C) #b01)
    ((#\a #\A) #b10)
    ((#\g #\G) #b11)))

(declaim (inline decode-dna-2bit))
(defun decode-dna-2bit (encoded-base)
  (ecase encoded-base
    (#b00 #\t)
    (#b01 #\c)
    (#b10 #\a)
    (#b11 #\g)))

(declaim (inline encode-dna-comp-2bit))
(defun encode-dna-comp-2bit (base)
  (encode-dna-2bit (complement-dna base)))

(declaim (inline decode-dna-comp-2bit))
(defun decode-dna-comp-2bit (encoded-base)
  (complement-dna (decode-dna-2bit encoded-base)))

(declaim (inline encode-dna-4bit))
(defun encode-dna-4bit (base)
  "Encodes DNA standard-char BASE as a 4-bit byte, representing T as
0001, C as 0010, A as 0100 and G as 1000.  The first base is in the
most significant 4-bit byte and the last base is in the least
significant 4-bit byte. Ambiguous bases are represented by bitwise AND
combinations of these."
  (ecase base
    ((#\t #\T) #b0001)
    ((#\c #\C) #b0010)
    ((#\a #\A) #b0100)
    ((#\g #\G) #b1000)
    ((#\r #\R) #b1100)
    ((#\y #\Y) #b0011)
    ((#\k #\K) #b1001)
    ((#\m #\M) #b0110)
    ((#\s #\S) #b1010)
    ((#\w #\W) #b0101)
    ((#\b #\B) #b1011)
    ((#\d #\D) #b1101)
    ((#\h #\H) #b0111)
    ((#\v #\V) #b1110)
    ((#\n #\N) #b1111)))

(declaim (inline decode-dna-4bit))
(defun decode-dna-4bit (encoded-base)
  (ecase encoded-base
    (#b0001 #\t)
    (#b0010 #\c)
    (#b0100 #\a)
    (#b1000 #\g)
    (#b1100 #\r)
    (#b0011 #\y)
    (#b1001 #\k)
    (#b0110 #\m)
    (#b1010 #\s)
    (#b0101 #\w)
    (#b1011 #\b)
    (#b1101 #\d)
    (#b0111 #\h)
    (#b1110 #\v)
    (#b1111 #\n)))

(declaim (inline encode-dna-comp-4bit))
(defun encode-dna-comp-4bit (base)
  (encode-dna-4bit (complement-dna base)))

(declaim (inline decode-dna-comp-4bit))
(defun decode-dna-comp-4bit (encoded-base)
  (complement-dna (decode-dna-4bit encoded-base)))

(declaim (inline encode-rna-2bit))
(defun encode-rna-2bit (base)
  "Encodes RNA standard-char BASE as a 2-bit byte, representing U as
00, C as 01, A as 10 G and 11. The first base is in the most
significant 2-bit byte and the last base is in the least significant
two-bit byte."
  (ecase base
    ((#\u #\U) #b00)
    ((#\c #\C) #b01)
    ((#\a #\A) #b10)
    ((#\g #\G) #b11)))

(declaim (inline decode-rna-2bit))
(defun decode-rna-2bit (encoded-base)
  (ecase encoded-base
    (#b00 #\u)
    (#b01 #\c)
    (#b10 #\a)
    (#b11 #\g)))

(declaim (inline encode-rna-comp-2bit))
(defun encode-rna-comp-2bit (base)
  (encode-rna-2bit (complement-rna base)))

(declaim (inline decode-rna-comp-2bit))
(defun decode-rna-comp-2bit (encoded-base)
  (complement-rna (decode-rna-2bit encoded-base)))

(declaim (inline encode-rna-4bit))
(defun encode-rna-4bit (base)
  "Encodes RNA standard-char BASE as a 4-bit byte, representing U as
0001, C as 0010, A as 0100 and G as 1000.  The first base is in the
most significant 4-bit byte and the last base is in the least
significant 4-bit byte. Ambiguous bases are represented by bitwise AND
combinations of these."
  (ecase base
    ((#\u #\U) #b0001)
    ((#\c #\C) #b0010)
    ((#\a #\A) #b0100)
    ((#\g #\G) #b1000)
    ((#\r #\R) #b1100)
    ((#\y #\Y) #b0011)
    ((#\k #\K) #b1001)
    ((#\m #\M) #b0110)
    ((#\s #\S) #b1010)
    ((#\w #\W) #b0101)
    ((#\b #\B) #b1011)
    ((#\d #\D) #b1101)
    ((#\h #\H) #b0111)
    ((#\v #\V) #b1110)
    ((#\n #\N) #b1111)))

(declaim (inline decode-rna-4bit))
(defun decode-rna-4bit (encoded-base)
  (ecase encoded-base
    (#b0001 #\u)
    (#b0010 #\c)
    (#b0100 #\a)
    (#b1000 #\g)
    (#b1100 #\r)
    (#b0011 #\y)
    (#b1001 #\k)
    (#b0110 #\m)
    (#b1010 #\s)
    (#b0101 #\w)
    (#b1011 #\b)
    (#b1101 #\d)
    (#b0111 #\h)
    (#b1110 #\v)
    (#b1111 #\n)))

(declaim (inline encode-rna-comp-4bit))
(defun encode-rna-comp-4bit (base)
  (encode-rna-4bit (complement-rna base)))

(declaim (inline decode-rna-comp-4bit))
(defun decode-rna-comp-4bit (encoded-base)
  (complement-rna (decode-rna-4bit encoded-base)))

;; (declaim (inline encode-aa-8bit))
;; (defun encode-aa-8bit (aa)
;;   (ccase aa
;;     (#\A 0)
;;     (#\B 1)
;;     (#\C 2)
;;     (#\D 3)
;;     (#\E 4)
;;     (#\F 5)
;;     (#\G 6)
;;     (#\H 7)
;;     (#\I 8)
;;     (#\J 9)
;;     (#\K 10)
;;     (#\L 11)
;;     (#\M 12)
;;     (#\N 13)
;;     (#\O 14)
;;     (#\P 15)
;;     (#\Q 16)
;;     (#\R 17)
;;     (#\S 18)
;;     (#\T 19)
;;     (#\U 20)
;;     (#\V 21)
;;     (#\W 22)
;;     (#\X 23)
;;     (#\Y 24)
;;     (#\Z 25)))

;; (declaim (inline encode-octet-2bit))
;; (defun encode-octet-2bit (base)
;;   (ecase base
;;     ((116 84) #b00)
;;     ((99 67) #b01)
;;     ((97 65) #b10)
;;     ((103 71) #b11)))

;; (declaim (inline encode-octet-4bit))
;; (defun encode-octet-4bit (base)
;;   (ecase base
;;     ((116 84) #b0001)
;;     ((99 67) #b0010)
;;     ((97 65) #b0100)
;;     ((103 71) #b1000)
;;     ((114 82) #b1100)
;;     ((121 89) #b0011)
;;     ((107 75) #b1001)
;;     ((109 77) #b0110)
;;     ((115 83) #b1010)
;;     ((119 87) #b0101)
;;     ((98 66) #b1011)
;;     ((100 68) #b1101)
;;     ((104 72) #b0111)
;;     ((118 86) #b1110)
;;     ((110 78) #b1111)))

(defun phred-quality (p)
  "Returns the Phred score of a base where P is the error
probability."
  (round (* -10 (/ (log p)
                   (log 10)))))

(defun encode-phred-quality (q)
  "Returns the character encoding of the Phred quality score Q."
  (code-char (+ 33 (if (< 93 q)
                       93
                     q))))

(defun decode-phred-quality (c)
  "Returns the Phred quality score encoded by the character C."
  (- (char-code c) 33))

(defun illumina-quality (p)
  "Returns the Illumina score of a base where P is the error
probability."
  (let ((denom (- 1 p)))
    (if (zerop denom)
        -20
      (round (* -10 (/ (log (/ p denom))
                       (log 10)))))))

(defun encode-illumina-quality (q)
  "Returns a character encoding of the Illumina quality score Q."
  (code-char (+ 64 q)))

(defun decode-illumina-quality (c)
  "Returns the Illumina quality score encoded by the character C."
  (- (char-code c) 64))

(defun illumina-to-phred-quality (q)
  "Returns the Phred quality score corresponding to the Illumina
quality score Q."
  (* 10 (/ (log (1+ (expt 10 (/ q 10))))
           (log 10))))

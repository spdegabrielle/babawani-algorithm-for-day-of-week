#lang racket/base
;Babwani’s Algorithm to find the day of the week.
; from http://www.babwani-congruence.blogspot.co.uk/
(provide Babwani’s-Algorithm)

(define (Babwani’s-Algorithm d month year)
  (define (leapyear? y)
    (or (and (= (modulo y 100) 0) (not (= (modulo y 400) 0))) ; not leap
        (= (modulo y 4) 0)))
  
  (define (century-num y) (quotient y 100))
  
  ;1. Accept the date, month & year. Check whether the date is valid.
  ;2. If the date falls before 15 October 1582 go to Julian part for finding the day of the week..
  ;3. [To find whether a year is leap or not]
  (define L (if (leapyear? year) 1 0))
  (define c (century-num year))
  ; fm=int(3+(2-L)*int((month+2)/(2*month))+(5*month+int(month/9))/2)
  (define fm (floor (+ 3 (* (- 2 L) (floor (/ (+ month 2) (* month 2)))) 
                       (/ (+ (* 5 month) (floor (/ month 9))) 2))))
  (define yy (- year (* c 100))) ;[This will give the last two digits of the year] 
  (define day_n (floor (+ (* 1.25 yy) fm (- d (* 2 (modulo c 4))))))
  (define daynum (modulo day_n 7))
  
  ; if dayn=0; day= Saturday
; if dayn=1; day= Sunday
; if dayn=2; day= Monday
; if dayn=3; day= Tuesday
; if dayn=4; day= Wednesday
; if dayn=5; day= Thursday 
; if dayn=6; day= Friday
  
  daynum)
;; test
(= (Babwani’s-Algorithm 4 1 1970) 1.0)
(= (Babwani’s-Algorithm 15 1 1986) 4.0)

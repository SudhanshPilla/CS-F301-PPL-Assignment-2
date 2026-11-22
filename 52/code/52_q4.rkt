#lang racket/base
;; S2: Conditionally insert into a nested list.

;; Length of () is the count so far; otherwise count one more and continue.
(define (my-length lst)
  (let loop ((remaining lst) (count 0))
    (if (null? remaining)
        count
        (loop (cdr remaining) (+ count 1)))))

;; Map of () is (); otherwise f of the first element consed onto the map of the rest.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst)) (my-map f (cdr lst)))))

;; A value is a list exactly when it is () or a pair.
(define (is-list? e)
  (or (null? e) (pair? e)))

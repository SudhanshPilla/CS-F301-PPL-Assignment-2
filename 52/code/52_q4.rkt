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


;; Returns a function of one list: process sublists recursively, then put x
;; in front if len-ok? holds for the ORIGINAL length of the list.
(define (make-inserter x len-ok?)
  (letrec ((walk (lambda (lst)
                   (let ((processed (my-map (lambda (e) (if (is-list? e) (walk e) e))
                                            lst)))
                     (if (len-ok? (my-length lst))
                         (cons x processed)
                         processed)))))
    walk))

;; Insert x in front of every list whose length is less than n.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))


;; Read x, lst, n in that order from standard input and display the result.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))

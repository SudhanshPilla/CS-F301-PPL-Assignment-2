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


;; Process every sublist recursively (atoms unchanged); then put x in front
;; if the ORIGINAL length of lst is less than n.
(define (insert-if-short x lst n)
  (let ((processed (my-map (lambda (e) (if (is-list? e) (insert-if-short x e n) e))
                           lst)))
    (if (< (my-length lst) n)
        (cons x processed)
        processed)))

;; Read x, lst, n in that order from standard input and display the result.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))

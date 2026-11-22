#lang racket
;; S1 tests. Run from repo root: racket 52/tests/52_q3_tests.rkt
;; Loads the solution's definitions (the file has no provide) and checks printed output.
(require rackunit racket/runtime-path)
(define-runtime-path code-file "../code/52_q3.rkt")

(define (read-forms path)
  (call-with-input-file path
    (lambda (in)
      (read-line in)                                   ; skip #lang line
      (let loop ([acc '()])
        (define f (read in))
        (if (eof-object? f) (reverse acc) (loop (cons f acc)))))))

(define forms (read-forms code-file))
(define ns (make-base-namespace))
(for ([f forms]) (eval f ns))
(define (run expr) (with-output-to-string (lambda () (eval expr ns))))

;; Only allowed built-ins are used.
(define forbidden '(set! length append reverse map filter member memq list-ref list-tail
                    list? symbol? number? apply foldl foldr when unless null empty first
                    rest vector printf format provide))
(define (symbols-in x)
  (cond [(symbol? x) (list x)]
        [(pair? x) (append (symbols-in (car x)) (symbols-in (cdr x)))]
        [else '()]))
(check-equal? (filter (lambda (s) (memq s forbidden)) (symbols-in forms)) '())

;; Examples from the assignment.
(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(check-equal? (run `(print-inorder ',t1)) "(1 2 3 4 5 6 7)\n")
(check-equal? (run `(print-all-traversals ',t1))
              "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n")
(check-equal? (run `(print-height-and-leaves ',t1)) "(3 4)\n")
(check-equal? (run `(print-all-traversals ',t2)) "(1 2 3)\n(1 2 3)\n(3 2 1)\n")
(check-equal? (run `(print-height-and-leaves ',t2)) "(3 1)\n")
(check-equal? (run `(print-all-traversals ',t3)) "(b a c)\n(a b c)\n(b c a)\n")
(check-equal? (run `(print-height-and-leaves ',t3)) "(2 2)\n")
(check-equal? (run '(print-inorder '())) "()\n")
(check-equal? (run '(print-all-traversals '())) "()\n()\n()\n")
(check-equal? (run '(print-height-and-leaves '())) "(0 0)\n")

;; Own edge cases: single node, left-only chain.
(check-equal? (run '(print-all-traversals '(9 () ()))) "(9)\n(9)\n(9)\n")
(check-equal? (run '(print-height-and-leaves '(9 () ()))) "(1 1)\n")
(define chain '(3 (2 (1 () ()) ()) ()))
(check-equal? (run `(print-all-traversals ',chain)) "(1 2 3)\n(3 2 1)\n(1 2 3)\n")
(check-equal? (run `(print-height-and-leaves ',chain)) "(3 1)\n")
(displayln "S1 tests finished")

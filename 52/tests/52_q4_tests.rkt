#lang racket
;; S2 tests. Run from repo root: racket 52/tests/52_q4_tests.rkt
(require rackunit racket/runtime-path)
(define-runtime-path code-file "../code/52_q4.rkt")

(define (read-forms path)
  (call-with-input-file path
    (lambda (in)
      (read-line in)
      (let loop ([acc '()])
        (define f (read in))
        (if (eof-object? f) (reverse acc) (loop (cons f acc)))))))

(define forms (read-forms code-file))
(define ns (make-base-namespace))
(for ([f forms]) (eval f ns))
(define (run-stdin input)
  (with-output-to-string
    (lambda ()
      (parameterize ([current-input-port (open-input-string input)])
        (eval '(print-insert-result) ns)))))
(define (call expr) (eval expr ns))

;; Only allowed built-ins; single definition of insert-if-short.
(define forbidden '(set! length append reverse map filter member memq list-ref list-tail
                    list? symbol? number? apply foldl foldr when unless null empty first
                    rest vector printf format provide))
(define (symbols-in x)
  (cond [(symbol? x) (list x)]
        [(pair? x) (append (symbols-in (car x)) (symbols-in (cdr x)))]
        [else '()]))
(check-equal? (filter (lambda (s) (memq s forbidden)) (symbols-in forms)) '())
(check-equal? (length (filter (lambda (f) (and (pair? f) (pair? (cadr f))
                                               (eq? (caadr f) 'insert-if-short)))
                              forms))
              1)

;; Examples from the assignment.
(check-equal? (run-stdin "42 ((1 2) (3 4 5) (6) ()) 3") "((42 1 2) (3 4 5) (42 6) (42))\n")
(check-equal? (run-stdin "0 (((1) 2) (3) ((4 5 6) ())) 3") "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))\n")
(check-equal? (run-stdin "7 () 3") "(7)\n")
(check-equal? (run-stdin "7 () 0") "()\n")

;; Own cases.
(check-equal? (call '(my-length '(1 (2 3) () 4))) 4)
(check-equal? (call '(my-map (lambda (v) (* v 2)) '(1 2 3))) '(2 4 6))
(check-equal? (call '(insert-if-short 'x '(a b) 2)) '(a b))
(check-equal? (call '(insert-if-short 'x '(a (b)) 3)) '(x a (x b)))
(check-equal? (call '((make-inserter 'q (lambda (len) (= len 2))) '((1 2) 3)))
              '(q (q 1 2) 3))

;; Hidden-test sizes: nesting depth 100 and 10,000 elements.
(define deep (for/fold ([a '(1)]) ([i 99]) (list a)))
(define deep-expected (for/fold ([a '(x 1)]) ([i 99]) (list 'x a)))
(check-equal? (run-stdin (format "x ~s 2" deep)) (format "~a\n" deep-expected))
(define big (for/list ([i 10000]) i))
(check-equal? (run-stdin (format "x ~s 5" big)) (format "~a\n" big))
(check-equal? (run-stdin (format "x ~s 10001" big)) (format "~a\n" (cons 'x big)))
(displayln "S2 tests finished")

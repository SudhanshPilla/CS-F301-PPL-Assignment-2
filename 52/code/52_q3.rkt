#lang racket/base
;; S1: Binary tree traversals.
;; A tree is () or (value left right): car = value, cadr = left, caddr = right.

;; Inorder of () is acc. Inorder of a node is inorder(left), then value,
;; then inorder(right), then acc. Built right-to-left so no append is needed.
(define (inorder-acc tree acc)
  (if (null? tree)
      acc
      (inorder-acc (cadr tree)
                   (cons (car tree) (inorder-acc (caddr tree) acc)))))

;; Display the inorder list on one line.
(define (print-inorder tree)
  (display (inorder-acc tree '()))
  (newline))

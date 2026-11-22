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


;; Preorder of () is acc. Preorder of a node is value, then preorder(left),
;; then preorder(right), then acc.
(define (preorder-acc tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-acc (cadr tree) (preorder-acc (caddr tree) acc)))))

;; Postorder of () is acc. Postorder of a node is postorder(left),
;; then postorder(right), then value, then acc.
(define (postorder-acc tree acc)
  (if (null? tree)
      acc
      (postorder-acc (cadr tree)
                     (postorder-acc (caddr tree) (cons (car tree) acc)))))

;; Print inorder, preorder and postorder lists on three lines.
(define (print-all-traversals tree)
  (display (inorder-acc tree '()))
  (newline)
  (display (preorder-acc tree '()))
  (newline)
  (display (postorder-acc tree '()))
  (newline))


;; Height of () is 0; height of a node is 1 + max of its subtrees' heights.
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree)) (tree-height (caddr tree))))))

;; () has no leaves; a node with two empty subtrees is one leaf;
;; otherwise the leaves are those of the left plus those of the right.
(define (leaf-count tree)
  (cond ((null? tree) 0)
        ((and (null? (cadr tree)) (null? (caddr tree))) 1)
        (else (+ (leaf-count (cadr tree)) (leaf-count (caddr tree))))))

;; Display (height leaf-count) on one line.
(define (print-height-and-leaves tree)
  (display (list (tree-height tree) (leaf-count tree)))
  (newline))

#lang racket

(provide node)
(provide node-value)
(provide bst)
(provide insert)
(provide insert-from-list)
(provide delete)
(provide delete-from-list)
(provide get-iop-path)
(provide traverse)
(provide find)
(provide nl-to-vl)
(provide nl-to-all)
(provide random-list)

;================================================
; structs for node and bst
;================================================

(struct node (value count left right) #:mutable #:transparent)
(struct bst (root) #:mutable #:transparent)


;================================================
; traverse
;================================================
(define (traverse t)
  (cond
    ((empty? (bst-root t)) null)
    (else (traverse-node (bst-root t)))
    )
  )

;================================================
; traverse-node
;================================================
(define (traverse-node n)
  (cond
    ((empty? n) null)
    (else (append (traverse-node (node-left n))
                  (list n)
                  (traverse-node (node-right n))))
    )
  )


;================================================
; nl-to-vl
;================================================
(define (nl-to-vl x)
  (cond
    ((empty? x) null)
    (else (cons (node-value (car x)) (nl-to-vl (cdr x))))
    )
  )


;================================================
; find
;================================================
(define (find t v)
  (cond
    ((empty? (bst-root t)) null)
    (else (find-node (bst-root t) v))
    )
  )


;================================================
; find-node
;================================================
(define (find-node n v)
  (cond
    ((= v (node-value n)) (list n))
    ((and (< v (node-value n))
          (empty? (node-left n))) (list n))
    ((and (> v (node-value n))
          (empty? (node-right n))) (list n))
    ((< v (node-value n))
          (append (find-node (node-left n) v) (list n)))
    ((> v (node-value n))
          (append (find-node (node-right n) v) (list n)))
    )
  )


;================================================
; insert
;================================================
(define (insert t v)
  (cond
    ((empty? (bst-root t)) (set-bst-root! t (node v 1 null null)))
    (else (insert-node v (find t v)))
    )
  )


;================================================
; insert-node
;================================================
(define (insert-node v path)
  (cond
    ((= v (node-value (car path)))
              (set-node-count! (car path) (+ 1 (node-count (car path)))))
    ((< v (node-value (car path)))
              (set-node-left! (car path) (node v 1 null null)))
    (else (set-node-right! (car path) (node v 1 null null)))
    )
  )


;================================================
; random-value
;================================================
(define (random-value r)
  (inexact->exact (floor (* (random) r)))
  )


;================================================
; random-list
;================================================
(define (random-list n r)
  (cond
    ((= n 1) (list (random-value r)))
    (else (cons (random-value r) (random-list (- n 1) r)))
    )
  )


;================================================
; delete
;================================================
(define (delete t v)
  (let ((path (find t v)))
    (cond
      ((empty? (bst-root t)) )
      ((not (= v (node-value (car path)))) )
      ((and (= v (node-value (car path))) (> (node-count (car path)) 1))
       (set-node-count! (car path) (- (node-count (car path)) 1)))
      ((and (= v (node-value (car path))) (equal? (car path) (bst-root t)))
       (cond
         ((= 0 (child-count (car path))) (set-bst-root! t null))
         ((and (= 1 (child-count (car path))) (not (empty? (node-left (car path)))))
          (set-bst-root! t (node-left (car path))))
         ((and (= 1 (child-count (car path))) (not (empty? (node-right (car path)))))
          (set-bst-root! t (node-right (car path))))
         )
       )
      (else (delete-node path))
      )
    )
  )


;================================================
; delete-node
;================================================
(define (delete-node path)
  (let ((n (car path)))
    (cond
      ((= 0 (child-count n)) (delete-node-0 path))
      ((= 1 (child-count n)) (delete-node-1 path))
      (else (delete-node-2 path))
      )
    )
  )


;================================================
; delete-node-0
;================================================
(define (delete-node-0 path)
  (cond
    ((equal? (node-left (cadr path)) (car path))
     (set-node-left! (cadr path) null))
    ((equal? (node-right (cadr path)) (car path))
     (set-node-right! (cadr path) null))
    )
  )


;================================================
; delete-node-1
;================================================
(define (delete-node-1 path)
  (let ((n (car path)) (p (cadr path)))
    (cond
      ((and (equal? (node-left p) n) (not (empty? (node-left n)))) ; node is left of parent and has left child 
       (set-node-left! p (node-left n)))
      ((and (equal? (node-left p) n) (not (empty? (node-right n)))) ; node is left of parent and has right child
       (set-node-left! p (node-right n)))
      ((and (equal? (node-right p) n) (not (empty? (node-left n)))) ; node is right of parent and has left child
       (set-node-right! p (node-left n)))
      ((and (equal? (node-right p) n) (not (empty? (node-right n)))) ; node is right of parent and has right child
       (set-node-right! p (node-right n)))
      )
    )
  )


;================================================
; delete-node-2
;================================================
(define (delete-node-2 path)
  (let ((ioppath (get-iop-path (car path))))
    (set-node-value! (car path) (node-value (car ioppath)))
    (set-node-count! (car path) (node-count (car ioppath)))
    (delete-node ioppath)
    )
  )


;================================================
; child-count
;================================================
(define (child-count n)
    (cond
      ((and (not (empty? (node-left n)))
            (not (empty? (node-right n)))) 2)
      ((not (empty? (node-left n))) 1)
      ((not (empty? (node-right n))) 1)
      (else 0)
      )
  )


;================================================
; get-iop-path
;================================================
(define (get-iop-path n)
  (append (get-iop-path-right (node-left n)) (list n))
  )


;================================================
; get-iop-path-right
;================================================
(define (get-iop-path-right n)
  (cond
    ((empty? (node-right n)) (list n))
    (else (append (get-iop-path-right (node-right n)) (list n)))
    )
  )


;================================================
; insert-from-list
;================================================
(define (insert-from-list t y)
  (map (lambda (x) (insert t x) (displayln (nl-to-vl (traverse t)))) y) (void)
  )


;================================================
; delete-from-list
;================================================
(define (delete-from-list t y)
  (cond
    ((empty? y) )
    (else (delete-from-list t (cdr y)) (delete t (car y)) (displayln (nl-to-vl (traverse t))))
    )
  )
    

;================================================
; get-child-node-values
;================================================
(define (get-child-node-values n)
  (cond
    ((and(empty? (node-left n))(empty? (node-right n)))
     (list 'X 'X))
    ((and(empty? (node-left n))(not(empty? (node-right n))))
     (list 'X (node-value (node-right n))))
    ((and(not(empty? (node-left n)))(empty? (node-right n)))
     (list (node-value (node-left n)) 'X))
    (else
     (list (node-value(node-left n))(node-value(node-right n))))
    )
  )


;================================================
; get-node-fields
;================================================
(define (get-node-fields n)
  (cond
    ((empty? n) "X")
    (else (append (list (node-value n) (node-count n)) (get-child-node-values n)))
    )
  )


;================================================
; nl-to-all
;================================================
(define (nl-to-all x)
  (cond
    ((empty? x) (list 'X))
    (else (append (list (get-node-fields (car x))) (nl-to-all (cdr x))))
    )
  )

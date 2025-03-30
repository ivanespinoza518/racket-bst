#lang racket

(require "Racket_BST_Defs.rkt")

;================================================
; Required Test Cases
;================================================
; Test Case #1: (get-iop-path)
(define q (bst null)) ; build tree
(define qlist '(50 25 75 70 80 72 71 74 73))
(insert-from-list q qlist)

(define n75 (car (find q 75))) ; find node 75
(node-value n75)

(nl-to-vl (get-iop-path n75)) 


; Test Case #2: Delete Subcases
(define bst-1 (bst null))

; --- delete cases that change root
; --- delete case 0.1
(displayln "") (displayln "delete case 0.1")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50))
(nl-to-all (traverse bst-1)) ; ((50 1 X X) X) (50 is root)
(delete bst-1 50)
(nl-to-all (traverse bst-1)) ; (X) (root is null)

; --- delete case 1.1
(displayln "") (displayln "delete case 1.1")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 50)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 1.2
(displayln "") (displayln "delete case 1.2")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 75))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 50)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete cases that don't change root
; --- delete case 0.2
(displayln "") (displayln "delete case 0.2")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 25)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 0.3
(displayln "") (displayln "delete case 0.3")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 75))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 75)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 1.3
(displayln "") (displayln "delete case 1.3")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25 12))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 25)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 1.4
(displayln "") (displayln "delete case 1.4")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25 35))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 25)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)
; --- delete case 1.5
(displayln "") (displayln "delete case 1.5")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 75 60))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 75)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 1.6
(displayln "") (displayln "delete case 1.6")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 75 85))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 75)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 2.1 #1
(displayln "") (displayln "delete case 2.1 #1")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25 75 12 30))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 25)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 2.1 #2
(displayln "") (displayln "delete case 2.1 #2")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25 75 12 30 10))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 25)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)

; --- delete case 2.2
(displayln "") (displayln "delete case 2.2")
(set! bst-1 (bst null))
(insert-from-list bst-1 '(50 25 75 12 30 10 13 14))
(nl-to-all (traverse bst-1)) ; ((25 1 X X) (50 1 25 X) X) (50 is root)
(delete bst-1 25)
(nl-to-all (traverse bst-1)) ; ((25 1 X X) X) (25 is root)


;Delete Case #3: Combined Insert/Delete Cases
(displayln "") (displayln "Test Case #3: Combined Insert/Delete Cases")
(define bst-2 (bst null)) ; initially empty bst

(define list-1 (random-list 10 1000)) ; list of 10 random numbers
;(define list-1 '(954 897 907 925 449 157 454 829 559 980))
(displayln list-1)

(displayln "")

(insert-from-list bst-2 list-1) ; insert numbers from list into bst
(displayln "")
(nl-to-vl (traverse bst-2)) ; snapshot of tree
(displayln "")

(delete-from-list bst-2 list-1) ; delete numbers from list from bst
(displayln "")
(nl-to-vl (traverse bst-2)) ; snapshot of tree
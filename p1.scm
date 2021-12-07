(load "helpers.scm")
(load "i1.scm")

; O(7n) + O(3*n^l) - can easily be improved
(define (sonar l n)
  (define (iter old-sum history future i)
    (define (continue? i sum)
      (if (null? future)
          i
          (iter sum (cons (car future) history) (cdr future) i)))
    (define (compare? new-sum)
      (if (> new-sum old-sum)
          (continue? (+ i 1) new-sum)
          (continue? i new-sum)))
    (compare? (reduce + (take n history))))
  (iter (reduce + (cons 1 (take n l))) (reverse (take n l)) (skip n l) 0))

(sonar puzzle-input 1)
(sonar puzzle-input 3)

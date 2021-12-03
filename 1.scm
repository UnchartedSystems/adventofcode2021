; O(l)
(define (reverse l)
  (define (iter ol nl)
    (if (null? ol)
        nl
        (iter (cdr ol) (cons (car ol) nl))))
  (iter l `()))

; O(2n) due to reverse.
(define (take n l)
  (define (iter n ol nl)
    (if (or (< n 1) (null? l))
        (reverse nl)
        (iter (- n 1) (cdr ol) (cons (car ol) nl))))
  (iter n l `()))

; O(n)
(define (skip n l)
  (if (or (< n 1) (null? (car l)))
      l
      (skip (- n 1) (cdr l))))

; O(l)
(define (reduce f l)
  (define (bootstrap first l)
    (if (null? l)
        first
        (iter (f first (car l)) (cdr l))))
  (define (iter r l)
    (if (null? l)
        r
        (iter (f r (car l)) (cdr l))))
  (bootstrap (car l) (cdr l)))

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

;(sonar puzzle-input 1)
;(sonar puzzle-input 3)

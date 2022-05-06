(load "i1.scm")

;; helper functions
(define (inc x) (+ x 1))
(define (attach l x) (append l (list x)))
;; not performant for lists, should be converted for vectors
(define (take n l)
  (define (iter n l ol)
    (if (and (> n 0) (not (null? l)))
        (iter (- n 1) (cdr l) (attach ol (car l)))
        ol))
  (iter n l `()))
(define (reduce f i l)
  (define (iter v l)
    (if (not (null? l))
        (iter (f v (car l)) (cdr l))
        v))
  (iter i l))

(define (count-increases n l)
  (define (sum l) (reduce + 0 (take n l)))
  (define (iter l v)
    (if (< n (length l))
        (iter (cdr l) (if (< (sum l) (sum (cdr l))) (inc v) v))
        v))
  (iter l 0))

(count-increases 1 puzzle-input)
(count-increases 3 puzzle-input)

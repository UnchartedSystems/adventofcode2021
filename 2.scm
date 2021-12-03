(define (part-1 x y z l)
  (if (null? l)
      (* x y)
      ((car l) (car (cdr l)) x y 0 part-1 (cdr (cdr l)))))

(define (part-2 x y z l)
  (if (null? l)
      (* x z)
      ((car l) (car (cdr l)) x y z part-2 (cdr (cdr l)))))

(define (forward n x y z f l)
  (f (+ x n) y (+ (* n y) z) l))

(define (down n x y z f l)
  (f x (+ y n) z l))

(define (up n x y z f l)
  (f x (- y n) z  l))

;(part-1 0 0 0 puzzle-input)
;(part-2 0 0 0 puzzle-input)

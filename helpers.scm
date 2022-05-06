(define (% x y) (modulo x y))

(define (attach l x) (append l `(x)))

; O(d)
(define (digit d x)
  (if (< d 2)
      (% x 10)
      (digit (- d 1) (/ (- x (% x 10)) 10))))

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


(define (get-int i l)
  (define (iter c n)
    (if (= (car c) i)
        (list (+ (car c) 1) n)
        (list (+ (car c) 1) (car (cdr c)))))
  (car (cdr (reduce iter (cons `(0 false) l)))))

(get-int 2 (list 2 4 5 6))

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

(define (take-so lst cnt)
  (if (zero? cnt)               ; if you ask for zero element
      '()                       ; then return empty list
      (cons (car lst)           ; else make a pair with first element
            (take (cdr lst)     ; and result from take with the rest of the list
                  (- cnt 1))))) ; with one less element than you originally asked for
; O(n)
(define (skip n l)
  (if (or (< n 1) (null? (car l)))
      l
      (skip (- n 1) (cdr l))))

; O(l)
(define (reduce-c f l)
  (define (bootstrap first l)
    (if (null? l)
        first
        (iter (f first (car l)) (cdr l))))
  (define (iter r l)
    (if (null? l)
        r
        (iter (f r (car l)) (cdr l))))
  (bootstrap (car l) (cdr l)))

; O(log(n))
(define (exp x y)
  (cond ((= y 0) 1)
        ((even? y) (square (exp x (/ y 2))))
        (else (* x (exp x (- y 1))))))

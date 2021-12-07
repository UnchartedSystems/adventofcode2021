(load "helpers.scm")
(load "i-3.scm")

(define (sub-digit x) (/ (- x (% x 10)) 10))

(define (b->bl x len)
  (define (iter x len l)
    (if (< len 1) l (iter (sub-digit x) (- len 1) (cons (% x 10) l))))
  (iter x len `()))

(define (map:b->bl l len) (map (lambda (b) (b->bl b len)) l))
(define (bl->b bl) (reduce (lambda (r n) (+ (* r 10) n)) bl))
(define (bl->i bl) (reduce (lambda (r n) (+ (* 2 r) n)) bl))

(define (b-op x a b c) (if (> x a) b c))
(define (b-tally x) (b-op x 0 1 -1))
(define (b-convert x) (b-op x 0 1 0))
(define (b-invert x) (b-op x 0 0 1))

(define (binary-per-digit-mode l len)
  (define (finish? i result)
    (if (> (+ i 1) len)
        (reverse result)
        (iter i result)))
  (define (iter i result)
    (define (mode-reduce r x) (+ r (b-tally (get-int i x))))
    (finish? (+ i 1) (cons (reduce mode-reduce (cons 0 l)) result)))
  (finish? 0 `()))

(define (part-1 l len)
  (define (finish raw-mode)
    (* (bl->i (map b-convert raw-mode))
       (bl->i (map b-invert raw-mode))))
  (finish (binary-per-digit-mode (map:b->bl l len) len)))

(define (recursive-prune l f len)
  (define (get-digit-mode i wl)
    (define (mode-reducer r x)
      (+ r (b-tally (get-int i x))))
    (define (prune-list d)
      (define (iter nl ol)
        (cond ((null? ol) nl)
              ((= (f d) (get-int i (car ol))) (iter (cons (car ol) nl) (cdr ol)))
              (else (iter nl (cdr ol)))))
      (finish? (+ i 1) (iter `() wl)))
    (prune-list (reduce mode-reducer (cons 1 wl))))
  (define (finish? i wl)
    (if (null? (cdr wl))
        (car wl)
        (get-digit-mode i wl)))
  (finish? 0 l))

(define (part-2 l len)
  (* (bl->i (recursive-prune (map:b->bl l len) b-convert len))
     (bl->i (recursive-prune (map:b->bl l len) b-invert len))))

; fuck u dan

(part-1 puzzle-input 12)
(part-2 puzzle-input 12)

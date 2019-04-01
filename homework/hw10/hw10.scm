(define (accumulate combiner start n term)
  (if (= n 0)
    start
    (combiner (term n) (accumulate combiner start (- n 1) term)))
)

(define (accumulate-tail combiner start n term)
  (if (= n 0)
    start
    (accumulate-tail combiner (combiner (term n) start) (- n 1) term)
  )
)


(define (partial-sums stream)
(define (helper num stream)
    (if (null? stream) nil
     (cons-stream (+ num (car stream)) (helper (+ num (car stream)) (cdr-stream stream)) )))
    (helper 0 stream)
)

(define (rle s)
    (define (helper s times)

     (if (null? s) nil
       (if (null? (cdr-stream s)) (cons-stream(cons (car s)(cons times nil)) nil)
      (if (= (car s) (car(cdr-stream s))) (helper (cdr-stream s) (+ times 1))
        (cons-stream (cons (car s)(cons times nil)) (rle (cdr-stream s))) ))))
    (helper s 1))

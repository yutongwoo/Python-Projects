(define (cddr s)

	(cdr (cdr s)))



(define (cadr s)
  
	(car (cdr s))
)

(define (caddr s)
  
	(car (cdr (cdr s)))

)



(define (sign x)
  
	(cond
		((< x 0) -1)
		((> x 0) 1)
		(else 0)
	)
)




(define (square x) (* x x))



(define (pow b n)
	(cond
    		((= n 0) 1)
    		((even? n) (pow (square b) (/ n 2)))
    		(else (* b (pow (square b) (/ (- n 1) 2))))
	)
)




(define (ordered? s)
  
	(if (or (null? s) (null? (cdr s)))
		True
		(and (<= (car s) (cadr s)) (ordered? (cdr s)))
	)

)



(define (empty? s) (null? s))



(define (add s v)
    
	(cond 	((empty? s) (list v))
          		((contains? s v) s)
          		((< v (car s)) (cons v s))
          		(else (cons (car s) (add (cdr s) v)))
         	)
)

; Sets as sorted lists

(define (contains? s v)
    
	(cond 	((empty? s) #f)
          		((> (car s) v) #f)
          		((= (car s) v) #t)
          		(else (contains? (cdr s) v))
          	)
)




(define (intersect s t)
    
	(cond 	((or (empty? s) (empty? t)) nil)
         		((= (car s) (car t)) (cons (car s) (intersect (cdr s) (cdr t))))
          		((< (car s) (car t)) (intersect (cdr s) t))
          		((> (car s) (car t)) (intersect s (cdr t)))
          		(else nil)
          )
)

(define (union s t)
    
	(cond 	((empty? s) t)
          		((empty? t) s)
          		((= (car s) (car t)) (cons (car s) (union (cdr s) (cdr t))))
          		((< (car s) (car t)) (cons (car s) (union (cdr s) t)))
          		(else (cons (car t) (union s (cdr t))))
          )

)






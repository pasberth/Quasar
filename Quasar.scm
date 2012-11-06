;;The Universe in Scheme-Quasar is a function that returns a closure 
(define (universe . eras)
  (let ((BIG_CRUNCH (lambda (x) x)))
    (fold (lambda (item last) 
      (lambda (x) (item (last x)))) BIG_CRUNCH (reverse eras))))


;;The time-machine receives a list of eras and index
;;Turnes the sliced subset of eras into an universe
;;This sucks! Need a better solution
(define (time-machine eras index)
  (apply universe (drop eras index)))

;;qubits are lists
(define (qubit . possibilities)
  possibilities)

(define (qubit-bind q fn)
  (apply qubit (map fn q)))

;;parallel-worlds are lists of universes
(define (parallel-world . universes)
  universes)

;;quantum computer takes a parallel-world and a value
;;apply the value to each universe and return the results in a list
(define (quantum-computer parallel-world val)
  (map (lambda (universe) (universe val)) parallel-world))

;;eats everything
(define (black-hole val)
  black-hole)

;;dark-matter is nil
(define dark-matter
  '())

(define (test)
  (display "universe: ")
  (display (= ((universe
    (lambda (x) (+ x 1))
    (lambda (y) (+ y 2))
    (lambda (z) (+ z 3))) 1) 7))
  (newline)


  (display "time-machine: ")
  (display (=
   ((time-machine
    (list 
      (lambda (x) (+ x 1))
      (lambda (y) (+ y 2))
      (lambda (z) (+ z 3))) 1) 1) 6))
  (newline)

  (display "qubit: ")
  (display (equal? (qubit 1 2 3) (list 1 2 3)))
  (newline)


  (display "qubit-bind: ")
  (display (equal?
    (qubit-bind 
      (qubit 1 2 3) 
      (lambda (x) (+ x 1)))
    (qubit 2 3 4)))
  (newline)

  (display "parallel-world, quantum-computer: ")
  (let ((higher-order-universe (lambda (x) 
    (universe
      (lambda (a) (* x 2))
      (lambda (b) (* b x))))))
  (display (equal?
    (quantum-computer 
      (apply 
        parallel-world 
        (map higher-order-universe (qubit 1 2 3)))
      5) '(2 4 6))))
  (newline)


  (display "black-hole: ")
  (display (eq?
    (((((black-hole 1) 2) 3) 4) 5)
    black-hole))
  (newline)

  (display "dark-matter: ")
  (display (null? dark-matter))
  (newline))

(test)

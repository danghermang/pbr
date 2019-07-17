(deftemplate cell
        (slot x)
        (slot y)
        (slot life)
        (slot checked)
        (slot neighbors)
)

(deftemplate size
        (slot linie)
        (slot coloana))

(deffacts fapte
        (start)
)

(deffunction pause (?delay)
        (bind ?start (time))
        (while (< (time) (+ ?start ?delay)) do)
)

(defrule initializare
        (start)
        =>
        (bind ?n 30)
        (bind ?m 30)
        (assert (size (linie ?n) (coloana ?m)))

        (bind ?o 19)

        (bind ?it 30)
        (assert (iteratii ?it))
        (assert (counter ?it))

        (loop-for-count (?cnt1 1 ?n) do
                (loop-for-count (?cnt2 1 ?m) do
                        (assert (cell (x ?cnt1) (y ?cnt2) (life 0) (checked 0) (neighbors 0)))
                )
        )
        
        (open "game_of_life_config.txt" mydata)
        (bind $?config (readline mydata))

        (while (neq ?config EOF)
                (assert (modifica (explode$ ?config)))
                (bind $?config (readline mydata))
        )
        (close)
)
(defrule print_matrix (declare(salience 80))
        ?s<-(print_matrix)
        (size (linie ?n) (coloana ?m))
        =>
        (retract ?s)
        (loop-for-count (?cnt1 1 ?n) do
                (loop-for-count (?cnt2 1 ?m) do
                        (assert (reverse_print_cell (+ (- ?n ?cnt1) 1) (+ (- ?m ?cnt2) 1)))
                )
        )
)

(defrule print_cell (declare(salience 80))
        ?s<-(reverse_print_cell ?x ?y)
        ?c<- (cell (x ?x) (y ?y) (life ?l))
        (size (linie ?n) (coloana ?m))
        =>
        (retract ?s)
        (if (eq ?l 0)
                then
                (printout t "□ ")
                else
                (printout t "■ ")
        )
        (if (eq ?y ?m) 
                then
                (printout t crlf)
                (if (eq ?x ?n) then
                        (pause 0.5)
                )
        )
)
(defrule modificare (declare(salience 100))
        ?s<-(modifica ?x ?y)
        ?c<-(cell (x ?x) (y ?y))
        =>
        (retract ?s)
        (modify ?c (life 1))
)

(defrule iteratie (declare(salience 10))
        ?s<-(iteratii ?it)
        (counter ?max)
        (test (> ?it 0))
        (size (linie ?n) (coloana ?m))
        =>
        (loop-for-count (?cnt1 1 ?n) do
                (loop-for-count (?cnt2 1 ?m) do
                        (assert (check_neighbors ?cnt1 ?cnt2))
                )
        )
        (retract ?s)
        (printout t "Generatia "(- ?max ?it) crlf)
        (assert (iteratii (- ?it 1)))
        (assert (print_matrix))
)
(defrule verifica_vecini (declare(salience 60))
        ?s<-(check_neighbors ?x ?y)
        ?m<-(cell (x ?x) (y ?y))
        =>
        (retract ?s)
        (modify ?m (neighbors 0))
        (assert (check_cell ?x ?y (- ?x 1) (- ?y 1)))
        (assert (check_cell ?x ?y (- ?x 1) ?y))
        (assert (check_cell ?x ?y (- ?x 1) (+ ?y 1)))
        (assert (check_cell ?x ?y ?x (- ?y 1)))
        (assert (check_cell ?x ?y ?x (+ ?y 1)))
        (assert (check_cell ?x ?y (+ ?x 1) (- ?y 1)))
        (assert (check_cell ?x ?y (+ ?x 1) ?y))
        (assert (check_cell ?x ?y (+ ?x 1) (+ ?y 1)))
        (assert (check_life ?x ?y))

)

(defrule check_cell (declare(salience 70))
        ?s<-(check_cell ?x ?y ?a ?b)
        ?c1<-(cell (x ?x) (y ?y) (neighbors ?n))
        ?c2<-(cell (x ?a) (y ?b) (life ?l2))
        =>
        (retract ?s)
        (if (eq ?l2 1)
                then
                (modify ?c1 (neighbors (+ ?n 1)))
        )
        
)
(defrule check_cell2 (declare(salience 60))
        ?s<-(check_cell ?x ?y ?a ?b)
        =>
        (retract ?s)
)

(defrule check_life (declare(salience 30))
        ?s<-(check_life ?x ?y)
        ?c<-(cell (x ?x) (y ?y) (neighbors ?n) (life ?l))
        =>
        (retract ?s)
        (if (eq ?l 1)
                then
                (if (or (< ?n 2) (> ?n 3))
                        then
                        (modify ?c (life 0))
                )
                else
                (if (eq ?n 3)
                        then
                        (modify ?c (life 1))
                )
        )
        
)
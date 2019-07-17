(deftemplate cell
        (slot x)
        (slot y)
        (slot life)
        (slot checked)
        (slot neighbors)
)

(defrule afisare_meniu
    (not (size ?))
    =>
    (printout t crlf "Alegeti numarul de linii:")
    (bind ?n (read))
    (printout t crlf "Alegeti numarul de coloane:")
    (bind ?m (read))
    (assert (size ?n ?m))
    (assert (other_matrix 0 0))
    (printout t crlf "Alegeti numarul de celule vii:")
    (bind ?o (read))
    (assert (cells_number ?o))
)

(defrule umplere_celule (declare(salience 10))
    ?a<-(other_matrix ?n2 ?m2)
    ?b<-(size ?n1 ?m1)
    (test (< ?n2 ?n1))
    (test (< ?m2 ?m1))
    =>
    (assert (cell(x ?n2)(y ?m2)(life n)(checked n)(neighbors 0)))
    (bind ?new_m2 (+ ?m2 1))
    (retract ?a)
    (assert (other_matrix ?n2 ?new_m2))
)

(defrule resetare_contor_coloana
     ?a<-(other_matrix ?n2 ?m2)
     ?b<-(size ?n1 ?m1)
     (test (>= ?m2 ?m1))
     =>
     (bind ?new_n2 (+ ?n2 1))
     (retract ?a)
     (assert (other_matrix ?new_n2 0))
)

(defrule inserare_celule
    ?b<-(cells_number ?number)
    (test (> ?number 0))
    =>
    (printout t crlf "Alegeti pozitia x:")
    (bind ?x (read))
    (printout t crlf "Alegeti pozitia y:")
    (bind ?y (read))
    (bind ?new (- ?number 1))
    (retract ?b)
    (assert (cells_number ?new))
    (assert (cell(x ?x)(y ?y)(life y)(checked n)(neighbors 0)))
)

(defrule replace_cell 
        )
(defrule neighbor-1
        (cell (x ?a) (y ?b) (life y) (checked ?)(neighbors ?))
        (cell (x ?c)  (y ?b) (life y) (checked ?)(neighbors ?))
        (test (= ?c (+ ?a 1)))
        =>
        (assert (neighbor_check ?a ?b))
)


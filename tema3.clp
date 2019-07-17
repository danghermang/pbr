(deftemplate student
        (slot name)
        (multislot note)
)


(deffacts meniu
    (meniu 1 -> Adauga student)
    (meniu 2 -> Adauga examen)
    (meniu 3 -> Adauga note student)
    (meniu 4 -> Adauga note examen)
    (meniu 5 -> Afisare info student)
    (meniu 6 -> Afisare info examen)
    (meniu 0 -> Iesire)

    (options -1 0 1 2 3 4 5 6)
    (input -1)
)

(defrule afisare_meniu
    (meniu $?x)
    (input -1)
    =>
    (printout t ?x crlf)
)

(defrule input
    ?a <- (input -1)
    =>
    (printout t "Optiune: ")
    (retract ?a)
    (assert (input (read)))
)


(defrule verificare_optiune
    ?a <- (input ?x)
    (not (options $? ?x $?))
    =>
    (printout t "Optiune invalida: " ?x crlf)
    (retract ?a)
    (assert (input -1))
)


(defrule afisare_optiune
    (disabled)
    (input ?x)
    (not (input -1))
    (meniu ?x $?y)
    =>
    (printout t "Ai ales: " $?y crlf)
)


(defrule iesire
    ?a <- (input 0)
    =>
    (retract ?a)
)

(defrule adaugare_student
    ?a <- (input 1)
    =>
    (retract ?a)
    (assert (input -1))

    (printout t "Nume student: ")
    (bind ?x (read))
    (assert (student (name ?x)))
)
(defrule adaugare_nota_student
    ?a <- (input 3)
    =>
    (retract ?a)
    (assert (input -1))

    (printout t "Nume student: ")
    (bind ?x (read))
    (assert (update student ?x))
)


(defrule adaugare_nota_student2
    ?a <- (update student ?x)
    ?s<-(student (name ?x) (note $?y))
    =>
    (retract ?a)
    (printout t "Note student " ?x ": ")
    (bind $?z (explode$ (readline)))
    (modify ?s (note $?y $?z))
)

(defrule adaugare_nota_student_fail
    ?a <- (update student ?x)
    (not (student (name ?x) (note $?y)))
    =>
    (retract ?a)

    (printout t "Nu exista studentul: " ?x crlf)
)

(defrule afisare_student
    ?a <- (input 5)
    =>
    (retract ?a)
    (assert (input -1))

    (printout t "Nume student: ")
    (bind ?x (read))
    (assert (show student ?x))
)

(defrule afisare_student_fail
    ?a <- (show student ?x)
    (student (name ?x) (note))
    =>
    (retract ?a)

    (printout t "Student fara note: " ?x crlf)
)
(defrule afisare_student_fail2
    ?a <- (show student ?x)
    (not (student (name ?x) (note $?y)))
    =>
    (retract ?a)

    (printout t "Nu exista studentul:" ?x crlf)
)
(defrule afisare_student2
    ?a <- (show student ?x)
    (student (name ?x) (note $?y))
    =>
    (retract ?a)

    (printout t "Student: " ?x " note: " $?y crlf)
)




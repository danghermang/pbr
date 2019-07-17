(deffacts meniu (meniu))

(defrule initial
        ?m<-(meniu)
        (not(optiune ?))
        =>
        (printout t "optiune adauga_student"crlf
                "optiune adauga_examen" crlf
                "optiune adauga_nota_student" crlf
                "optiune adauga_nota_examen"crlf
                "optiune afisare_info_student"crlf
                "optiune afisare_info_examen"crlf
                "optiune iesire"crlf
                "---Introduceti raspunsul--"crlf)
        (assert (optiune (read)))
        (retract ?m)
)
(defrule adauga_examen
        ?o<-(optiune adauga_examen)
        =>
        (printout t "Introduceti numele examenului"crlf)
        (assert (examen (read) ))
        (assert (meniu))
        (retract ?o)
)
(defrule adauga_student
        ?o<-(optiune adauga_student)
        =>
        (printout t "Adaugati numele studentului"crlf)
        (assert (student (read)))
        (assert (meniu))
        (retract ?o)
)
(defrule adauga_nota_student
        ?o<-(optiune adauga_nota_student)
        =>
        (printout t "Adaugati numele"crlf)
        (assert (adaugare_student_tmp (read)))
        (retract ?o)
)
(defrule adauga_nota_student2
        ?s<-(adaugare_student_tmp ?nume)
        =>
        (printout t "Adaugati numele materiei"crlf)
        (assert (adaugare_student_tmp2 ?nume (read)))
        (retract ?s)
)
(defrule adauga_nota_student3
        ?s<-(adaugare_student_tmp2 ?nume ?materie)
        =>
        (printout t "Adaugati numele materiei"crlf)
        (retract ?s)
        (assert (meniu))
)
(defrule iesire
        ?o<-(optiune iesire)
        =>
        (printout t "Ati iesit"crlf)
        (retract ?o)
)
(defrule optiune_gresita
        ?o<-(optiune $?)
        =>
        (retract ?o)
        (assert (meniu))
        (printout t "---Optiune gresita---"crlf)
)
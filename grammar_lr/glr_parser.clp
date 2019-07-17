(deftemplate rule
        (multislot condition)
        (multislot effect)
)
(deftemplate depth
        (slot value)
        (slot current))
(deffacts lexicon 
        (lex S)
        (lex X)
        (lex Y)
        (lex A)
        (lex B)
        (lex a1)
        (lex a2)
        (lex b1)
        (lex b2)
        (start)
        (depth (value 0) (current 0))

)
(defrule initialize
        (start)
        =>
        (printout t "Introduceti sirul de parsat"crlf)
        (assert (initial (explode$ (readline)) 0))
        (open "grammar.csv" mydata)
        (bind $?left (readline mydata))
        (bind $?right (readline mydata))

        (while (or (neq ?left EOF) (neq ?right EOF))
                (assert (rule (condition (explode$ ?left)) (effect (explode$ ?right))))
                (bind $?left (readline mydata))
                (bind $?right (readline mydata))
        )
        (close)
        ; (assert (init_print))

)
(defrule check_parsable (declare(salience 100))
        ?s<-(initial $?a ?b $?c ?n) 
        (not (exists (lex ?b)))
        =>
        (retract ?s)
        (assert (unparseable $?a ?b $?c ?n))
        (printout t "Faptul '")
        (if (> (length$ ?a) 0)
                then
                (printout t (expand$ ?a))
        )
        (printout t ?b)
        (if (> (length$ ?c) 0)
                then
                (printout t (expand$ ?a))
        )
        (printout t "' de la adancimea " ?n " nu este parsabil fiindca '" ?b "' nu exista in lexicon." crlf)
)


(defrule rule (declare(salience 50))
        ?s<-(initial $?a ?A $?b ?n) 
        (rule (condition ?A) (effect $?B))
        ?d<-(depth (value ?q))
        =>
        (assert (initial $?a ?B $?b (+ ?n 1)))
        (modify ?d (value (max ?q (+ ?n 1))))
)

(defrule initial_print (declare(salience 40))
        ?s<-(init_print)
        =>
        (retract ?s)
        (printout t "Nivelul 0 " crlf)
)

(defrule print_level (declare(salience 30))
        (depth (value ?a) (current ?b))
        (test (<= ?b ?a))
        ?s<- (initial $?c ?b)
        =>
        (printout t ?c)
        (retract ?s)
)
(defrule increment_level (declare(salience 20))
        ?m<-(depth (value ?a) (current ?b))
        (test (< ?b ?a))
        (not (exists (initial $? ?b)))
        =>
        
        (modify ?m (current (+ ?b 1)))
        (printout t crlf "Nivelul " (+ ?b 1) crlf)
)
(defrule last
        (depth (value ?a) (current ?b))
        (test (eq ?a ?b))
        =>
        (printout t crlf)
)
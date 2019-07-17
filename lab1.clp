(defrule CPC1 (PNP) (not (RLF)) (PIU) => (assert (CPC)))

(defrule CPCC1 (PNP) (RLF) (PIU) => (assert (CPCC)))
(defrule CPCC2 (PNP) (not (RLF)) (PIU)  => (assert (CPCC)))

(defrule EPSI1 (PNP) (RLF) (PIU) => (assert (EPSI)))
(defrule EPSI2 (PNP) (not (RLF)) (PIU) => (assert (EPSI)))
(defrule EPSI3 (not (PNP)) (RLF) (PIU) => (assert (EPSI)))
(defrule EPSI4 (not (PNP)) (not (RLF)) (PIU) => (assert (EPSI)))

(defrule CRI1 (PNP) (RLF) (PIU) => (assert (CRI)))
(defrule CRI2 (PNP) (RLF) (not (PIU)) => (assert (CRI)))
(defrule CRI3 (not (PNP)) (RLF) (PIU) => (assert (CRI)))
(defrule CRI4 (not (PNP)) (RLF) (not (PIU)) => (assert (CRI)))

(defrule CPJ1 (PNP) (RLF) (not (PIU)) => (assert (CPJ)))
(defrule CPJ2 (PNP) (not (RLF)) (not (PIU)) => (assert (CPJ)))


(defrule CPCR (CPC) => (printout t "Check the power cable"crlf))
(defrule CPCCR (CPCC) => (printout t "Check the printer-computer cable"crlf))
(defrule EPSIR (EPSI) => (printout t "Ensure printer software is installed"crlf))
(defrule CRIR (CRI) => (printout t "Check/replace ink"crlf))
(defrule CPJR (CPJ) => (printout t "Check for paper jam"crlf))
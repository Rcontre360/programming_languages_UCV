differencia([Numa,Dena], [Numb,Denb],[Numc,Denc]):-
    Denc is Dena * Denb,
    Aux1 is Numa * Denb,
    Aux2 is Dena * Numb,
    Numc is Aux1-Aux2.

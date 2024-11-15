/*
Dado un programa con las siguientes clausulas:
*/

p(1).
p(2) :- !, p(3).
p(3).

/*
Se desea que usted escriba las respuestas de Prolog a las siguientes
preguntas (si lo requiere, utilice arboles de ejecucion para justificar)
*/
/*
a) ?-p(X).
X = 1 ;
X = 2.
No imprime 3 porque lo corta.

b) ?-p(X), p(3), p(Y).
X = Y, Y = 1 ;
X = 1,
Y = 2 ;
X = 2,
Y = 1 ;
X = Y, Y = 2
La primera cláusula p(1) se satisface y asigna X = 1.
La segunda cláusula p(2) :- !, p(3) se selecciona.
El corte (!) evita que se busquen otras soluciones para p(2) más allá de este punto.
Luego, se realiza una llamada recursiva p(3).
La tercera cláusula p(3) se satisface (es un true, no muestra un resultado como tal)
Ahora, se ha satisfecho la consulta p(X), p(3), p(Y) con X = 1 y Y = 3.
Sin embargo, como la segunda cláusula tenía un corte (!),
se evita la búsqueda de otras soluciones para p(X) en esa cláusula.

c) ?-p(X), !, p(Y).
X = Y, Y = 1 ;
X = 1,
Y = 2
Se producen dos soluciones:
1. Cuando X y Y tienen el valor 1: Esto ocurre cuando la primera cláusula
p(1) se satisface para X y Y antes del corte (!).
2. Cuando X tiene el valor 1 y Y tiene el valor 2: Esto ocurre cuando la
primera cláusula p(1) se satisface para X, luego el corte (!) evita que se
busquen otras soluciones para p(X). A continuación, la segunda cláusula
p(2) :- !, p(3) se selecciona y se realiza una llamada recursiva a p(3).
Finalmente, la tercera cláusula p(3) se satisface para Y.

d) ?-p(X), fail, p(Y), p(Z).
false.
El predicado fail/0 siempre falla, lo que significa que no tiene éxito y no
 encuentra ninguna solución. En este caso, después de satisfacer p(X), se
 encuentra fail, lo que hace que la consulta falle inmediatamente y no se
 continúe con los siguientes objetivos p(Y) y p(Z).
*/

/*
Defina en prolog el predicado rotar, que permita desplazar a la izquierda
circularmente los elementos de una lista dado un valor entero que denota
la cantidad de posiciones a rotar. Por ejemplo:
?- rotate([a, b, c, d, e, f, g, h], 3, X).
X = [d, e, f, g, h, a, b, c].
Por simplicidad, puede asumir que el valor del segundo término siempre es
mayor o igual que cero.
*/
rotate([], _, []).
rotate([X], _, X).
rotate(X, 0, X).
rotate([X|Xs], N, Res) :- 
    N>0, N1 is N-1, append(Xs, [X], AuxList), rotate(AuxList, N1, Res).
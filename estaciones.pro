/*Predicado equivalente al hecho carril, pero conmutativo*/
conexion(X,Y) :- carril(X,Y).
conexion(X,Y) :- carril(Y,X).

grande(C) :-
	conexion(C,X), conexion(C,Y), conexion(C,Z),
	X \= Y, Y \= Z, X \= Z.

/* Tiene exito si C es una cdad. buena, en cuyo caso unifica Dist con su distancia minima a las grandes*/
buena(C,Dist):- conexion(C,X), conexion(C,Y), X \= Y, \+ grande(C), grande(X), grande(Y), Dist is 1.
buena(C,Dist):- conexion(C,X), conexion(C,Y), X \= Y, \+ grande(C), \+ grande(X), \+ grande(Y), revisar([C],X,Y,Dist1), Dist is Dist1+1.

/* Recorre dos caminos simultaneamente, falla en casos donde hay solo un camino por recorrer, unifica Dist con la distancia minima
del camino*/
revisar(Marcados,X,Y,1):- conexion(X,A), conexion(Y,B), A \= B, \+ member(A,Marcados), \+ member(B,Marcados), grande(A),grande(B).
revisar(Marcados,X,Y,Dist):- conexion(X,A), conexion(Y,B), A \= B, \+ member(A,Marcados), \+ member(B,Marcados), \+ grande(A),
							\+ grande(B), append(Marcados,[A,B],Marcados1), revisar(Marcados1,A,B,Dist1), Dist is Dist1+1.
							
estacion(X):- 
	setof((X,Y),buena(X,Y),LBuenas),
	encontrarMenor(LBuenas,X).
	
	
% Dada una lista de buenas ciudades, unifica mejorCiudad con la mejor.
encontrarMenor([(X,Xn),(_,Yn)|RestoBuenas],MejorCiudad):-
	Xn < Yn, encontrarMenor([[X,Xn]|RestoBuenas],MejorCiudad).
encontrarMenor([(_,Xn),(Y,Yn)|RestoBuenas],MejorCiudad):-
	Xn >= Yn, encontrarMenor([[Y,Yn]|RestoBuenas],MejorCiudad).
encontrarMenor([(X,Xn),(_,Yn)|[]],MejorCiudad):-
	Xn < Yn, MejorCiudad = X, !.
encontrarMenor([(_,Xn),(Y,Yn)|[]],MejorCiudad):-
	Xn >= Yn, MejorCiudad = Y.
encontrarMenor([(X,_)],X).

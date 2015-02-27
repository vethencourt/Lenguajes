carril(brussel,charleroi).
carril(brussel,haacht).
carril(haacht,mechelen).
carril(mechelen,berchem).
carril(berchem,antwerpen).
carril(brussel,boom).
carril(boom,antwerpen).
carril(antwerpen,turnhout).

/*Predicado equivalente al hecho carril, pero conmutativo*/
conexion(X,Y) :- carril(X,Y).
conexion(X,Y) :- carril(Y,X).

grande(C) :-
	conexion(C,X), conexion(C,Y), conexion(C,Z),
	X \= Y, Y \= Z, X \= Z.

buena(C,Dist):- conexion(C,X), conexion(C,Y), X \= Y, \+ grande(C), grande(X), grande(Y), Dist is 1.
buena(C,Dist):- conexion(C,X), conexion(C,Y), X \= Y, \+ grande(C), \+ grande(X), \+ grande(Y), revisar([C],X,Y,Dist1), Dist is Dist1+1.

revisar(Marcados,X,Y,1):- conexion(X,A), conexion(Y,B), A \= B, \+ member(A,Marcados), \+ member(B,Marcados), grande(A),grande(B).
revisar(Marcados,X,Y,Dist):- conexion(X,A), conexion(Y,B), A \= B, \+ member(A,Marcados), \+ member(B,Marcados), \+ grande(A),
							\+ grande(B), append(Marcados,[A,B],Marcados1), revisar(Marcados1,A,B,Dist1), Dist is Dist1+1.
							
estacion(X):- 
	setof((X,Y),buena(X,Y),LBuenas),
	encontrarMenor(LBuenas,X).
	
	
% Dada una lista de buenas ciudades, encuentra la mejor.
encontrarMenor([(X,Xn),(Y,Yn)|RestoBuenas],MejorCiudad):-
	Xn < Yn, encontrarMenor([[X,Xn]|RestoBuenas],MejorCiudad).
encontrarMenor([(X,Xn),(Y,Yn)|RestoBuenas],MejorCiudad):-
	Xn >= Yn, encontrarMenor([[Y,Yn]|RestoBuenas],MejorCiudad).
encontrarMenor([(X,Xn),(Y,Yn)|[]],MejorCiudad):-
	Xn < Yn, MejorCiudad = X.
encontrarMenor([(X,Xn),(Y,Yn)|[]],MejorCiudad):-
	Xn >= Yn, MejorCiudad = Y.
encontrarMenor([(X,Y)],X).
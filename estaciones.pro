carril(brussel,mechelen).
carril(brussel,antwerpen).
carril(brussel,gent).
carril(antwerpen,mechelen).
carril(antwerpen,gent).
carril(gent,brugge).

/*Predicado equivalente al hecho carril, pero conmutativo*/
conexion(X,Y) :- carril(X,Y).
conexion(X,Y) :- carril(Y,X).

grande(C) :-
	conexion(C,X), conexion(C,Y), conexion(C,Z),
	X \= Y, Y \= Z, X \= Z, !.

pequena(C) :- \+ grande(C).


buena(C,N) :-
	pequena(C), grande(G1), grande(G2),
	distancia(C,G1,N1), distancia(C,G2,N2), N1 == N2, N is N1.

dfs(A,Distancia,Visitados) :-
	Visitados1 is [A|Visitados], carril(A,X), \+ member(X,Visitados1),
	Distancia1 is Distancia+1, dfs(X,Distancia1,Visitados1).
	

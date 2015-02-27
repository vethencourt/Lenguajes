carril(brussel,mechelen).
carril(brussel,antwerpen).
carril(brussel,gent).
carril(antwerpen,mechelen).
carril(antwerpen,gent).
carril(gent,brugge).

/*
carril(brussel,charleroi).
carril(brussel,haacht).
carril(haacht,mechelen).
carril(mechelen,berchem).
carril(berchem,antwerpen).
carril(brussel,boom).
carril(boom,antwerpen).
carril(antwerpen,turnhout).
*/

/*Predicado equivalente al hecho carril, pero conmutativo*/
conexion(X,Y) :- carril(X,Y).
conexion(X,Y) :- carril(Y,X).

grande(C) :-
	conexion(C,X), conexion(C,Y), conexion(C,Z),
	X \= Y, Y \= Z, X \= Z.%, !.

pequena(C) :- \+ grande(C).

buena(Ciudad,Distancia,CiudadesGrandes) :- %Distancia entre la ciudad pequena y las 2 grandes.
	pequena(Ciudad),
	bfs([Ciudad],Destinos1Paso,[Ciudad],CiudadesGrandes,0,Distancia).
	
	
	
bfs([Origen|ListaOrigenes],[Destino1Paso|Ciudades1Paso],CiudadesMarcadas,Nivel,Distancia):-
	conexion(Origen,Destino1Paso), 
	\+ member(Destino1Paso,CiudadesMarcadas),
	\+ member(Destino1Paso,Ciudades1Paso),
	Ciudades1Paso1 = [Destino1Paso|Ciudades1Paso],
	CiudadesMarcadas1 = [Destino1Paso|CiudadesMarcadas],
	bfs(ListaOrigenes,Ciudades1Paso1,CiudadesMarcadas1,Nivel,Distancia).
	
bfs([],Ciudades1Paso,CiudadesMarcadas,Nivel,Distancia):-
	cuantasGrandes(Ciudades1Paso,0,N),
	decision(Ciudades1Paso,CiudadesMarcadas,N,Nivel,Distancia).
	
decision(Ciudades1Paso,CiudadesMarcadas,NumDeGrandes,Nivel,Distancia):- 
	NumDeGrandes = 0,
	Nivel1 is Nivel+1,
	bfs(Ciudades1Paso,NuevasCiudades1Paso,CiudadesMarcadas,Nivel1,Distancia).
decision(_,_,_,NumDeGrandes,Nivel,Distancia):- 
	NumDeGrandes = 1,
	fail.
decision(_,_,_,NumDeGrandes,Nivel,Distancia):- 
	NumDeGrandes > 2, 
	Nivel = Distancia, 
	!.
	

	
	
% Unifica en X la mejor estacion (aquella peq q tiene menor camino hasta 2 grandes).
estacion(X):-
	setof((Ciudad),grande(Ciudad),ListaGrandes),
	setof((CiudadPeq,Dist), buena(CiudadPeq,Dist,ListaGrandes),ListaBuenas),
	encontrarMenor(ListaBuenas,X).
	
	
% Dada una lista de buenas ciudades, encuentra la mejor.
encontrarMenor([[X,Xn],[Y,Yn]|RestoBuenas],MejorCiudad):-
	Xn < Yn, encontrarMenor([[X,Xn]|RestoBuenas],MejorCiudad).
encontrarMenor([[X,Xn],[Y,Yn]|RestoBuenas],MejorCiudad):-
	Xn >= Yn, encontrarMenor([[Y,Yn]|RestoBuenas],MejorCiudad).
encontrarMenor([[X,Xn],[Y,Yn]|[]],MejorCiudad):-
	Xn < Yn, MejorCiudad = X.
encontrarMenor([[X,Xn],[Y,Yn]|[]],MejorCiudad):-
	Xn >= Yn, MejorCiudad = Y.
	
	
cuantasGrandes([H|T],Ac,N):-
	grande(H), 
	Ac1 is Ac+1, 
	cuantasGrandes(T,Ac1,N).
	
cuantasGrandes([H|T],Ac,N):-
	cuantasGrandes(T,Ac,N).
	
cuantasGrandes([],N,N).
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*
dfs(A,Distancia,Visitados,ListaGrandes) :-
	Visitados1 = [A|Visitados], conexion(A,X), \+ member(X,Visitados1),
	Distancia1 is Distancia+1, auxDfs(X,Distancia1,Visitados1,ListaGrandes).

auxDfs(X,Distancia,Visitados,ListaGrandes):- member(X,ListaGrandes).
auxDfs(X,Distancia,Visitados,ListaGrandes):- dfs(X,Distancia,Visitados,ListaGrandes).
*/




	
	%recibe una ciudad
	% busca conexion de 1 elemento q no este marcado.
	% marco ese elemnto y lo anexo a la lista.
	% Si el elemento es grande, me detengo.
	%reinicio con la nueva lista y los nuevos elementos.
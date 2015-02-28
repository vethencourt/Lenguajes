punto(_,_).

leer(PtosAbiertos,NumFilas,NumColumnas):-
	write('"Por favor, introduzca el nombre del archivo".\n'),
	read(NombreArchivo),
	write('\n'),
	open(NombreArchivo,read,Stream),
	get_code(Stream,Num),
	leerPrimeraLinea(Num,_,Stream,NumColumnas),
	get_code(Stream,Char),
	verificarChar(Char,_,Stream,0,0,ListaPuntos,NumFilas,NumColumnas),
	PtosAbiertos = ListaPuntos.

resolver(PtosAbiertos, _, NumColumnas,PtosSalida) :-
	ColSalida is NumColumnas-1,
	resolverAux(PtosAbiertos,ColSalida,[],PtosSalida).	
	
escribir(PA, PC, F, C):- Fila is F-1, Col is C-1,auxEscribir(PA, PC, Fila, Col,0,0).
	
	
%% Verificacion de fin de archivo.
verificarChar(-1,[],Stream,FilaAct,ColumnaAct,[],NumFilas,NumColumnas):-
	NumFilas is FilaAct+1, NumColumnas = ColumnaAct,close(Stream),!.


%% Verificacion de salto de linea y lee el sig char.
verificarChar(10,ListaChar,Stream,FilaAct,_,ListaPuntos,NumFilas,NumColumnas):-
	FilaAct1 is FilaAct + 1,
	get_code(Stream,Char),
	verificarChar(Char,ListaChar,Stream,FilaAct1,0,ListaPuntos,NumFilas,NumColumnas).

% Verificacion del espacio y lee el sig char.
verificarChar(32,ListaChar,Stream,FilaAct,ColumnaAct,[Punto|ListaPuntos],NumFilas,NumColumnas):-
	Punto = punto(FilaAct,ColumnaAct),
	ColumnaAct1 is ColumnaAct + 1,
	get_code(Stream,ProxChar),
	verificarChar(ProxChar,ListaChar,Stream,FilaAct,ColumnaAct1,ListaPuntos,NumFilas,NumColumnas).
	
% Lee el siguiente char.
verificarChar(Char,[Char|ListaChar],Stream,FilaAct,ColumnaAct,ListaPuntos,NumFilas,NumColumnas):-
	ColumnaAct1 is ColumnaAct + 1,
	get_code(Stream,ProxChar),
	verificarChar(ProxChar,ListaChar,Stream,FilaAct,ColumnaAct1,ListaPuntos,NumFilas,NumColumnas).


resolverAux([punto(X,ColSalida)|_],ColSalida,Acum,Camino):-
	Camino = [punto(0,0),punto(X,ColSalida)|Acum].

resolverAux([punto(X,Y)|Puntos],ColSalida,Acum,Camino) :-
	select(A,Puntos,Abiertos1), 
	verificar(punto(X,Y),A),
	Acum1 = [A|Acum],
	resolverAux([A|Abiertos1],ColSalida,Acum1,Camino).

% Verifica si un movimiento es valido
verificar(punto(X,Y),punto(X,Z)):- Z =:= Y+1.
verificar(punto(X,Y),punto(X,Z)):- Z =:= Y-1.
verificar(punto(X,Y),punto(Z,Y)):- Z =:= X+1.
verificar(punto(X,Y),punto(Z,Y)):- Z =:= X-1.


% Leer la primera linea del archivo.
leerPrimeraLinea(10,_,_,_).

leerPrimeraLinea(Char,[Char|ListaChar],Stream,NumColumnas):- 
	get_code(Stream,ProxChar),
	leerPrimeraLinea(ProxChar,ListaChar,Stream,NumColumnas).




% Fin de 'archivo'
auxEscribir(_, _, F, _, FAct, _):-
	FAct is F+1,!.

% Fin de 'archivo'	
auxEscribir(_, _, F, C, F, CAct):-
	CAct is C+1,!.
	
% Imprime un salto de linea.
auxEscribir(PA, PC, F, C,FAct, CAct):- 
	CAct is C+1, 
	write('\n'),
	FAct1 is FAct+1,
	CAct1 is 0,
	auxEscribir(PA, PC, F, C,FAct1, CAct1).
	
% Imprime el punto correspondiente.
auxEscribir(PA, PC, F, C,FAct, CAct):- 
	member(punto(FAct,CAct),PC),
	select(punto(FAct,CAct),PC,PC1),
	write('.'),
	CAct1 is CAct + 1,
	auxEscribir(PA,PC1,F,C,FAct,CAct1).
	
% De no haber punto, imprime un espacio.
auxEscribir(PA, PC, F, C,FAct, CAct):- 
	member(punto(FAct,CAct),PA),
	select(punto(FAct,CAct),PA,PA1),
	write(' '),
	CAct1 is CAct + 1,
	auxEscribir(PA1,PC,F,C,FAct,CAct1).

% De no haber punto ni espacio, imprime #.
auxEscribir(PA, PC, F, C,FAct, CAct):- 
	write('#'),
	CAct1 is CAct + 1,
	auxEscribir(PA,PC,F,C,FAct,CAct1).

% Fin de 'archivo'
auxEscribir([],[],_,_,_,_).


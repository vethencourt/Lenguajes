

punto(X,Y).

%leerNombreArchivo(X):- 
%	write(X).
	
%abrirArchivoLectura(Stream):- 
%
leer(PtosAbiertos,NumFilas,NumColumnas):-
	write('"Por favor, introduzca el nombre del archivo".\n'),
	read(NombreArchivo),
	open(NombreArchivo,read,Stream),
%	get_code(Stream,NumColumnas), %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Tengo q leer un integer
	get_code(Stream,Char),
	verificarChar(Char,ListaChar,Stream,0,0,ListaPuntos,NumFilas).
%	atom_codes(X,ListaChar),
%	write(ListaPuntos).

%% Verificacion de fin de archivo.
verificarChar(-1,[],_,FilaAct,_,[],NumFilas):-  NumFilas = FilaAct - 1, !.

%%%%%%%%%%%%%%%%%%%%%%%FALTA CERRAR ARCHIVO

%% Verificacion de salto de linea.
verificarChar(10,ListaChar,Stream,FilaAct,ColumnaAct,ListaPuntos,NumFilas):-
	FilaAct1 is FilaAct + 1,
	get_code(Stream,Char),
	verificarChar(Char,ListaChar,Stream,FilaAct1,0,ListaPuntos,NumFilas).

%% Verificacion de retorno de carro (\r).
%verificarChar(13,ListaChar,Stream,FilaAct,ColumnaAct,ListaPuntos,NumFilas):-
%	get_code(Stream,Char),
%	verificarChar(Char,ListaChar,Stream).

% Verificacion del espacio.
verificarChar(32,ListaChar,Stream,FilaAct,ColumnaAct,[Punto|ListaPuntos],NumFilas):-
	Punto = punto(FilaAct,ColumnaAct),
	ColumnaAct1 is ColumnaAct + 1,
	get_code(Stream,ProxChar),
	verificarChar(ProxChar,ListaChar,Stream,FilaAct,ColumnaAct1,ListaPuntos,NumFilas).
	
% Lee el siguiente char.
verificarChar(Char,[Char|ListaChar],Stream,FilaAct,ColumnaAct,ListaPuntos,NumFilas):-
	ColumnaAct1 is ColumnaAct + 1,
	get_code(Stream,ProxChar),
	verificarChar(ProxChar,ListaChar,Stream,FilaAct,ColumnaAct1,ListaPuntos,NumFilas).


resolver(PtosAbiertos, NumFilas, NumColumnas,PtosSalida).




















/*
leerArchivo(Stream,[X|Xs]):-
	get_code(Stream,Char),
	\+ (Char = end_of_file),
	X = Char.
*/

/*
leerArchivo(Stream,[X|Xs]):-
	get_code(Stream,Char),
	\+ verificarChar(Char),
	X = Char,
	leerArchivo(Stream,Xs).

leerArchivo(Stream,[X|Xs]):-
	get_code(Stream,Char),
	verificarChar(Char).
*/
/*
verificarChar(-1,[],_):-  !. % Verifica fin de archivo
verificarChar(end_of_file,[],_):-  !. 

verificarChar(13,[Char|ListaChar],Stream):-
	get_code(Stream,Char),
	verificarChar(Char,ListaChar,Stream).

verificarChar(10,[],_):- !.

verificarChar(32,[Char|ListaChar],Stream):- % leyo un espacio
	get_code(Stream,ProxChar),
	verificarChar(ProxChar,ListaChar,Stream).

verificarChar(Char,[Char|ListaChar],Stream):-
	get_code(Stream,ProxChar),
	verificarChar(ProxChar,ListaChar,Stream).

leerArchivo:-
	
*/
estrella(Lista) :-
	Lista = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P],
	Digitos = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],
	permutar([B,C,D,E],Digitos,Digitos1),
	34 is B + C + D + E,
	permutar([F,J,L],Digitos1,Digitos2),
	34 is B + F + J + L,
	permutar([M,N,O],Digitos2,Digitos3),
	34 is L + M + N + O,
	permutar([K,G],Digitos3,Digitos4),
	34 is E + G + K + O,
	permutar([A,H],Digitos4,Digitos5),
	34 is A + C + F + H,
	permutar([P],Digitos5,Digitos6),
	34 is H + J + M + P,
	permutar([I],Digitos6,DigitosF),
	34 is P + N + K + I,
	34 is I + G + D + A.

/*pemmutar(L1,L2,Res) Unifica los elementos de L1 con L2 y si Res es una variable, se unifica con L1-L2*/
permutar([X|Xs],Lista,Res) :- select(X,Lista,L1), permutar(Xs,L1,Res).
permutar([],Res,Res).

pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth]):-
    number(X),number(Y),number(Bit),number(Depth),X>=0,Y>=0,Bit=0;Bit=1,Depth>=0.

pixrgb(X,Y,R,G,B,Depth,[X,Y,R,G,B,Depth]):-
    number(X),number(Y),number(R),number(G),number(B),number(Depth),X>=0,Y>=0,R>=0,R=<255,G>=0,G=<255,B>=0,B=<255,Depth>=0.

pixhex(X,Y,Hex,Depth,[X,Y,Hex,Depth]):-
    number(X),number(Y),string(Hex),number(Depth),X>=0,Y>=0,Depth>=0.


image(Ancho,Alto,Pixeles,[Ancho,Alto,Pixeles]):-
    number(Ancho),number(Alto),Ancho>=0,Alto>=0.

obtenerPixel([Cabeza|_],Cont,Cabeza):-
   Cont = 2.
obtenerPixel([_|Cola],Cont,Retorno):-
    Cont1 is Cont+1 ,obtenerPixel(Cola,Cont1,Retorno).




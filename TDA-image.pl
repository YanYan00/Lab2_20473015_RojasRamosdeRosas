pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth]):-
    number(X),number(Y),number(Bit),number(Depth),X>=0,Y>=0,Bit=0;Bit=1,Depth>=0.

pixrgb(X,Y,R,G,B,Depth,[X,Y,R,G,B,Depth]):-
    number(X),number(Y),number(R),number(G),number(B),number(Depth),X>=0,Y>=0,R>=0,R=<255,G>=0,G=<255,B>=0,B=<255,Depth>=0.

pixhex(X,Y,Hex,Depth,[X,Y,Hex,Depth]):-
    number(X),number(Y),string(Hex),number(Depth),X>=0,Y>=0,Depth>=0.


image(Ancho,Alto,Pixeles,[Ancho,Alto,PixelesOrdenados]):-
    number(Ancho),number(Alto),Ancho>=0,Alto>=0,sort(Pixeles,PixelesOrdenados).

obtenerPixel(Imagen,Return):-
    image(_,_,PrimerPixel,Imagen),
    PrimerPixel=[Return|_].

imageIsBitmap(Imagen):-
    obtenerPixel(Imagen,Bitmap),
    pixbit(_,_,_,_,Bitmap).

imageIsPixmap(Imagen):-
    obtenerPixel(Imagen,Pixmap),
    pixrgb(_,_,_,_,_,_,Pixmap).

imageIsHexmap(Imagen):-
    obtenerPixel(Imagen,Hexmap),
    pixhex(_,_,_,_,Hexmap).

imageIsCompressed(Imagen):-
    image(Ancho,Alto,Pixeles,Imagen),
    length(Pixeles,CantidadPixeles),
    Var is Ancho*Alto, not(Var = CantidadPixeles).
%-----------------------------------FlipH-----------------------------------------------
pegarLista([],Salida,Salida).
pegarLista([X|Xs],Aux,Salida):-
    pegarLista(Xs,[X|Aux],Salida).

agrupar([],Aux,_,_,Lista,Salida):-
    pegarLista(Aux,Lista,Ultima),reverse(Ultima,Salida).

agrupar(List,Aux,Ancho,Cont,Lista,Salida):-
    Cont=Ancho,
    pegarLista(Aux,Lista,Girada),
    agrupar(List,[],Ancho,0,Girada,Salida).

agrupar([X|Xs],Aux,Ancho,Cont,Lista,Salida):-
    Cont<Ancho,Cont1 is Cont+1,
    agrupar(Xs,[X|Aux],Ancho,Cont1,Lista,Salida).



imageFlipH(Imagen,Imagen2):-
    Imagen = [Ancho,_,Pixeles],
    agrupar(Pixeles,[],Ancho,0,[],Imagen2).












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

girar([],Salida,Salida).
girar([X|Xs],Aux,Salida):-
    girar(Xs,[X|Aux],Salida).

imageFlipH(Imagen,Imagen2):-
    flipH(Imagen,[],Imagen2)










%constructor:pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth])
%pertenencia:pixbit(_,_,_,_,[X,Y,Bit,Depth])True o False
%selector de coord X:pixbit(X1,_,_,_,[X,Y,Bit,Depth])



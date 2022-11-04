:-include("tda-pixhex_20473015_RojasJean").
/*
Meta:Creador de pixel tipo rgb
Variables
X=posicion x del pixel
Y=posicion y del pixel
R=color de red en el pixel
G=color de green en el pixel
B=color de blue en el pixel
D=profundidad pixel
L=lista de datos
Dom:X(interger) x Y(interger) x R(interger)x G(interger) x B(interger) x
Depth(interger) x Datos(lista)
Recorrido: list
pixrgb(X,Y,R,G,B,D,L)
*/
pixrgb(X,Y,R,G,B,Depth,[X,Y,R,G,B,Depth]):-
    integer(X),integer(Y),integer(R),integer(G),integer(B),integer(Depth),X>=0,Y>=0,R>=0,R=<255,G>=0,G=<255,B>=0,B=<255,Depth>=0.
/*
Meta:Comprueba si la imagen es un pixmap
Variables
I=imagen
Dom:Imagen(lista)
Recorrido: booleano
imageIsHexmap(I)
*/
imageIsPixmap(Imagen):-
    obtenerPixel(Imagen,Pixmap),
    pixrgb(_,_,_,_,_,_,Pixmap).

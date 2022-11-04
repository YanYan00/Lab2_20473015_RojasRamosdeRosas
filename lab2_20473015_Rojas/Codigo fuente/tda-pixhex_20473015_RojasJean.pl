:-include("tda-pixbit_20473015_RojasJean").
/*
Meta:Creador de pixel tipo hexadecimal
Variables
X=posicion x del pixel
Y=posicion y del pixel
H=propiedades hexadecimales del pixel
D=profundidad pixel
L=lista de datos
Dom:X(interger) x Y(interger) x Bit(interger) x Depth(interger) x
Datos(lista)
Recorrido: list
pixhex(X,Y,H,D,L)
*/
pixhex(X,Y,Hex,Depth,[X,Y,Hex,Depth]):-
    integer(X),integer(Y),string(Hex),integer(Depth),X>=0,Y>=0,Depth>=0.
/*
Meta:Comprueba si la imagen es un hexmap
Variables
I=imagen
Dom:Imagen(lista)
Recorrido: booleano
imageIsHexmap(I)
*/
imageIsHexmap(Imagen):-
    obtenerPixel(Imagen,Hexmap),
    pixhex(_,_,_,_,Hexmap).


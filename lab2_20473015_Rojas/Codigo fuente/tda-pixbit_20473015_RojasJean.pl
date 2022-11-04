/*
Meta:Creador de pixel tipo bit
Variables
X=posicion x del pixel
Y=posicion y del pixel
B=bit pixel
D=profundidad pixel
L=lista de datos
Dom:X(interger) x Y(interger) x Bit(interger) x Depth(interger) x
Datos(lista)
Recorrido: list
pixbit(X,Y,B,D,L)
*/
pixbit(X,Y,Bit,Depth,[X,Y,Bit,Depth]):-
    integer(X),integer(Y),integer(Bit),integer(Depth),X>=0,Y>=0,Bit=0;Bit=1,Depth>=0.
/*
Meta:obtiene el primer pixel de una imagen
Variables
I=imagen
R=primer pixel de la imagen
Dom:Imagen(lista) x Return(lista)
Recorrido: list
obtenerPixel(I,R)
*/
obtenerPixel(Imagen,Return):-
    Imagen=[_,_,Pixeles],
    Pixeles=[Return|_].
/*
Meta:comprueba si la imagen es un bitmap
Variables
I=imagen
Dom:Imagen(lista)
Recorrido: booleano
imageIsBitmap(I)
*/
imageIsBitmap(Imagen):-
    obtenerPixel(Imagen,Bitmap),
    pixbit(_,_,_,_,Bitmap).

:-include("tda-pixrgb_20473015_RojasJean").
/*
Meta:Creador de imagen
Variables
W=ancho imagen
H=alto imagen
P=pixeles de imagen
Po=pixeles ordenados
Dom: Ancho(interger) x Alto(interger) x Pixeles(lista) x Datos(lista)
Recorrido: imagen
image(W,H,P,[W,H,Po])
*/
image(Ancho,Alto,Pixeles,[Ancho,Alto,PixelesOrdenados]):-
    integer(Ancho),integer(Alto),Ancho>=0,Alto>=0,sort(Pixeles,PixelesOrdenados).
/*
Meta:comprueba si la imagen esta comprimida
Variable
I=imagen
Dom: Imagen(lista)
Recorrido: booleano
imageIsCompressed(I)
*/
imageIsCompressed(Imagen):-
    Imagen=[Ancho,Alto,Pixeles],
    length(Pixeles,CantidadPixeles),
    Var is Ancho*Alto, not(Var = CantidadPixeles).
%-----------------------------------FlipH-----------------------------------------------
/*
Meta:Funcion que pega los datos de una lista invertida en una lista
general
Variable
L=lista con datos invertidos
A=lista de salida que agrupara todos los datos invertidos
S=dato donde se guardara la lista agrupada
Dom:[X|Xs](lista)x Aux(lista) x Salida(lista)
Recorrido: lista
pegarLista(L,A,S)
*/
pegarLista([],Salida,Salida).
pegarLista([X|Xs],Aux,Salida):-
    pegarLista(Xs,[X|Aux],Salida).
/*
Meta:Funcion que agrupa en una lista los datos invertidos
Variables
L=lista con datos
A=auxiliar donde se guardaran los datos invertidos
W=ancho hasta donde se recorrera de la lista para invertir
C=contador que ira desde 0 hasta el ancho
G=lista donde se guardaran todos los datos invertidos de A
S=variable donde se guardara estos datos
Dom: List(lista)x Aux(lista) x Ancho(interger) x Cont(interger) x
Lista(lista) x Salida(lista)
Recorrido: lista
agrupar(L,A,W,C,G,S)
*/
agrupar([],Aux,_,_,Lista,Salida):-
    pegarLista(Aux,Lista,Ultima),reverse(Ultima,Salida).
agrupar(List,Aux,Ancho,Cont,Lista,Salida):-
    Cont=Ancho,
    pegarLista(Aux,Lista,Girada),
    agrupar(List,[],Ancho,0,Girada,Salida).
agrupar([X|Xs],Aux,Ancho,Cont,Lista,Salida):-
    Cont<Ancho,Cont1 is Cont+1,
    agrupar(Xs,[X|Aux],Ancho,Cont1,Lista,Salida).
/*
Meta
*/

cambiarPixel(Lista,X,Y,[X,Y,Conservar1,Conservar2]):-
    Lista = [_,_,Conservar1,Conservar2].
cambiarPixelRgb(Lista,X,Y,[X,Y,R,G,B,Conservar2]):-
    Lista = [_,_,R,G,B,Conservar2].

tamaño(List,X,Y,Lpixel,Salida):-
    Lpixel=4,cambiarPixel(List,X,Y,Salida).
tamaño(List,X,Y,Lpixel,Salida):-
    Lpixel=6,cambiarPixelRgb(List,X,Y,Salida).

arreglarCoordenadas([],_,_,_,Lista,_,Salida):-
    reverse(Lista,Salida).
arreglarCoordenadas(List,Ancho,ContX,ContY,Lista,Lpixel,Salida):-
    ContY=Ancho,Contx is ContX + 1,
    arreglarCoordenadas(List,Ancho,Contx,0,Lista,Lpixel,Salida).
arreglarCoordenadas([X|Xs],Ancho,ContX,ContY,Lista,Lpixel,Salida):-
    ContY<Ancho,Conty is ContY+1,
    tamaño(X,ContX,ContY,Lpixel,Agregar),
    arreglarCoordenadas(Xs,Ancho,ContX,Conty,[Agregar|Lista],Lpixel,Salida).

/*
Meta:invertir una imagen horizontalmente
Variables
I=imagen a girar
I2=imagen girada
Dom:Imagen(lista) x Imagen2(lista)
Recorrido: imagen
imageFlipH(I,I2)
*/
imageFlipH(Imagen,[Ancho,Alto,PixelesOrdenados]):-
    Imagen = [Ancho,Alto,Pixeles],
    Pixeles = [X|_],
    agrupar(Pixeles,[],Ancho,0,[],PixelesGirados),
    length(X,Largo),arreglarCoordenadas(PixelesGirados,Ancho,0,0,[],Largo,PixelesOrdenados).
%----------------------------------FlipV--------------------------------
/*
Meta:Funcion que cambia las coordenadas X de los pixeles de tipo bit o
hex
Variables
L=Pixeles de la imagen
A=Alto de la imagen
L2=Lista de pixeles con su nueva altura
L3=Lista de salida
Dom:[X|Xs](lista)x Alto(int) x Lista(lista)
Recorrido: lista
modificarBitOrHex(L,A,L2,L3)
*/
modificarBitOrHex([],_,Lista,PixelesCambiados):-
    reverse(Lista,PixelesCambiados).
modificarBitOrHex([H|Xs],Alto,Lista,PixelesCambiados):-
    H=[X,Y,Dato,Depth],abs(X-Alto+1,Coord),
    modificarBitOrHex(Xs,Alto,[[Coord,Y,Dato,Depth]|Lista],PixelesCambiados).
/*
Meta:Funcion que cambia las coordenadas X de los pixeles de tipo rgb
Variable
L=Pixeles de la imagen
A=Alto de la imagen
L2=Lista de pixeles con su nueva altura
L3=Lista de salida
Dom:[X|Xs](lista)x Alto(int) x Lista(lista)
Recorrido: lista
modificarRGB(L,A,L2,L3)
*/

modificarRGB([],_,Lista,PixelesCambiados):-
    reverse(Lista,PixelesCambiados).
modificarRGB([H|Xs],Alto,Lista,PixelesCambiados):-
    H=[X,Y,R,G,B,Depth],abs(X-Alto+1,Coord),
    modificarRGB(Xs,Alto,[[Coord,Y,R,G,B,Depth]|Lista],PixelesCambiados).

/*
Meta:Funcion que llama a las modificaciones de pixeles de cada tipo
Variable
Imagen:imagen original
Imagen2:imagen con coordenadas modificadas
Dom:[Ancho,Alto,Pïxeles](lista)x [Ancho,Alto,PïxelesOrdenados](lista)
Recorrido: lista
editar(Imagen,Imagen2)
*/
editar([Ancho,Alto,Pixeles],[Ancho,Alto,PixelesOrdenados]):-
    modificarBitOrHex(Pixeles,Alto,[],PixelesCambiados),sort(PixelesCambiados,PixelesOrdenados).
editarRgb([Ancho,Alto,Pixeles],[Ancho,Alto,PixelesOrdenados]):-
    modificarRGB(Pixeles,Alto,[],PixelesCambiados),sort(PixelesCambiados,PixelesOrdenados).
editarHex([Ancho,Alto,Pixeles],[Ancho,Alto,PixelesOrdenados]):-
    modificarBitOrHex(Pixeles,Alto,[],PixelesCambiados),sort(PixelesCambiados,PixelesOrdenados).
/*
Meta:Funcion que dependiendo del tipo de imagen llama a editar el tipo
de imagen
Variables
Imagen:imagen original
Imagen2:imagen con coordenadas modificadas
Dom:Imagen(lista)x Imagen2(lista)
Recorrido: lista modificarBitOrHex(Imagen,Imagen2)
imageFlipV(Imagen,Imagen2)
*/

imageFlipV(Imagen,ImagenSalida):-
    (imageIsBitmap(Imagen) -> editar(Imagen, ImagenSalida);
     imageIsHexmap(Imagen) -> editarHex(Imagen, ImagenSalida);
     imageIsPixmap(Imagen) -> editarRgb(Imagen, ImagenSalida)).

% ----------------------------------Crop----------------------------------
/*
Meta:Recorta los pixeles, dependiendo de las coordenadas ingresadas, si
se encuentra en los rangos,se guarda ese pixel en una lista
nueva de pixeles
Variables
Pixeles=Lista de pixeles
x1=coordenada x1 para cortar
y1=coordenada y1 para cortar
x2=coordenada x2 para cortar
y2=coordenada y2 para cortar
Pix2=Pixeles acortados
Salida=Pixeles de salida
Dom:[H|Xs](lista)x Dx1(int) x Dx2(int) x Dy1(int) x Dy2(int) x
NuevosPixeles(lista) x Salida (lista)
Recorrido: lista
cortarDatos(Pixeles,x1,y1,x2,y2,Pix2,Salida)
*/
cortarDatos([],_,_,_,_,NuevosPixeles,Salida):-
    reverse(NuevosPixeles,Salida).
cortarDatos([H|Xs],Dx1,Dx2,Dy1,Dy2,NuevosPixeles,Salida):-
    H=[X,Y,Dato,Depth],X>=Dx1,X=<Dx2,Y>=Dy1,Y=<Dy2,
    cortarDatos(Xs,Dx1,Dx2,Dy1,Dy2,[[X,Y,Dato,Depth]|NuevosPixeles],Salida).
cortarDatos([_|Xs],Dx1,Dx2,Dy1,Dy2,NuevosPixeles,Salida):-
    cortarDatos(Xs,Dx1,Dx2,Dy1,Dy2,NuevosPixeles,Salida).
/*
Meta:Recorta los pixeles, dependiendo de las coordenadas ingresadas, si
se encuentra en los rangos,se guarda ese pixel en una lista
nueva de pixeles
Variables
Pixeles=Lista de pixeles
x1=coordenada x1 para cortar
y1=coordenada y1 para cortar
x2=coordenada x2 para cortar
y2=coordenada y2 para cortar
Pix2=Pixeles acortados
Salida=Pixeles de salida
Dom:[H|Xs](lista)x Dx1(int) x Dx2(int) x Dy1(int) x Dy2(int) x
NuevosPixeles(lista) x Salida (lista)
Recorrido: lista
cortarDatos(Pixeles,x1,y1,x2,y2,Pix2,Salida)
*/
cortarDatosRGB([],_,_,_,_,NuevosPixeles,Salida):-
    reverse(NuevosPixeles,Salida).
cortarDatosRGB([H|Xs],Dx1,Dx2,Dy1,Dy2,NuevosPixeles,Salida):-
    H=[X,Y,R,G,B,Depth],X>=Dx1,X=<Dx2,Y>=Dy1,Y=<Dy2,
    cortarDatosRGB(Xs,Dx1,Dx2,Dy1,Dy2,[[X,Y,R,G,B,Depth]|NuevosPixeles],Salida).
cortarDatosRGB([_|Xs],Dx1,Dx2,Dy1,Dy2,NuevosPixeles,Salida):-
    cortarDatosRGB(Xs,Dx1,Dx2,Dy1,Dy2,NuevosPixeles,Salida).
/*
Meta:Devuelve el ultimo pixel de una lista de pixeles
Variables
Pixeles=Lista de pixeles
Ultimo=ultimo pixel de la lista
Dom:[_|Xs](lista)x Y(lista)
Recorrido: lista
cortarDatos(Pixeles,Ultimo)
*/
ultimoDato([Y], Y).
ultimoDato([_|Xs], Y):-
    ultimoDato(Xs, Y).
/*
Meta:Llama a cortarDatos dependiendo del tipo de imagen,aparte llama a
ultimo dato, encontrando el ultimo pixel, asi poder asignar las
nuevas dimensiones de la imagen, en ancho y alto con x e y.
Variables
Pixeles=Lista de pixeles
x1=coordenada x1 para cortar
y1=coordenada y1 para cortar
x2=coordenada x2 para cortar
y2=coordenada y2 para cortar
NuevaImagen=imagen con datos cambiados y nuevas
Dom:[_,_,Pixeles](lista)x Dx1(int) x Dy1(int) x Dx2(int) x Dy2(int) x
Recorrido: lista
cortar - cortarRGB(Pixeles,x1,y1,x2,y2,NuevaImagen)
*/
cortar([_,_,Pixeles],Dx1,Dy1,Dx2,Dy2,[X1,Y1,Datos]):-
    cortarDatos(Pixeles,Dx1,Dx2,Dy1,Dy2,[],Datos),ultimoDato(Datos,Ultimo),Ultimo = [X,Y,_,_],X1 is X+1,Y1 is Y+1.
cortarRGB([_,_,Pixeles],Dx1,Dy1,Dx2,Dy2,[X1,Y1,Datos]):-
    cortarDatosRGB(Pixeles,Dx1,Dx2,Dy1,Dy2,[],Datos),ultimoDato(Datos,Ultimo),Ultimo = [X,Y,_,_],X1 is X+1,Y1 is Y+1.
/*
Meta:Llama a cortar o cortarDatos, dependiendo del tipo de
imagen que sea
Variables
Imagen=Imagen
x1=coordenada x1 para cortar
y1=coordenada y1 para cortar
x2=coordenada x2 para cortar
y2=coordenada y2 para cortar
NuevaImagen=imagen recortada con nuevas dimensiones
Dom:Imagen(lista)x Dx1(int) x Dy1(int) x Dx2(int) x Dy2(int) x
ImagenSalida(lista)
Recorrido: lista
imageCrop(Imagen,x1,y1,x2,y2,NuevaImagen)
*/
imageCrop(Imagen,Dx1,Dy1,Dx2,Dy2,ImagenSalida):-
    (imageIsBitmap(Imagen) -> cortar(Imagen,Dx1,Dy1,Dx2,Dy2, ImagenSalida);
     imageIsHexmap(Imagen) -> cortar(Imagen,Dx1,Dy1,Dx2,Dy2, ImagenSalida);
     imageIsPixmap(Imagen) -> cortarRGB(Imagen,Dx1,Dy1,Dx2,Dy2, ImagenSalida)).
% -----------------------------------imageRGBToHex------------------------

/*
Meta:transforma los datos rgb en hex,aplica upper para hacerlo
mayuscula y aplica concat para concatenar # con el hex
Variables
P=pixeles de la imagen
L=lista donde se guardaran los pixhex creados
LN=pixeles de salida
Dom:[H|Xs](lista)x Lista(lista) x Salida(lista)
Recorrido: lista
rgbToHex(P,L,LN)
*/

rgbToHex([],Lista,NuevosHex):-
    reverse(Lista,NuevosHex).
rgbToHex([H|Xs],Lista,Salida):-
    H=[X,Y,R,G,B,Depth],hex_bytes(Hex,[R,G,B]),string_upper(Hex,HexMayus),string_concat("#",HexMayus,Completado),
    rgbToHex(Xs,[[X,Y,Completado,Depth]|Lista],Salida).
/*
Meta:Llama a rgbToHex para cambiar los datos de pixeles
Variables
P=pixeles de la imagen
L=lista donde se guardaran los pixhex creados
Dom:[_,_,Pixeles](lista)x PixelesHex(lista)
Recorrido: lista
separarPixeles(P,L)
*/
separarPixeles([_,_,Pixeles],PixelesHex):-
    rgbToHex(Pixeles,[],PixelesHex).
/*
Meta:Llama a separarPixeles
Variables
I=imagen
I2=imagen hex de salida
Dom:Imagen(lista)x [Ancho,Alto,ImagenSalida](lista)
Recorrido: lista
imageRGBToHex(I,I2)
*/
imageRGBToHex(Imagen,[Ancho,Alto,ImagenSalida]):-
   Imagen = [Ancho,Alto,_],separarPixeles(Imagen,ImagenSalida).
%------------------------------------imageToHistogram----------------------
/*
Meta:Devuelve una lista solo con los colores de las imagenes
Variables
L=lista de pixeles
L2=lista de colores
L3=lista de salida
filtrarColores - filtrarColoresRGB(L,L2,L3)
*/
filtrarColores([],Lista,Colores):-
    reverse(Lista,Colores).
filtrarColores([H|Xs],Lista,Salida):-
    H=[_,_,Dato,_],
    filtrarColores(Xs,[[Dato]|Lista],Salida).
filtrarColoresRGB([],Lista,Colores):-
    reverse(Lista,Colores).
filtrarColoresRGB([H|Xs],Lista,Salida):-
    H=[_,_,R,G,B,_],
    filtrarColoresRGB(Xs,[[R,G,B]|Lista],Salida).
/*
Meta:comprueba si 2 datos son iguales
Variables
X=dato a comparar
Y=dato a comparar
equals(X,Y)
*/
equals(X, Y):- X = Y.
/*
Meta:cuenta cuantas veces se repite un dato en una lista
Variables
L=lista de datos
D=dato a revisar
C=contador
S=lista entre contador y dato
Dom:[X|Xs](lista) x Dato(dato de cualquier tipo) x Cont(int) x
Salida(int)
contador(L,D,C,S)
*/
contador([],Dato,Cont,[Cont,Dato]).
contador([X|Xs],Dato,Cont,Salida):-
    equals(X,Dato),Cont1 is Cont+1,
    contador(Xs,Dato,Cont1,Salida).
contador([_|Xs],Dato,Cont,Salida):-
    contador(Xs,Dato,Cont,Salida).
/*
Meta:saca de una lista todos los elementos que se repitan de un dato
Variables
L=lista de datos
D=dato a revisar
L2=Lista en la que estaran filtrados los datos
S=lista de salida
Dom:[X|Xs](lista) x Dato(dato de cualquier tipo) x Lista(lista) x
ListaSalida(lista)
contador(L,D,L2,S)
*/
quitarDeLista([],_,Lista,Filtrada):-
    reverse(Lista,Filtrada).
quitarDeLista([X|Xs],Dato,Lista,ListaSalida):-
    equals(X,Dato),
    quitarDeLista(Xs,Dato,Lista,ListaSalida).
quitarDeLista([X|Xs],Dato,Lista,ListaSalida):-
    quitarDeLista(Xs,Dato,[X|Lista],ListaSalida).
/*
Meta:Llama a contador para contar los elementos de la lista, luego llama
a quitarDeLista para poder eliminar el elemento de la lista de pixeles
Variables
L=lista de datos
L2=lista en la que se agregara el contador y el dato encapsulados en una
lista
L3=Lista de salida
Dom:List(lista) x Lista(lista) x Salida(Lista)
contador(L,L2,L3)
*/
filtrarColor([],Lista,Salida):-
    reverse(Lista,Salida).
filtrarColor(List,Lista,Salida):-
    List=[X|_],
    contador(List,X,0,Contado),quitarDeLista(List,X,[],NuevaLista),
    filtrarColor(NuevaLista,[Contado|Lista],Salida).
/*
Meta:filtrar colores de las imagenes, luego aplicarle un filtro a esos
colores para contarlos y borrarlos de una lista
Variables
I=imagen
I2=imagen de salida
Dom:Imagen(lista) x Salida(lista)
imageToHistogram(I,I2)
*/
imageToHistogram(Imagen,Salida):-
  Imagen=[_,_,Pixeles],
 (imageIsBitmap(Imagen) -> filtrarColores(Pixeles,[],ListaDatos),filtrarColor(ListaDatos,[],Salida);
  imageIsHexmap(Imagen) -> filtrarColores(Pixeles,[],ListaDatos),filtrarColor(ListaDatos,[],Salida);
  imageIsPixmap(Imagen) -> filtrarColoresRGB(Pixeles,[],ListaDatos),filtrarColor(ListaDatos,[],Salida)).
% -----------------------------------Rotate90---------------------------
/*
Meta: Cambia las coordenadas de Y
Variables
L=Lista de pixeles
A=Ancho de la imagen
L2=Lista con las coordenadas cambiadas
L3=Lista de Salida
cambiarCoord - cambiarCoordRGB(L,A,L2,L3)
*/
cambiarCoord([],_,Lista,Pixeles):-
    reverse(Lista,Salida),sort(Salida,Pixeles).
cambiarCoord([H|Xs],Ancho,Lista,Salida):-
    H=[X,Y,Dato,Depth],abs(Y-Ancho-1,X1),abs(X-Ancho+1,Y1),
    cambiarCoord(Xs,Ancho,[[X1,Y1,Dato,Depth]|Lista],Salida).

/*
Meta: Cambia las coordenadas de X
Variables
L=Lista de pixeles
A=Ancho de la imagen
C=Contador que lleva la cuenta del ancho
C2=Contador que aumenta para cambiar la altura
L2=Lista con las coordenadas cambiadas
L3=Lista de Salida
cambiarX - cambiarXRGB(L,A,C,C2,L2,L3)
*/
cambiarX([],_,_,_,Lista,Salida):-
    reverse(Lista,Salida).
cambiarX([H|Xs],Ancho,Contador,Cont,Lista,Salida):-
    H=[_,Y,Dato,Depth],Contador<Ancho,Contador1 is Contador+1,
    cambiarX(Xs,Ancho,Contador1,Cont,[[Cont,Y,Dato,Depth]|Lista],Salida).
cambiarX([H|Xs],Ancho,Contador,Cont,Lista,Salida):-
    H=[_,Y,Dato,Depth],
    Contador = Ancho,Cont1 is Cont+1,
    cambiarX(Xs,Ancho,1,Cont1,[[Cont1,Y,Dato,Depth]|Lista],Salida).

cambiarCoordRGB([],_,Lista,Pixeles):-
    reverse(Lista,Salida),sort(Salida,Pixeles).
cambiarCoordRGB([H|Xs],Ancho,Lista,Salida):-
    H=[X,Y,R,G,B,Depth],abs(Y-Ancho-1,X1),abs(X-Ancho+1,Y1),
    cambiarCoordRGB(Xs,Ancho,[[X1,Y1,R,G,B,Depth]|Lista],Salida).

cambiarXRGB([],_,_,_,Lista,Salida):-
    reverse(Lista,Salida).
cambiarXRGB([H|Xs],Ancho,Contador,Cont,Lista,Salida):-
    H=[_,Y,R,G,B,Depth],Contador<Ancho,Contador1 is Contador+1,
    cambiarXRGB(Xs,Ancho,Contador1,Cont,[[Cont,Y,R,G,B,Depth]|Lista],Salida).
cambiarXRGB([H|Xs],Ancho,Contador,Cont,Lista,Salida):-
    H=[_,Y,Dato,Depth],
    Contador = Ancho,Cont1 is Cont+1,
    cambiarXRGB(Xs,Ancho,1,Cont1,[[Cont1,Y,Dato,Depth]|Lista],Salida).

/*
Meta: Cambia las coordenadas de los pixeles, luego los da vuelta, para
cambiar los datos en x y teminar ordenando la lista
Variables
I=Imagen
I2=Imagen de Salida
imageRotate90(L,A,C,C2,L2,L3)
*/
imageRotate90(Imagen,[Alto,Ancho,Datos]):-
    Imagen=[Ancho,Alto,Pixeles],
    (imageIsBitmap(Imagen) ->  cambiarCoord(Pixeles,Ancho,[],Pix),reverse(Pix,Pix2),cambiarX(Pix2,Ancho,0,0,[],Pix3),sort(Pix3,Datos);
     imageIsHexmap(Imagen) ->  cambiarCoord(Pixeles,Ancho,[],Pix),reverse(Pix,Pix2),cambiarX(Pix2,Ancho,0,0,[],Pix3),sort(Pix3,Datos);
     imageIsPixmap(Imagen) ->  cambiarCoordRGB(Pixeles,Ancho,[],Pix),reverse(Pix,Pix2),cambiarXRGB(Pix2,Ancho,0,0,[],Pix3),sort(Pix3,Datos)).
% --------------------imagenInvertColorRGB--------------------------------
/*
Meta: cambia el color de los pixeles por el valor absoluto de la resta
de estos con 155
Variables
P=pixeles
L=Lista de pixeles nuevos
P2=pixeles de Salida
invertir(P,L,P2)
*/
invertir([],Lista,Salida):-
    reverse(Lista,Salida).
invertir([H|Xs],Lista,Salida):-
    H=[X,Y,R,G,B,Depth],abs(R-255,R1),abs(G-255,G1),abs(B-255,B1),
    invertir(Xs,[[X,Y,R1,G1,B1,Depth]|Lista],Salida).
/*
Meta: Hace un llamado a invertir para cambiar los datos de los pixeles y
devolver una nueva imagen
Variables
I=imagen
I2=imagen nueva
imagenInvertColorRGB(I,I2)
*/
imagenInvertColorRGB([Ancho,Alto,Pixeles],[Ancho,Alto,Cambiados]):-
    invertir(Pixeles,[],Cambiados).
% ------------------------------imageChangePixel--------------------------
/*
Meta: Cuando el pixel buscado sea igual que la cabeza de la lista esta
cambia sus datos al pixel ingresado
Variables
P=pixeles
Pb=pixel buscado
L=Lista de pixeles nuevos
P2=pixeles de Salida
buscar(P,Pb,L,P2)
*/
buscar([],_,Lista,Salida):-
    reverse(Lista,Salida).
buscar([H|Xs],Pixel,Lista,Salida):-
    H=[CoordX,CoordY,_,_],Pixel = [X,Y,_,_],CoordX1 is CoordX,CoordY1 is CoordY,X1 is X,Y1 is Y,(CoordX1 = X1 ),(CoordY1 = Y1),
    buscar(Xs,Pixel,[Pixel|Lista],Salida).
buscar([H|Xs],Pixel,Lista,Salida):-
    buscar(Xs,Pixel,[H|Lista],Salida).
/*
Meta: Cuando el pixel buscado sea igual que la cabeza de la lista esta
cambia sus datos al pixel ingresado
Variables
P=pixeles
Pb=pixel buscado
L=Lista de pixeles nuevos
P2=pixeles de Salida
buscarRGB(P,Pb,L,P2)
*/
buscarRGB([],_,Lista,Salida):-
    reverse(Lista,Salida).
buscarRGB([H|Xs],Pixel,Lista,Salida):-
    H=[CoordX,CoordY,_,_,_,_],Pixel = [X,Y,_,_,_,_],CoordX1 is CoordX,CoordY1 is CoordY,X1 is X,Y1 is Y,(CoordX1 = X1 ),(CoordY1 = Y1),
    buscarRGB(Xs,Pixel,[Pixel|Lista],Salida).
buscarRGB([H|Xs],Pixel,Lista,Salida):-
    buscarRGB(Xs,Pixel,[H|Lista],Salida).
/*
Meta: Se hace llamada a buscar dependiendo del tipo de imagen que sea.
Variables
I=imagen
Pb=pixel buscado
I2=Se devuelve una imagen con el pixel buscado cambiado
imageChangePixel(I,Pb,I2)
*/

imageChangePixel(Imagen,Pixel,[Ancho,Alto,Modificado]):-
    Imagen=[Ancho,Alto,Pixeles],
    (imageIsBitmap(Imagen) ->  buscar(Pixeles,Pixel,[],Modificado);
     imageIsHexmap(Imagen) ->  buscar(Pixeles,Pixel,[],Modificado);
     imageIsPixmap(Imagen) ->  buscarRGB(Pixeles,Pixel,[],Modificado)).
% ----------------------------imageToString----------------------------------------
/*
Meta: Concatena los datos con colores + espacio + tabulador, al momento
de que se alcance el ancho en contador se le concatena un salto de
linea.
Variables
P=pixeles
A=ancho de imagen
C=contador
Pa=palabra
S=palabra de salida
stringHB(P,A,C,Pa,S)
*/
stringHB([],_,_,Palabra,Palabra).
stringHB([H|Xs],Ancho,Contador,Palabra,Salida):-
    H=[_,_,Dato,Depth],Contador<Ancho,Contador1 is Contador+1,string_concat(Palabra,Dato,Palabra1),string_concat(Palabra1," ",Palabra2),string_concat(Palabra2,Depth,Palabra3),string_concat(Palabra3,"\t",PalabraSalida),
    stringHB(Xs,Ancho,Contador1,PalabraSalida,Salida).
stringHB(Lista,Ancho,Contador,Palabra,Salida):-
    Contador = Ancho,string_concat(Palabra,"\n",Palabra1),
    stringHB(Lista,Ancho,0,Palabra1,Salida).
/*
Meta: Concatena los datos con colores + espacio + tabulador, al momento
de que se alcance el ancho en contador se le concatena un salto de
linea.
Variables
P=pixeles
A=ancho de imagen
C=contador
Pa=palabra
S=palabra de salida
stringRGB(P,A,C,Pa,S)
*/
stringRGB([],_,_,Palabra,Palabra).
stringRGB([H|Xs],Ancho,Contador,Palabra,Salida):-
    H=[_,_,R,G,B,Depth],Contador<Ancho,Contador1 is Contador+1,string_concat(Palabra,R,Palabra1),string_concat(Palabra1," ",Palabra2),string_concat(Palabra2,G,Palabra3),string_concat(Palabra3," ",Palabra4),string_concat(Palabra4,B,Palabra5),string_concat(Palabra5," ",Palabra6),string_concat(Palabra6,Depth,Palabra7),string_concat(Palabra7,"\t",PalabraSalida),
    stringRGB(Xs,Ancho,Contador1,PalabraSalida,Salida).
stringRGB(Lista,Ancho,Contador,Palabra,Salida):-
    Contador = Ancho,string_concat(Palabra,"\n",Palabra1),
    stringRGB(Lista,Ancho,0,Palabra1,Salida).
/*
Meta:Dependiendo del tipo de imagen se hace un llamado a string puesto
que puede usar para bit o hex stringhb mientras que puede usar
stringRGB para imagenes rgb
Variables
I=imagen
Pa=palabra
imageToString(I,Pa)
*/
imageToString([Ancho,_,Pixeles],Palabra):-
    Imagen=[Ancho,_,Pixeles],
    (imageIsBitmap(Imagen) ->  stringHB(Pixeles,Ancho,0," ",Palabra);
     imageIsHexmap(Imagen) ->  stringHB(Pixeles,Ancho,0," ",Palabra);
     imageIsPixmap(Imagen) ->  stringRGB(Pixeles,Ancho,0," ",Palabra)).






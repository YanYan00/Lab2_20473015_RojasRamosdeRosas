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

*/
cambiarPixel(Lista,X,Y,[X,Y,Conservar1,Conservar2]):-
    Lista = [_,_,Conservar1,Conservar2].
cambiarPixelRgb(Lista,X,Y,[X,Y,R,G,B,Conservar2]):-
    Lista = [_,_,R,G,B,Conservar2].

tama�o(List,X,Y,Lpixel,Salida):-
    Lpixel=4,cambiarPixel(List,X,Y,Salida).
tama�o(List,X,Y,Lpixel,Salida):-
    Lpixel=6,cambiarPixelRgb(List,X,Y,Salida).

arreglarCoordenadas([],_,_,_,Lista,_,Salida):-
    reverse(Lista,Salida).
arreglarCoordenadas(List,Ancho,ContX,ContY,Lista,Lpixel,Salida):-
    ContY=Ancho,Contx is ContX + 1,
    arreglarCoordenadas(List,Ancho,Contx,0,Lista,Lpixel,Salida).
arreglarCoordenadas([X|Xs],Ancho,ContX,ContY,Lista,Lpixel,Salida):-
    ContY<Ancho,Conty is ContY+1,
    tama�o(X,ContX,ContY,Lpixel,Agregar),
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












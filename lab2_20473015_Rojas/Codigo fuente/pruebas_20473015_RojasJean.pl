/*
 Ejemplo 1:
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I).
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC),  image( 2, 2, [PA, PB, PC], I), imageIsCompressed( I ).
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsCompressed( I).
pixbit( 0, 1, 1, 10, PA), pixbit( 0, 0, 0, 20, PB), pixbit( 1, 0, 0, 30, PC), pixbit( 1, 1, 1, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipH( I,I2 ).

Ejemplo 2:
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap( I ).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap( I ).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap( I ).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), image( 2, 2, [PA, PB, PC], I), imageIsCompressed( I ).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsCompressed( I ).
pixhex( 0, 0, "#FF0000", 10, PA), pixhex( 0, 1, "#FF0000", 20, PB), pixhex( 1, 0, "#0000FF", 30, PC), pixhex( 1, 1, "#0000FF", 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipH( I,I2 ).

Ejemplo 3:
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), pixrgb( 1, 1, 0, 78, 215, 4, PD), image( 2, 2, [PA, PB, PC, PD], I).
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), pixrgb( 1, 1, 0, 78, 215, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsBitmap(I).
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), pixrgb( 1, 1, 0, 78, 215, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsPixmap(I).
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), pixrgb( 1, 1, 0, 78, 215, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsHexmap(I).
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), image( 2, 2, [PA, PB, PC], I), imageIsCompressed( I ).
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), pixrgb( 1, 1, 0, 78, 215, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageIsCompressed (I).
pixrgb( 0, 0, 215, 0, 4, 10, PA), pixrgb( 0, 1, 25, 0, 1, 20, PB), pixrgb( 1, 0, 45, 0, 215, 30, PC), pixrgb( 1, 1, 0, 78, 215, 4, PD), image( 2, 2, [PA, PB, PC, PD], I), imageFlipH(I,I2).
*/

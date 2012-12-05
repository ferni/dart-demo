part of juego;

class Fisica {
  static void procesarPj(Personaje pj, Nivel nivel){
    var cuadros = _cuadrosQueToca(pj);
    _alterarVelocidadPj(cuadros, pj, nivel);
  }

  ///De los 8 cuadros que rodean al pj, cuales toca
  static _cuadrosQueToca(Personaje pj){

    var cuadrosCercanos = <List>[<bool>[false,false,false],//true si toca
                                 [false,true,false],
                                 [false,false,false]];
    var posCuadro = new Point(pj.pos.x % pj.juego.config.largoCuadro, pj.pos.y % pj.juego.config.largoCuadro);
    if(posCuadro.x < pj.radio) cuadrosCercanos[1][0] = true;
    if(posCuadro.y < pj.radio) cuadrosCercanos[0][1] = true;
    if(posCuadro.x > (pj.juego.config.largoCuadro - pj.radio)) cuadrosCercanos[1][2] = true;
    if(posCuadro.y > (pj.juego.config.largoCuadro -pj.radio)) cuadrosCercanos[2][1] = true;
    //diagonales
    if(cuadrosCercanos[1][0]){
      if(cuadrosCercanos[0][1])cuadrosCercanos[0][0] = true;
      if(cuadrosCercanos[2][1])cuadrosCercanos[2][0] = true;
    }
    if(cuadrosCercanos[1][2]){
      if(cuadrosCercanos[0][1])cuadrosCercanos[0][2] = true;
      if(cuadrosCercanos[2][1])cuadrosCercanos[2][2] = true;
    }
    return cuadrosCercanos;
  }

  static _alterarVelocidadPj(cuadrosQueToca, Personaje pj, Nivel nivel){
    var posAnterior = pj.pos;
    var cuadrantePj = Nivel.posToCuadrante(posAnterior.x,posAnterior.y, pj.juego.config);
    var nuevaVelocidad = new Vector(pj.velocidadActual.x, pj.velocidadActual.y);
    for(int x=0; x < 3; x++){
      for(int y=0; y < 3; y++){
        if((x != 1 || y != 1)//no es el del medio
            && cuadrosQueToca[y][x]  //toca ese cuadro
        && ((cuadrantePj.y.toInt() + (y-1) < 0 || cuadrantePj.x.toInt() + (x-1) < 0)//si está fuera del nivel...
            || nivel.cuadros[cuadrantePj.y.toInt() +(y-1)][cuadrantePj.x.toInt() + (x-1)].solido) //...o es solido
        ){

          bool esDiagonal = x == y || (x== 2 && y==0) || (y == 2 && x== 0);

          //Rebote X
          if(x-1 != 0 && signo(pj.velocidadActual.x) == signo(x - 1)//va en esa direccion
            ){
            logRebote("x", x,y);
            nuevaVelocidad.x = -pj.velocidadActual.x;
            pj.pos.x = posAnterior.x;
          }
          //Rebote Y
          if(/*pj.pos.y != posAnterior.y
              && */y-1 != 0 && signo(pj.velocidadActual.y) == signo(y - 1)//va en esa direccion
              //&&(!esDiagonal || pj.velocidadActual.y >= pj.velocidadActual.x)
            ){
            logRebote("y", x,y);
            nuevaVelocidad.y = -pj.velocidadActual.y;
            pj.pos.y = posAnterior.y;
          }

      }//fin if rebote

    }//fin for y
  }//fin for x

  if(pj.velocidadActual.x != nuevaVelocidad.x || pj.velocidadActual.y != nuevaVelocidad.y) {
    log("   ----");
  }
  pj.velocidadActual.x = nuevaVelocidad.x;
  pj.velocidadActual.y = nuevaVelocidad.y;

  }

  static void logRebote(eje, cuadranteColisionX,cuadranteColisionY){
    log("Eje: $eje");
    log("Cuadrante: (${cuadranteColisionX- 1},${cuadranteColisionY- 1})");
  }
}

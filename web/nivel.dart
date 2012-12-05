part of juego;

abstract class IDibujable{
  void dibujar(x,y,CanvasRenderingContext2D context, Estado estado, Config config);
}

class Nivel implements IDibujable
{
  var raw;
  var cuadros = new List();//de lista de cuadros
  Nivel(List<String> this.raw){
    load();

  }

  void logCuadros(){
    for(int i = 0; i < cuadros.length; i++){
      for(int j = 0; j < cuadros[i].length; j++){
        log("$i,$j: ${cuadros[i][j].toString()}");
      }
    }
  }

  void load(){
    for(int i = 0; i< raw.length; i++)
    {
        cuadros.add(new List<Cuadro>());
        var pisoActual = cuadros[cuadros.length - 1];
        for(int j = 0; j < largo(); j++){
          if(j < raw[i].length) {
            pisoActual.add(_rawToCuadro(raw[i][j]));
          } else {
            pisoActual.add(new Aire());
          }
        }
    }
  }

  Cuadro _rawToCuadro(String identificador){
    switch(identificador){
      case '_':return new Piso();
      case '^': return new Rampa();
      case '#': return new Caja();
      default: return new Aire();
    }
  }

  int largo() => raw[raw.length - 1].length;//(largo del piso)

  static Point posToCuadrante(x,y,config) => new Point(x ~/ config.largoCuadro, y ~/ config.largoCuadro);
  Cuadro getCuadro(x,y) => cuadros[x][y];

  void dibujar(x,y, context, Estado estado, Config config){
    int indicePrimerAssetDibujado = estado.scroll ~/ config.largoCuadro;
    if(indicePrimerAssetDibujado < 0) indicePrimerAssetDibujado= 0;
    int indiceUltimoAssetDibujado = indicePrimerAssetDibujado + (context.canvas.width ~/ config.largoCuadro) + 1;
    if(indiceUltimoAssetDibujado >= cuadros[cuadros.length-1].length) indiceUltimoAssetDibujado = cuadros[cuadros.length-1].length - 1;
    //nivel[nivel.length-1] debe ser el mas largo (es el piso)

    int offsetY = 0;
    int offsetX = -estado.scroll;

    for(num piso = 0; piso < cuadros.length; piso++)
    {
      for(num i = indicePrimerAssetDibujado; i< cuadros[piso].length && i <= indiceUltimoAssetDibujado; i++){
        cuadros[piso][i].dibujar(offsetX + (i  * config.largoCuadro), offsetY + (piso * config.largoCuadro)
            ,context, estado, config);
      }
    }
  }


}

///Asset que está encajado en un cuadrante
abstract class Cuadro implements IDibujable{
  bool solido = true;
  void dibujar(x,y, context, estado, config);
}

class Caja extends Cuadro{
  void dibujar(x,y, context, estado, config){
    context.beginPath();
    context.strokeStyle = "maroon";
    context.strokeRect(x,y,config.largoCuadro,config.largoCuadro);
  }
}

class Rampa extends Cuadro{
  Rampa(){
    solido = false;
  }
  void dibujar(x,y, context, estado, config){

    context.beginPath();
    context.strokeStyle = "red";
    context.moveTo(x, y + config.largoCuadro);
    var _mitadLargo = config.largoCuadro ~/ 2 ;
    context.lineTo(x+_mitadLargo, y + _mitadLargo);
    context.lineTo(x+config.largoCuadro, y+ config.largoCuadro);
    context.stroke();
  }

}

class Piso extends Cuadro{
  void dibujar(x,y, context, estado, config){
  context.strokeStyle = "green";
  context.moveTo(x, y);
  context.lineTo(x+config.largoCuadro, y);
  context.stroke();
  }
}

class Aire extends Cuadro{
  Aire(){
    solido = false;
  }
  void dibujar(x,y, context, estado, config){}
}
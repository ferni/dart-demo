part of juego;

class Config{
  num largoCuadro = 30;
}

class Juego {
  num nroNivel = 0;
 var nivelActual;
  var cinematicaActual = null;//Cinematica.panorama();
  Personaje pj;
  Estado estado;
  Graficos graficos;
  CanvasElement canvas;
  Teclas teclas;
  Config config;

  Juego(CanvasElement this.canvas){
    pj = new Personaje(this, 45, 45);
    estado = new Estado(0, pj);
    config = new Config();
    graficos = new Graficos(canvas.context2d, config);
    teclas = new Teclas(estado);
    _cargarNivel(nroNivel);
  }

  void _cargarNivel(int nro){
    nivelActual = new Nivel(niveles[nro]);
  }

  void start(){
    window.requestAnimationFrame(animar);
  }

  void animar(num time){
    if(cinematicaActual != null){
      if(!cinematicaActual.termino){
        graficos.dibujar(niveles[nroNivel], cinematicaActual.getEstado());
      }else{
        cinematicaActual = null;
      }
    }else{//no hay cinematica
      update();
      graficos.dibujar(nivelActual, estado);
    }
    window.requestAnimationFrame(animar);
  }

///Modifica el estado
void update(){
  pj.update();

  //Ajustar el scroll a la pocision de pj
  var mitadCanvas=canvas.width ~/ 2;
  //clearLog();
  //log("x:${pj.pos.x} y:${pj.pos.y} largo: ${nivelActual.largo()}");
  if(pj.pos.x >= mitadCanvas && pj.pos.x <= (nivelActual.largo()*config.largoCuadro) - mitadCanvas) {
    estado.scroll = ((pj.pos.x - mitadCanvas) ~/ 1).toInt();
  }

}

}


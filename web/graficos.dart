part of juego;


//Las rectas son de 10px cada una

class Graficos {
  CanvasRenderingContext2D context;//el context2D del canvas principal
  Config config;
  int _largoRecta, _mitadLargo;

  Graficos(this.context, this.config){
    _largoRecta= config.largoCuadro;//el largo en pixeles de cada asset
    _mitadLargo = _largoRecta ~/ 2;
  }


  ///El scroll es cuantos pixeles esta corrida la pantalla para la derecha del nivel
  void dibujar(Nivel nivel, Estado estado){
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);
    context.beginPath();
    nivel.dibujar(0,0,context,estado, config);
    _dibujarPj(estado.pj, estado.scroll);

  }

  void _dibujarPj(Personaje pj, int scroll)
  {
    if(pj != null) {
      dibujarCirculo(pj.pos.x - scroll, pj.pos.y, pj.radio);
    }
  }


  void dibujarCirculo(x, y, r)
  {
    context.beginPath();
    context.strokeStyle = "blue";
    context.arc(x,y,r,0, PI*2, false);
    context.stroke();
  }



}


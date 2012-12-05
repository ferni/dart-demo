part of juego;

class Teclas {
  Estado estado;
  Teclas(this.estado){
    window.on.keyDown.add(this.procesarKeyPress);
    window.on.keyUp.add(this.procesarKeyUp);
  }

  void procesarKeyUp(KeyboardEvent e){
    switch(e.keyCode)
    {
      case 87://W
      {
        estado.pj.moviendo.y = 0;

    }break;
    case 65://A
    {
        estado.pj.moviendo.x = 0;
    }break;
    case 83://S
    {
        estado.pj.moviendo.y = 0;
    }break;
    case 68://D
    {
        estado.pj.moviendo.x = 0;
    }break;

  }
}

void procesarKeyPress(KeyboardEvent e){
  switch(e.keyCode)
  {
    case 87://W 119:
    {
      estado.pj.moviendo.y = -1;

    }break;
    case 65://A97://
    {
      estado.pj.moviendo.x = -1;
    }break;
    case 83://S115://
    {
      estado.pj.moviendo.y = 1;
    }break;
    case 68://D100://
    {
      estado.pj.moviendo.x = 1;
    }break;

  }//fin switch

  //log("presionada la tecla ${e.keyIdentifier} ,codigo: ${e.keyCode}");
  }

}
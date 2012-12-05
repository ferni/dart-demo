///Guarda el estado actual del juego

part of juego;

class Estado {
  int scroll;
  Personaje pj;
  Estado(this.scroll, this.pj);
  Estado.sinPj(int scroll) : this.scroll =scroll;
}

class Cinematica{
  var estados = new List<Estado>();
  num cuadroActual= -1;
  Cinematica(this.estados);
  bool termino = false;

  Estado getEstado(){

      cuadroActual++;
      if(cuadroActual >= estados.length - 1){ termino = true;}

      return estados[cuadroActual];
  }



  static Cinematica panorama(){
    var estados = new List<Estado>();
    for(num i = 0; i< 200; i++){
      estados.add(new Estado.sinPj(i));
    }
    for(num i = 200; i>= 0; i--){
      estados.add(new Estado.sinPj(i));
    }
    return new Cinematica(estados);
  }
}

class Personaje
{

    num velocidadMax = 5, aceleracion = 0.3, desaceleracion = 0.3;
    num radio = 10;
    Juego juego;
    Vector pos;
    Vector moviendo = new Vector(0,0); //que flechas estoy apretando -1,0 1
    Vector velocidadActual = new Vector(0,0);

    Personaje(this.juego,x,y){
      pos = new Vector(x,y);
    }

    void update(){
      if(moviendo.x == 0 && moviendo.y == 0){//si el jugador no lo mueve, desacelerar
        velocidadActual.x -= ( desaceleracion* signo(velocidadActual.x));
        if(velocidadActual.x <= desaceleracion && velocidadActual.x >= -desaceleracion) velocidadActual.x = 0;
        velocidadActual.y -= ( desaceleracion* signo(velocidadActual.y));
        if(velocidadActual.y <= desaceleracion && velocidadActual.y >= -desaceleracion) velocidadActual.y = 0;
      }
      else{
        velocidadActual += (moviendo *new Vector.i(aceleracion));
        if(velocidadActual.x > velocidadMax) velocidadActual.x = velocidadMax;
        if(velocidadActual.x < -velocidadMax) velocidadActual.x = -velocidadMax;
        if(velocidadActual.y > velocidadMax) velocidadActual.y = velocidadMax;
        if(velocidadActual.y < -velocidadMax) velocidadActual.y = -velocidadMax;
      }

      pos += velocidadActual;

      Fisica.procesarPj(this, juego.nivelActual);

    }
}



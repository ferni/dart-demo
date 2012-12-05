part of juego;

int signo(num valor){
  if(valor >= 0) return 1;
  return -1;
}


class Vector {
  num x,y;
  Vector(this.x, this.y);
  Vector.i(num a){
    x = a; y = a;
  }

  Vector operator +(Vector v) { // Overrides + (a + b).
    return new Vector(x + v.x, y + v.y);
  }

  Vector operator -(Vector v) { // Overrides - (a - b).
    return new Vector(x - v.x, y - v.y);
  }

  Vector operator *(Vector v) {
    return new Vector(x * v.x, y * v.y);
  }

/*
  Vector operator negate() {    // Overrides unary negation (-a).
    return new Vector(-x,-y);
  }*/

  String toString() => '($x,$y)';
}
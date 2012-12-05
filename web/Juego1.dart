library juego;

import 'dart:html';
import 'dart:math';

part "graficos.dart";
part "teclas.dart";
part "estado.dart";
part "debug.dart";
part "juego.dart";
part "utils.dart";
part "datos.dart";
part "nivel.dart";
part "fisica.dart";

void main() {
  CanvasElement canvas = query("#pantalla");
  Juego juego = new Juego(canvas);
  juego.start();

  log(niveles[0][0][0]);
}







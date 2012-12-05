part of juego;

var debugMode = false;

var logAnterior;
var vecesRepetidas = 1;

log(mensaje){
  if(!debugMode) return;
  if(queryAll("#debugInfo span").length > 20) {
    clearLog();
  }

  var cuadritoInfo = query("#debugInfo");
  if(mensaje == logAnterior)
  {
    clearLog();
    vecesRepetidas++;
  }
  else {
    vecesRepetidas = 1;
  }

  cuadritoInfo.addHtml("<span>$mensaje</span><br/>");
  if(vecesRepetidas > 1) {
    cuadritoInfo.addHTML("<span>x $vecesRepetidas </span>");
  }

  logAnterior = mensaje;
}

clearLog(){
  if(!debugMode) return;
  var infos = queryAll("#debugInfo span, #debugInfo br");
  for(Element info in infos){
    info.remove();
  }
}
function muestratiempo(tf)
  if tf<60
    fprintf('\nTiempo en segundos: %.3f sg.\n\n',tf);
  else
    fprintf('Tiempo en minutos: %.3f min.\n\n',tf/60);  
  end
end
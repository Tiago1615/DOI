function [valor] = reparar(valor, minimo, maximo)

if valor < minimo
    valor = minimo;
end

if valor > maximo
    valor = maximo;
end

end
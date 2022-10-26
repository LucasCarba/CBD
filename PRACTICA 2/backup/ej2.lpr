program project1;
const
  valorDeCorte = 999999;
type
    palabra = string[20];
  detalle = record
    codigo_Autor:        integer;
    nombre_Autor:        palabra;
    nombre_Disco:        palabra;
    genero_Disco:        palabra;
    cantidad_Vendida:    integer;
  end;
var
   TextoEntrada:  text;
   TextoSalida:   text;
   registro_Aux:  detalle;
   totalVendidos: integer;
   totalAutor:    integer;
   totalGenero:   integer;
   AutorActual: integer;
   GeneroActual: palabra;

procedure leer (var TextoEntrada: text; var registro_Aux : detalle);
begin
  if(not eof(TextoEntrada)) then begin
    readln(TextoEntrada,registro_Aux.codigo_Autor);
    readln(TextoEntrada,registro_Aux.nombre_Autor);
    readln(TextoEntrada,registro_Aux.nombre_Disco);
    readln(TextoEntrada,registro_Aux.genero_Disco);
    readln(TextoEntrada,registro_Aux.cantidad_Vendida);
  end
  else
    registro_Aux.codigo_Autor:=valorDeCorte;
end;


begin
  Assign(TextoEntrada,'prueba.txt');
  Assign(TextoSalida, 'salida.txt');
  reset(TextoEntrada);
  rewrite(TextoSalida);

  totalVendidos:=0;
  leer(textoEntrada, registro_Aux);
  while(registro_Aux.codigo_Autor <> valorDeCorte)do begin //Control final de archivo
    AutorActual := registro_Aux.codigo_Autor;
    write('El Autor actual es:');writeln(AutorActual);
    write(TextoSalida,'El Autor actual es:');writeln(TextoSalida,AutorActual);
    totalAutor:= 0;
    while((registro_Aux.codigo_Autor = AutorActual) and (registro_Aux.codigo_Autor <> valorDeCorte))do begin //Control de Autor
      GeneroActual := registro_Aux.genero_Disco;
      write('El Genero actual es:');writeln(GeneroActual);
      write(TextoSalida,'El Genero actual es:');writeln(TextoSalida,GeneroActual);
      totalGenero := 0;
      writeln(GeneroActual);
      while((registro_Aux.genero_Disco = GeneroActual) and (registro_Aux.codigo_Autor <> valorDeCorte))do begin //Control de Genero
        write('Nombre del disco: ');write(registro_Aux.nombre_Disco);write(' cantidad vendidad: ');writeln(registro_Aux.cantidad_Vendida);
        write(TextoSalida,'Nombre del disco: ');write(TextoSalida,registro_Aux.nombre_Disco);write(TextoSalida,' cantidad vendidad: ');
        writeln(TextoSalida,registro_Aux.cantidad_Vendida);
        totalGenero  := totalGenero + registro_Aux.cantidad_Vendida;
        totalAutor   := totalAutor + registro_Aux.cantidad_Vendida;
        totalVendidos:= totalVendidos + registro_Aux.cantidad_Vendida;
        leer(textoEntrada,registro_Aux);
      end;
      write('Total Genero: ');writeln(totalGenero);
      write(TextoSalida,'Total Genero: ');writeln(TextoSalida,totalGenero);
    end;
    write(TextoSalida,'Total Autor: ');writeln(TextoSalida,totalAutor);
    write('Total Autor: ');writeln(totalAutor);
  end;
  write(TextoSalida,'Total Discografia: ');writeln(TextoSalida,totalVendidos);
  write('Total Discografia: '); writeln(totalVendidos);

  close(TextoSalida);
  close(TextoEntrada);
  readln();
end.


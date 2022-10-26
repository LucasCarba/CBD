program ejercicio8;
const
  ValorAlto = 99999;
type
  palabra = string[50];
  Registro = record
    cod_zona        : integer;
    nombre          : palabra;
    descripcion     : palabra;
    fecha           : palabra;
    contador_metros : real;
    ubicacion       : palabra;
  end;
  archivoDetalles  = file of Registro;
  Registro_Binario = record
    cod_zona        : integer;
    nombre          : palabra;
    contador_metros : real;
  end;
  vector_Archivos_Detalle = array[0..14] of archivoDetalles;
  vector_Detalles = array[0..14] of Registro;
 var
   archivos_Detalle : vector_Archivos_Detalle;
   Maestro : binario;
   Texto : text;
   i : integer;
   detalle : vector_Detalles;
   aBinario : Registro_Binario;
   regAuxiliar: Registro;
   minimo :registro;

   //En este proceso inicializo todos los 14 detalles para la primera comprobacion de minimos
procedure LeerRegistros (var archivos_Detalle : vector_Archivos_Detalle; regAuxiliar:Registro; var vectorDetalles:vector_Detalles);
var
  i:integer;
begin
  for i:= 0 to 14 do begin
    leer(archivos_Detalle, i, vectorDetalles);
  end;
end;
//
procedure Leer (i:integer ;var archivos_Detalle : archivos_Detalle;var VectorDetalles : vector_Detalles);
begin
  if( eof(detalle[i]))
  then
      vector_Detalles[i].cod_zona:= ValorAlto;
  else
      read(detalle[i], vector_Detalles[i]);
end;


procedure Minimos(var regAuxiliar:Registro; var archivos_Detalle:vector_Archivos_Detalle; var vector_Detalles:vector_Detalles );
begin
  for i:=0 to 14 do begin
    if(vector_Detalles[i].cod_zona <= regAuxiliar.cod_zona) then
        begin
        regAuxiliar := vector_Detalles.cod_zona;
        leer(i,archivos_Detalle,Vector_Detalles );
        end;
  end;
end;
begin
  //Asigno todo
  Assign(Maestro, 'maestro.bin');
  Assign(Texto, 'texto.txt');
  for i:= 0 to 14 do begin
    Assign(detalle[i],'detalle'+ i +'.bin');
    Reset(detalle[i]);
  end;
  rewrite(Maestro);
  rewrite(Texto);

  //Inicializo el arreglo de registros
  LeerRegistros(archivos_Detalle,RegAuxiliar,vectorDetalles);

  //Busco el primer minimo
  Minimos(RegAuxiliar,detalle,minimo);

  //Recorro hasta condicion de corte
  while(minimo.cod_zona <> ValorAlto) do
  begin
    codigoActual := minimo.cod_zona;
    regAuxiliar.nombre:= minimo.nombre ;
    regAuxiliar.cod_zona:= minimo.cod_zona;
    regAuxiliar.ubicacion:= minimo.ubicacion;

    Subtotal := 0;
    while(codigoActual = minimo.codigo_producto) do begin
      Subtotal := Subtotal + minimo.contador_metros;
      Minimo(RegAuxiliar,detalle,minimo);
    end;

    //Imprimo binario
    aBinario.cod_zona:=regAuxiliar.cod_zona ;
    aBinario.contador_metros:= subtotal;
    aBinario.nombre:= regAuxiliar.nombre;
    write(Maestro);

    //Imprimo txt
    write(Texto,regAuxiliar.cod_zona);
    write(Texto,regAuxiliar.nombre);
    write(Texto,regAuxiliar.ubicacion);
    write(Texto,regAuxiliar.subtotal);

  end;









  //Cierro todo
  close(Maestro);
  close(Texto);
  for i:= 0 to 14 do begin
    Close(detalle[i]);
  end;
end.


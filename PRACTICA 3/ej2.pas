program asd2;
uses sysutils;
type
  cadena=String[25];
  tVehiculo= Record
      codigoVehiculo:integer;
      patente: cadena;
      motor:cadena;
      cantidadPuertas: integer;
      precio:real;
      descripcion:cadena;
    end;
tArchivo = File of tVehiculo;

{Abre el archivo y agrega un vehículo para alquiler, el mismo se recibe como parámetro y
debe utilizar la política descripta anteriormente para recuperación de espacio}
Procedure agregar (var arch: tArchivo;var vehiculo:tVehiculo);
var
  aux,cab:tVehiculo;
  RNN:integer;
  pos:integer;
begin
  reset(arch);
  read(arch,cab);
  RNN:=StrToInt(cab.descripcion);
  if(RNN=0) then
  begin
    seek(arch,filesize(arch));
    write(arch,vehiculo);
  end else begin
        seek(arch,RNN);
        read(arch,aux);
        pos:=StrToInt(aux.descripcion);
        //agregarlo ahi
        seek(arch,filepos(arch)-1);
        write(arch,vehiculo);
        seek(arch,0);
        cab.descripcion:=IntToStr(pos);
        seek(arch,0);
        write(arch,aux);
  end;
  close(arch);
End;
{Abre el archivo y elimina el vehículo recibido como parámetro manteniendo la política
descripta anteriormente}
Procedure eliminar (var arch: tArchivo; vehiculo: tVehiculo);
var
  aux,cab:tVehiculo;
  nrr,pos,a:integer;
Begin
  reset(arch);
  read(arch,aux);
  cab:=aux;
  nrr:=0;
  //busco el veh
  while(not(eof(arch))and(aux.codigoVehiculo<>vehiculo.codigoVehiculo))do
  begin
    read(arch,aux);
    nrr:=nrr+1;
  end;
  if(not(eof(arch)))then
  begin
    writeln(nrr);
    vehiculo.descripcion:=cab.descripcion;
    writeln(vehiculo.descripcion);
    seek(arch,filepos(arch)-1);
    write(arch,vehiculo);
    //a la cabezera le pongo el nrr
    seek(arch,0);
    cab.descripcion:=IntToStr(nrr);
    write(arch,cab);

  end;
  close(arch);


End;
procedure llenar(var arch:tArchivo);
var
aux:tVehiculo;
i:integer;
begin
  reset(arch);
  //cabecera
  aux.codigoVehiculo:=-1;
  aux.descripcion:='0';
  aux.patente:='cabecera';
  write(arch,aux);
  for i:=1 to 10 do
    begin
      aux.codigoVehiculo:=i;
      aux.descripcion:='desc'+IntToStr(i);
      aux.patente:=aux.descripcion;
      write(arch,aux);
    end;
  close(arch);
end;
procedure print(var arch:tArchivo);
var
  aux:tVehiculo;
begin
  reset(arch);
  writeln('codigo patente descripcion');
  while(not(eof(arch)))do
  begin
    read(arch,aux);
    write(aux.codigoVehiculo);
    write(' '+aux.patente+' ');
    writeln(aux.descripcion);
  end;
end;

var
  arch:tArchivo;
  reg:tVehiculo;
begin
  Assign(arch,'arch.dat');
  rewrite(arch);
  llenar(arch);
  print(arch);
  //lleno algo para eliminar
  writeln('ingrese codigo a eliminar');
  read(reg.codigoVehiculo);

  eliminar(arch,reg);
  writeln('eliminar');
  reset(arch);
  read(arch,reg);
  writeln(reg.descripcion);

  //agregar uno
  reg.codigoVehiculo:=11;
  reg.descripcion:='desc11';

  agregar(arch,reg);
  reset(arch);
  read(arch,reg);
  writeln(reg.descripcion);

  //print(arch);
  readln();

end.

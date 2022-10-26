program asd;
uses sysutils;
type
  producto = record
    codigo:integer;
    nombre:string[25];
    descripcion:string[25];
    stock:integer;
  end;
  tArchivo=file of producto;

procedure generar(var txt:Text;var arch:tArchivo);
var
  aux:producto;
  s:string[25];
begin
  while(not(eof(txt)))do
  begin
    readln(txt,aux.codigo,aux.nombre,aux.descripcion,aux.stock);
    writeln(aux.codigo,aux.nombre,aux.descripcion,aux.stock);
    write(arch,aux);
  end;
  writeln('sale de generar');
  close(arch);
end;
procedure alta(var arch:tArchivo;var prod:producto);
var
  aux:producto;
begin
   reset(arch);
   read(arch,aux);
   while(not(eof(arch))and (aux.stock <> -1))do
   begin
     read(arch,aux);
   end;
   if(not(eof(arch))) then seek(arch,filepos(arch)-1);

   write(arch,prod);
   close(arch);
end;
procedure baja(var arch:tArchivo;var prod:producto);
var
  aux,cab:producto;
  NRR:integer;
begin
   reset(arch);
   read(arch,aux);
   cab:=aux;
   NRR:=1;
   while(not(eof(arch))and(aux.codigo<>prod.codigo))do
   begin
     read(arch,aux);
     NRR:=NRR+1;
   end;
   if(not(eof(arch)))then
   begin
     aux.descripcion:=cab.descripcion;
     seek(arch,filepos(arch)-1);
     write(arch,aux);
     seek(arch,0);
     cab.descripcion:=IntToStr(NRR);
     write(arch,cab);
   end;
end;

procedure marcar(var arch:tArchivo);
var
  aux:producto;
  cod:integer;
begin
  reset(arch);
  writeln('ingrese un codigo a marcar');
  read(cod);
  while(cod<>0)do
  begin
    reset(arch);
    read(arch,aux);
    while(not(eof(arch)) and (aux.codigo<>cod))do
    begin
      read(arch,aux);
    end;
    if(not(eof(arch)))then
    begin
      aux.stock:=-1;
      seek(arch,filepos(arch)-1);
      write(arch,aux);
    end;
    read(cod);
  end;
  close(arch);
end;
var
  arch:tArchivo;
  reg:producto;
  cod:integer;
  txt:Text;
begin
  Assign(arch,'datos.dat');
  Assign(txt,'datos.txt');
  rewrite(arch);
  reset(txt);

  generar(txt,arch);

  //marcar(arch);
  //alta(arch,reg);

  //baja(arch,cod);

  readln();
end.

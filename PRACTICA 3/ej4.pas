program ej3;
type
  cadena=string[25];
  cd = record
    codigo:integer;
    album:cadena;
    genero:cadena;
    artista:cadena;
    anio:integer;
    stock:integer;
  end;
  tArchivo=file of cd;

procedure compactacion(var arch:tArchivo);
var
  aux:cd;
  posBorrar:integer;
begin
   reset(arch);
   read(arch,aux);
   while(not(eof(arch))and (aux.stock<>0))do
   begin
     read(arch,aux);
   end;
   if(aux.stock=0)then
   begin
     posBorrar:=filepos(arch)-1;
     seek(arch,filesize(arch)-1);
     read(arch,aux);
     seek(arch,posBorrar);
     write(arch,aux);
     seek(arch,filesize(arch)-1);
     truncate(arch);
   end;
   close(arch);
end;

procedure marcar(var arch:tArchivo;cod:integer);
var
  aux:cd;
begin
   reset(arch);
   read(arch,aux);
   while(not(eof(arch)) and (aux.codigo<>cod))do
   begin
     read(arch,aux);
   end;
   if(aux.codigo=cod)then
   begin
     aux.stock:=0;
     seek(arch,filepos(arch)-1);
     write(arch,aux);
   end;
   close(arch);
end;

procedure baja(var arch:tArchivo);
var
  cod:integer;
begin
   readln(cod);
   while(cod<>9999)do
   begin
     marcar(arch,cod);
     read(cod);
   end;
end;

var
  arch:tArchivo;
  reg:cd;

begin
  Assign(arch,'cd.dat');
  rewrite(arch);

  baja(arch);

end.

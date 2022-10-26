program practica3_1;
Type
  especie = record
    codigo : integer;
    nomV : String[10];
    nomC: String[10];
    descrip: String[20];
    zona: String[10];
    end;
  FileEspecie = file of especie;

procedure marcar (var arch: FileEspecie);
var
  cod: integer;
  aux: especie;
begin
  reset(arch);
  writeln('ingrese codigo');
  readln(cod);
  while(cod<>100000)do
  begin
    aux.codigo:=100000;
    while((not(Eof(arch))) and (aux.codigo<>cod)) do
    begin
      read(arch,aux);
    end;
    aux.codigo:=-1;     //marca
    seek(arch,FilePos(arch)-1);
    writeln('esta en la posicion: ',FilePos(arch)-1);
    write(arch,aux);
    seek(arch,0);
    writeln('vuelve a: ',filepos(arch));
    writeln('ingrese codigo');
    readln(cod);
  end;

end;
procedure borrar ( var arch:FileEspecie);
var
  aux: especie;
  pos: integer;
begin
  reset(arch);
  while(not(eof(arch)))do
  begin
    read(arch,aux);
    if (aux.codigo = -1)then
    begin
      if(not(filepos(arch)=filesize(arch)))then
      begin
        pos:= filepos(arch)-1;
        seek(arch,filesize(arch)-1);
        read(arch,aux);
        seek(arch,filesize(arch)-1);
        truncate(arch);
        seek(arch,pos);
        write(arch,aux);
        seek(arch,filepos(arch)-1);
      end
      else
          begin
            seek(arch,filesize(arch)-1);
            truncate(arch);
          end;
    end;
  end;
end;

var
  arch: FileEspecie;
  aux: especie;
begin
  Assign(arch,'plantas.dat');
  Rewrite(arch); //para probar el programa
  aux.codigo:=1;
  Write(arch,aux);
  aux.codigo:=2;
  Write(arch,aux);
  aux.codigo:=3;
  Write(arch,aux);
  aux.codigo:=4;
  Write(arch,aux);
  aux.codigo:=5;
  Write(arch,aux);
  marcar(arch);

  reset(arch);
  while(not(eof(arch)))do begin
    read(arch,aux);
    writeln(aux.codigo);
  end;

  borrar(arch);

  reset(arch);
  while(not(eof(arch)))do begin
    read(arch,aux);
    writeln(aux.codigo);
  end;
  close(arch);
  readln(aux.codigo);
end.

program CBD_0_5;

type
  str20 = string[20];
  srr40 = string[40];
  flor = record
    id : integer;
    hMax : integer;
    name : str20;
    cName : srr40;
    color : srr40;
  end;
  archivo_flores = file of flor;

procedure leerFlor(var buffer:flor);
begin
  writeln('------------ CARGA NUEVA FLOR --------------- ');
  writeln('ingrese el nombre cientifico: ');
  readln(buffer.cName);
  if(buffer.cName<>'zzz')then begin
     writeln('ingrese el nombre vulgar: ');
     readln(buffer.name);
     writeln('ingrese el color: ');
     readln(buffer.color);
     writeln('ingrese la altura máxima: ');
     readln(buffer.hMax);
     writeln('ingrese el id: ');
     readln(buffer.id);
  end;
end;

procedure printMenu();
begin
  writeln('ingrese la opcion deseada: ');
  writeln('a) Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar. ');
  writeln('b) Listar todo el contenido del archivo de a una especie por linea.');
  writeln('c) Modificar un registro buscando por nombre científico.');
  writeln('d) Agregar una o más especies al final del archivo por teclado. La carga finaliza al recibir especie zzz.');
  writeln('e) Listar todo el contenido del archivo, en un archivo de texto llamado <flores.txt>.');
  writeln('f) Salir.');
end;

procedure archCheck(var arch: archivo_flores);
begin
  assign(arch, 'flores.dat');
  {$I-}
  reset(arch);
  {$I+}
  if IORESULT <> 0 then  // #2 file not found
  begin
    rewrite(arch);
  end;
  close(arch);
end;

procedure append(var arch: archivo_flores);
begin
  reset(arch);
  seek(arch,fileSize(arch));
end;

procedure resetAndShowList(var arch:archivo_flores);
var
  buffer:flor;
begin
  reset(arch);
  writeln();
  writeln('----------------------------------------------------');
  while(not eof(arch))do begin
            read(arch,buffer);
            with buffer do writeln('  ID:',id,' // ',name,', ',cName,', H-Max: ',hmax,'cm. Color: ',color,'.');
  end;
  writeln('----------------------------------------------------');
  writeln();
end;

procedure matchSeekAndRefill(var arch: archivo_flores; var buffer: flor);
var
  buffer2:flor;
begin
  reset(arch);
  buffer2.cName := '';
  while(not eof(arch) and not (buffer.cName = buffer2.cName)) do
  begin
  read(arch,buffer2);
  end;
  if (buffer.cName = buffer2.cName) then
  begin
   seek(arch,filePos(arch)-1);
   writeln('Actualmente: ',buffer2.cName,',ingrese nuevo el nombre cientifico. (x para mantener). ');
   readln(buffer.cName);
   if(buffer.cName = 'x') then
   begin
                   buffer.cName := buffer2.cName;
   end;
   writeln('Actualmente: ',buffer2.name,',ingrese nuevo el nombre vulgar. (x para mantener). ');
   readln(buffer.name);
   if(buffer.name = 'x') then
   begin
                   buffer.name := buffer2.name;
   end;
   writeln('Actualmente: ',buffer2.color,',ingrese nuevo el color. (x para mantener). ');
   readln(buffer.color);
   if(buffer.color = 'x') then
   begin
                   buffer.color := buffer2.color;
   end;
   writeln('Actualmente: ',buffer2.hMax,',ingrese nueva hMax. (0 para mantener). ');
   readln(buffer.hMax);
   if(buffer.hMax = 0) then
   begin
                   buffer.hMax := buffer2.hMax;
   end;
   buffer.id := buffer2.id;
   write(arch,buffer);
   resetAndShowList(arch);
  end
  else
  begin
   writeln('El nombre cienctifico ingresado no coincide con nuestros registros');
  end;
end;
var
  arch : archivo_flores;
  archo : text;
  buffer: flor;
  op : char;
  i,hmin,hmax : integer;
begin
     printMenu();
     archCheck(arch);
     readln(op);
   while(op <>'f') do begin
   assign(arch,'flores.dat');
   case op of
     'a': begin
            reset(arch);
            i:=0; hmax:=0; hmin:=999;
            while(not eof(arch))do begin
                      read(arch,buffer);
                      if(buffer.hMax > hmax) then
                                     hmax := buffer.hMax;
                      if(buffer.hMax < hmin) then
                                     hmin := buffer.hMax;
                      i:=i+1;
            end;
            writeln();
            writeln('----------------------------------------------------');
            writeln('      ',i,' Especies // MIN: ',hmin,'cm. // MAX: ',hmax,'cm. ');
            writeln('----------------------------------------------------');
            writeln();
          end;
     'b': begin
            resetAndShowList(arch);
          end;
     'c': begin
            writeln('ingrese el nombre cientifico de la flor a modificar: ');
            readln(buffer.cName);
            matchSeekAndRefill(arch,buffer);
          end;
     'd': begin
            append(arch);
            leerFlor(buffer);
            while(buffer.cName<>'zzz')do
            begin
                 write(arch,buffer);
                 leerFlor(buffer);
            end;
          end;
     'e': begin
            assign(archo,'flores.txt');
            rewrite(archo);
            reset(arch);
            writeln();
            writeln('----------------------------------------------------');
            while(not eof(arch))do begin
                      read(arch,buffer);
                      with buffer do writeln(archo,'  ID:',id,' // ',name,', ',cName,', H-Max: ',
                      hmax,'cm. Color: ',color,'.');
            end;
            close(archo);
            writeln('             Copiado en archivo                   ');
            writeln('----------------------------------------------------');
            writeln();
          end;
   end;
   close(arch);
   printMenu();
   readln(op);
   end;
   writeln('Adios!');
   readln();
end.


program CBD_0_6;
type
  _ISBN = string[13];
  _libro = record
    ISBN : _ISBN;
    title : string[40];
    edit : string[40];
    year : integer;
    end;
  file_libro = file of _libro;
procedure textToBin();
var
  tf: Text;
  bf: file_libro;
  libro: _libro;
begin
  //a texto --> bin
  assign(tF,'libros.txt');
  reset(tF);
  assign(bF,'libros.dat');
  rewrite(bf);
  with libro do repeat
       readln(tF,ISBN);
       readln(tF,title);
       readln(tF,edit);
       readln(tF,year);
       write(bF,libro);
  until(eof(tF));
  close(tF);close(bF);
end;

procedure menu(var op:char);
begin
  writeln('agregar   --> a ');
  writeln('modificar --> m ');
  writeln('salir     --> x ');
  readln(op);
end;
procedure append(var bF:  file_libro);
begin
  reset(bF);
  seek(bF,fileSize(bF));
end;
procedure resetAndShow(var bF: file_libro);
var
  libro: _libro;
begin
  reset(bF);
  writeln(' ------------------ L I B R O S --------------------- ');
  read(bF,libro);
  with libro do begin
    repeat
         writeln(ISBN,'| ',title,' - ',edit,' ',year,'.');
         read(bF,libro);
    until(eof(bF));
    writeln(ISBN,'| ',title,' - ',edit,' ',year,'.');
  end;
  writeln(' ---------------------------------------------------- ');
  close(bF);
end;
procedure matchAndModify(var bf:  file_libro; var libro: _libro);
var
  libro2: _libro;
begin
  reset(bF);
  libro2.ISBN := '';
  while(not eof(bF) and not (libro2.ISBN = libro.ISBN)) do
  begin
    read(bF,libro2);
  end;
  if(libro2.ISBN = libro.ISBN) then //match
  begin
       seek(bF,filePos(bF)-1);
       writeln();
       with libro2 do writeln(title,' - ',edit,' ',year,'.');
       writeln('re-ingrese titulo, editorial, anio de edicion');
       with libro do begin
         readln(title);
         readln(edit);
         readln(year);
       end;
       libro.ISBN := libro2.ISBN;
       write(bF,libro);
       resetAndShow(bF); // internamente lo cierra.
  end
  else
  begin
       writeln('ese ISBN no se encuentra en nuestros registros');
       writeln();
  end;
end;
var
  libro:_libro;
  tF : Text;
  bF : file of _libro;
  op : char;
begin
  textToBin(); //comentar esta l??nea para evitar que se sobreescriba el .dat cada ejecuci??n..
  //writeln('Archivo copiado!');
  //b bin: apertura, append, y modif
  assign(bF,'libros.dat');
  resetAndShow(bF);
  menu(op);
  while(op <> 'x') do begin
    if((op = 'a') or (op = 'A')) then  // append
    begin
         writeln('Ingrese ISBN,Titulo,Editorial,Anio de publicacion');
         with libro do begin
         readln(ISBN);
         readln(title);
         readln(edit);
         readln(year);
         end;
         append(bF);
         write(bF,libro);
         resetAndShow(bF);        // internamente ac?? el archivo hace close...
    end
    else if((op = 'm') or (op = 'M'))then
    begin
         writeln('ingrese el ISBN del libro a modificar');
         readln(libro.ISBN);
         matchAndModify(bF,libro);
    end
    else
    begin
        writeln();
        writeln('op incorrecta...');
    end;
    menu(op);
  end;

end.


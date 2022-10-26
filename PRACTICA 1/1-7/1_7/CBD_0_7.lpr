
\* 7. Realizar un programa con opciones para:
a. Crear un archivo de registros no ordenados con la información
correspondiente a los alumnos de la facultad de ingeniería y cargarlo con
datos obtenidos a partir de un archivo de texto denominado “alumnos.txt”.
Los registros deben contener DNI, legajo,nombre y apellido,dirección, año
que cursa y fecha de nacimiento (longInt).
b. Listar en pantalla toda la información de los alumnos cuyos nombres
comiencen con un carácter proporcionado por el usuario.
c. Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los
registros del archivo de alumnos que cursen 5 año.
d. Añadir uno o más alumnos al final del archivo con sus datos obtenidos por
teclado.
e. Modificar la fecha de un alumno dado. Las búsquedas son por legajo del
alumno.
*/
program CBD_0_7;

uses unit1;

type
  _dni = integer;
  _legajo = string[7]; //1846/1
  _alumno = record
    dni : _dni;
    legajo : _legajo;
    name : string[40];
    adr : string[40];
    year : integer;
    beginYear: longInt;
    end;
  file_alumno = file of _alumno;
procedure textToBin();
var
  tf: Text;
  bf: file_alumno;
  alumno: _alumno;
begin
  //a texto --> bin
  assign(tF,'alumnos.txt');
  reset(tF);
  assign(bF,'alumnos.dat');
  rewrite(bf);
  with alumno do repeat
       readln(tF,dni);
       readln(tF,legajo);
       readln(tF,name);
       readln(tF,adr);
       readln(tF,year);
       readln(tF,beginYear);
       write(bF,alumno);
  until(eof(tF));
  close(tF);close(bF);
end;

procedure showBin(var bf: file_alumno);
var
  alumno: _alumno;
begin
  reset(bf);
  writeln('------------- A L U M N O S -----------------');
  repeat
       read(bf,alumno);
       with alumno do writeln(legajo,' // ',name,' // ',year,' // ',beginYear,'.');
  until (eof(bf));
  close(bf);
  writeln('---------------------------------------------');
end;

procedure menu(var op:char);
begin
  writeln('agregar   --> a ');
  writeln('modificar --> m ');
  writeln('x nombre  --> n ');
  writeln('cursada   --> c ');
  writeln('listar    --> l ');
  writeln('salir     --> x ');
  readln(op);
end;

procedure append(var bF:  file_alumno);
begin
  reset(bF);
  seek(bF,fileSize(bF));
end;

procedure resetAndShowWithKey(var bF: file_alumno);
var
  alumno: _alumno;
  key: string;
begin
  reset(bF);
  writeln('Ingrese el final del apellido: ');
  readln(key);
  writeln(' ---------- alumnos temrinados en <',key,'> --------------------- ');
  repeat
       read(bF,alumno);
       with alumno do begin
         if(copy(name, length(name)-length(key)+1, length(key)) = key) then begin
             writeln(legajo,'| ',name,' - Cursando ',year,'.');
         end;
       end;
  until(eof(bf));
  writeln(' -------------------------------------------------------...------ ');
  close(bF);
end;

procedure resetAndTextWithYear(var bF: file_alumno);
var
  alumno: _alumno;
  yearIn: integer;
  tF: text;
begin
  reset(bF);
  writeln('Ingrese el ciclo de cursada: ');
  readln(yearIn);
  assign(tF,'alumnosAEgresar.txt');
  rewrite(tF);
  writeln(' ---------- alumnos cursando actualmente ',yearIn,'° --------------------- ');
  repeat
     read(bF,alumno);
     with alumno do begin
       if(year = yearIn) then begin
         writeln(tf,legajo,'| ',name,' - Cursando ',year,'° ',year,'.');
         writeln(legajo,'| ',name,' - Cursando ',year,'° ',year,'.');
       end;
     end;
  until (eof(bF));
  writeln(' ----------------------------------------------------------...------ ');
  close(bF);
  close(tF);
  end;

procedure matchAndModify(var bf:  file_alumno; var alumno: _alumno);
var
  alumno2: _alumno;
begin
  reset(bF);
  alumno2.legajo:= ' ';
  while(not eof(bF) and not (alumno2.legajo = alumno.legajo)) do
  begin
    read(bF,alumno2);
  end;
  if(alumno2.legajo = alumno.legajo) then //match
  begin
       seek(bF,filePos(bF)-1);
       writeln();
       with alumno2 do writeln(beginYear,' es la fecha actual, ingrese la correcta:');
       readln(alumno2.beginYear);
       write(bF,alumno2);
       writeln(' --- cambio realizado --- ');
       writeln();
  end
  else begin
       writeln('ese Legajo no se encuentra en nuestros registros');
       writeln();
  end;
  close(bF);
end;
var
  alumno:_alumno;
  tF : Text;
  bF : file of _alumno;
  op : char;
begin
  textToBin(); //comentar esta línea para evitar que se sobreescriba el .dat cada ejecución..
  //writeln('Archivo copiado!');
  //b bin: apertura, append, y modif
  assign(bF,'alumnos.dat');
  menu(op);
  while(op <> 'x') do begin   //salir
    if((op = 'a') or (op = 'A')) then  // append
    begin
         writeln('Ingrese dni,legajo,nombre y apellido,dirección, año de cursada, fecha de nacimiento');
         with alumno do begin
         readln(dni);
         readln(legajo);
         readln(name);
         readln(year);
         readln(beginYear);
         end;
         append(bF);
         write(bF,alumno);
         close(bf);
         writeln(' -- alumno ingresado -- ');
         writeln();
    end
    else if((op = 'm') or (op = 'M'))then
    begin
         writeln('ingrese el legajo del alumno a modificar');
         readln(alumno.
         matchAndModify(bF,alumno);
    end
    else if((op = 'n') or (op = 'N')) then  // por substring del nombre
    begin
         resetAndShowWithKey(bf);
    end
    else if((op = 'c') or (op = 'C')) then  // por año de cursada
    begin
         resetAndTextWithYear(bf);
    end
    else if((op = 'l') or (op = 'L')) then  // Listar
    begin
         showBin(bf);
    end
    else
    begin
        writeln();
        writeln('op incorrecta...');
    end;
    menu(op);
  end;

end.


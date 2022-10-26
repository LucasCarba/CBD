program CBD_0_4;
type
  arch_integer = file of integer;
var
  archI : arch_integer; // archivo de entrada;
  archO : text;         // archivo de salida;
  nomarchI, nomarchO : string;
  buffer: integer;
begin
     writeln('Ingrese el nombre del archivo de entrada: ');
     readln(nomarchI);
     writeln('Ingrese el nombre del archivo de salida: ');
     readln(nomarchO);
     assign(archI,nomarchI);
     assign(archO,nomarchO);
     reset(archI);
     rewrite(archO);
     while(not eof(archI)) do begin
        read(archI,buffer);
        writeln(archO,buffer);
     end;
     close(archI);
     close(archO);
     writeln('Conversión realizada');
end.


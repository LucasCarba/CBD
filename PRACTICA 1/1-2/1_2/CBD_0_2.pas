program CBD_0_2;

Type
  string20 = string[20];
  string40 = string[40];

  _dinosaurio = record
  nombre : string20;
  nombreC : string40;
  peso : integer;
  altura : integer;
  end;

Var
   arch: text;
   dinosaurio : _dinosaurio;
   i:integer;
begin
  i:=1;
  writeln('Ingrese el nombre del ',i,' dinosaurio: ');
  readln(dinosaurio.nombre);
  if(dinosaurio.nombre <> 'zzz')
  then begin
       assign(arch,'dinosaurios.txt');
       rewrite(arch);
  end;
  while(dinosaurio.nombre<>'zzz') do begin
        writeln('Ingrese peso:');
        readln(dinosaurio.peso);
        writeln('Ingrese altura:');
        readln(dinosaurio.altura);
        writeln('Ingrese nombre cientifico:');
        readln(dinosaurio.nombreC);
        with dinosaurio do writeln(arch,nombre,'/',nombreC,'/',peso,'/',altura);
        i := i+1;
        writeln('Ingrese el nombre del ',i,' dinosaurio: ');
        readln(dinosaurio.nombre);
  end;
  close(arch);
  writeln('Fin...');
  readln();
end.


program CBD_0_0;

Type _str20 = string[20];

//materiales = file of _str20;
  materiales = text;

Var

nomArch : _str20;
arch : materiales;
i : integer;

begin
  i:=0;
  writeln('Ingrese el nombre del archivo: ');
  readln(nomarch);
  Assign(arch, nomarch);
  reWrite(arch);
  repeat
    writeln('Ingrese el nombre del material: ');
    readln(nomarch);
    writeln(arch,nomarch);
  until(nomarch = 'cemento');
  close(arch);
end.


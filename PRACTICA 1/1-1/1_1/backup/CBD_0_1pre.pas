program CBD_0_1pre;

Type
  elecciones = file of integer;

Var

arch : elecciones;
 i : integer;

begin
  Assign(arch, 'numeros.dat');
  rewrite(arch);
  repeat
    readln(i);
    write(arch,i);
  until(i=126);
  close(arch);
end.


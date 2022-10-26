program CBD_0_1;

Type
  elecciones = file of integer;

Var
   nomarch:string;
   arch : elecciones;
   min,total,n,i : integer;

begin
  min:=99999;total:=0;n:=0;i:=0;
  writeln('Ingrese el nombre del archivo: ');   //numeros.dat
  readln(nomarch);
  Assign(arch, nomarch);
  reset(arch);
  repeat
    read(arch,n);
    total := total + n;
    if(n < min) then
         min := n;
    i:= i+1;
    writeln(n);
  until(eof(arch));
  close(arch);
  writeln('el promedio es: ',(total/i):2,', la cantidad minima: ',min,', y las ciudades: ',i,'.');
  readln();
end.


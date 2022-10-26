program project1;
uses sysutils;
type
 cadena= array[0..25] of Char;
 calzado = record
   codigo:integer;
   numero:integer;
   desc:cadena;
   precio:integer;
   color:cadena;
   stock:integer;
   stockMin:integer;
 end;
 detalle = record
   codigo:integer;
   numero:integer;
   cant:integer;
 end;

tdet = file of detalle;
tmae = file of calzado;
vecD = array[0..19] of tdet;
var
  mae:tmae;
  vec:vecD;
  mreg:calzado;
  dreg:detalle;
  stock:text;

procedure inicializar(var v:vecD);
var
  i:integer;
begin
     for i:=0 to 19 do
     begin
         Assign(v[i],'det'+IntToStr(i)+'.dat');
         Reset(v[i]);
     end;
end;

procedure actualizar(var v:vecD;var mae:tmae);
var
  i:integer;
begin
     for i:=0 to 19 do
     begin
         while not Eof(v[i]) do
         begin
           read(mae,mreg);
           read(v[i],dreg);
           while mreg.codigo <> dreg.codigo do
             begin
                read(mae,mreg);
             end;
           if mreg.stock > 0 then
           begin
             if mreg.stock > mreg.stockMin then
             begin
             mreg.stock:=mreg.stock - dreg.cant;
             seek(mae,filepos(mae)-1);
             write(mae,mreg);
             end else begin
               write(stock,mreg.codigo,mreg.color,mreg.numero);
             end;

           end else begin //no tuvo ventas
                 write(mreg.codigo,mreg.numero);


           end;
         end;
         close(v[i]);
         reset(mae); //no se si hay que resetear porque no entiendo bien lo de orden,
         //yo reseteo para que el proximo detalle el maestro arranque desde el principio.
     end;
     close(mae);
end;

begin
  Assign(stock,'calzadosinstock.txt');
  rewrite(stock);
  Assign(mae,'maestro.dat');
  reset(mae);
  inicializar(vec);
  actualizar(vec,mae);
  readln();
end.


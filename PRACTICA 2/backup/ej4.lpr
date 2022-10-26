program project1;
uses sysutils;
const
  valorAlto=10000;
type

 cadena= string[50];
 pelicula = record
      codigo:integer;
      nombre:cadena;
      genero:cadena;
      director:cadena;
      duracion:integer;
      fecha:cadena;
      cant:integer;
 end;
tdet = file of pelicula;
tvecD = array[0..19] of tdet;
tvecR = array[0..19] of pelicula;
var
  mae:tdet;
  vec:tvecD;
  vecR:tvecR;
  regm:pelicula;
  ruta:cadena;
  min:pelicula;


  procedure leer(var arch:tdet; var reg:pelicula);
  begin
       if not Eof(arch) then
          read(arch,reg)
       else
          reg.codigo:=valorAlto;
  end;

procedure inicializar(var v:tvecD; var vr:tvecR);
var
  i:integer;
begin
     for i:=0 to 19 do
     begin
         Assign(v[i],'det'+IntToStr(i)+'.dat');
         Reset(v[i]);
         leer(v[i],vr[i]);
     end;
end;

procedure det_indice(var vr:tvecR; var ind:integer);
var
  i:integer;
  min:integer;
begin
      min:=99999;
      for i:=0 to 19 do
      begin
          if vr[i].codigo < min then
             begin
               min:=vr[i].codigo;
               ind:=i;
             end;
      end;
end;

procedure minimo(var v:tvecD; var vr:tvecR; var min:pelicula);
var
   indice_min:integer;
begin
     det_indice(vr,indice_min);

     min:=vr[indice_min];
     leer(v[indice_min],vr[indice_min]);

end;

procedure merge( var v:tvecD; ruta:cadena;var vr:tvecR);
var
  i:integer;
  aux:integer;

begin
     assign(mae,ruta);
     rewrite(mae);
     minimo(v,vr,min);
     while min.codigo <> valorAlto do
     begin
         aux:=min.codigo;

         regm.codigo:=min.codigo;
         regm.director:=min.director;
         regm.duracion:=min.duracion;
         regm.fecha:=min.fecha;
         regm.genero:=min.genero;
         regm.nombre:=min.nombre;

         regm.cant:=min.cant;
         while aux = min.codigo do
         begin
             regm.cant:=regm.cant + min.cant;
             minimo(v,vr,min);
         end;
         write(mae,regm);
     end;
     close(mae);

end;

begin
  inicializar(vec,vecR);
  ruta:='maestro.dat';
  merge(vec,ruta,vecR);
end.


program project1;
uses sysutils;
type
  cadena = array[0..254] of Char;
  empleado = record
    codigo:integer;
    nombre:cadena;
    nacimiento:cadena;
    direccion:cadena;
    hijos:integer;
    telefono:integer;
    dias:integer;
  end;
  empDetalle = record
    codigo:integer;
    fecha:cadena;
    dias:integer;
  end;

  temp = file of empleado;
  tdet = file of empDetalle;

  tvec = array[0..9] of tdet;

//procedure actualizar(var det:tvec)
//var
//begin

//end;

var
vec:tvec;
emp:temp;
det:tdet;
empr:empleado;
detr:empDetalle;
informe:text;

procedure inicializarVec(var v:tvec);
var
i:integer;
palabra:cadena;
begin
  Assign(v[0],'detalle0.dat');
  Reset(v[0]);
  Assign(v[1],'detalle1.dat');
  Reset(v[1]);
  Assign(v[2],'detalle2.dat');
  Reset(v[2]);
  Assign(v[3],'detalle3.dat');
  Reset(v[3]);
  Assign(v[4],'detalle4.dat');
  Reset(v[4]);
  Assign(v[5],'detalle5.dat');
  Reset(v[5]);
  Assign(v[6],'detalle6.dat');
  Reset(v[6]);
  Assign(v[7],'detalle7.dat');
  Reset(v[7]);
  Assign(v[8],'detalle8.dat');
  Reset(v[8]);
  Assign(v[9],'detalle9.dat');
  Reset(v[9]);
end;

procedure actualizarM(var v:tvec; var m:temp);
var
i:integer;
begin
    for i:=0 to 9 do
    begin
      while not Eof(v[i]) do
        begin
          read(v[i],detr);
          read(emp,empr);
          while detr.codigo <> empr.codigo do
            read(emp,empr);
          if detr.dias < empr.dias then
          begin
            writeln(informe,empr.nombre,empr.codigo,empr.dias,detr.dias);
          end
          else begin
            empr.dias:=empr.dias + detr.dias;
            seek(emp,FilePos(emp)-1);
            write(emp,empr);
          end;
        end;
    end;
end;

begin
inicializarVec(vec);
Assign(informe,'informe.txt');
rewrite(informe);
Assign(emp,'maestro.dat');
reset(emp);
actualizarM(vec,emp);


readln();
close(emp);

end.


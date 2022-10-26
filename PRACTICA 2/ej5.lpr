program project1;
uses sysutils;
const
  valorAlto='zzzz';
type

 cadena= string[50];
 detalle = record
      partido:cadena;
      localidad:cadena;
      barrio:cadena;
      cninos:integer;
      cmayores:integer;
 end;
tdet = file of detalle;
var
  det:tdet;
  reg:detalle;
  nloc,mloc,npart,mpart:integer;
  ant_loc,ant_part:cadena;


  procedure leer(var arch:tdet; var reg:detalle);
  begin
       if not Eof(arch) then
          read(arch,reg)
       else
          reg.localidad:=valorAlto;
  end;

begin
  assign(det,'detalle.dat');
  reset(det);
  leer(det,reg);
  writeln('Partido ' + reg.partido + ':');

  nloc:=0;
  mloc:=0;
  npart:=0;
  mpart:=0;

  while reg.localidad <> valorAlto do
  begin
       ant_loc:=reg.localidad;
       ant_part:=reg.partido;
       while (ant_part=reg.partido) and (ant_loc=reg.localidad) do
       begin
            write(reg.barrio,reg.cninos,reg.cmayores);

            nloc:=nloc+reg.cninos;
            npart:=npart+reg.cninos;

            mloc:=mloc+reg.cmayores;
            mpart:=mpart+reg.cmayores;

            leer(det,reg);
       end;
       write('Total niños localidad' + ant_loc +': ',nloc);
       write('Total mayores localidad' + ant_loc + ': ',mloc);
       //reseteo
       nloc:=0;
       mloc:=0;
       ant_loc:=reg.localidad;

       if (ant_part <> reg.partido) then
          begin
            write('total niños ' + ant_part +': ',npart);
            write('total adultos ' + ant_part +': ',mpart);
            npart:=0;
            mpart:=0;
          end;
       writeln('Partido :',reg.partido);
  end;

end.


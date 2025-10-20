% trabajador(Legajo, Nombre, Domicilio, Codigo, Contratado, Efectivo).
% trabajador/6
trabajador(111, 'Juan', 'Perez', domicilio('Jujuy', 142, 1), 3, contratado(24, 1500.5, 5)).
trabajador(222, 'Vera', 'Petro', domicilio('Salta', 339, 2), 3, contratado(20, 1500.5, 7)).
trabajador(333, 'Pedro', 'Garcia', domicilio('Peru', 721, 3), 2, efectivo(82000, 1, 20.0)).
trabajador(444, 'Victoria', 'Dove', domicilio('Jujuy', 344, 4), 2, efectivo(80000, 12, 10.5)).
trabajador(555, 'Jose', 'Casas', domicilio('Salta', 545, 1), 3, contratado(24, 1500.5, 8)).
trabajador(666, 'Diana', 'Gioia', domicilio('Chile', 123, 3), 3, contratado(20, 1500.5, 7)).
trabajador(777, 'Gaston', 'Bambini', domicilio('Salta', 339, 2), 3, efectivo(85000, 8, 20.5)).
trabajador(888, 'Maria', 'Bravi', domicilio('Lujan', 104, 1), 2, efectivo(78000, 9, 20.0)).

% localidad(Codigo, Nombre).
% localidad/2
localidad(1, 'Cordoba').
localidad(2, 'Capilla del Monte').
localidad(3, 'Calamuchita').
localidad(4, 'Laborde').

% area(Codigo, Nombre).
% area/2
area(1, 'Gerencia').
area(2, 'Marketing').
area(3, 'Limpieza').

% trabajadores_de_cordoba/5
trabajadores_de_cordoba(Legajo, Apellido, Nombre, Calle, Altura) :-
  trabajador(Legajo, Nombre, Apellido, domicilio(Calle, Altura, Localidad), _, _),
  localidad(Localidad, 'Cordoba').

% Si existe o no algún empleado con domicilio en Calamuchita, o bien que trabaje en el área con código 1
existen_trabajadores_de_calamuchita_o_area_1 :-
  ((trabajador(_, _, _, domicilio(_, _, Localidad), _, _),
    localidad(Localidad, 'Calamuchita'))
  ; trabajador(_, _, _, _, 1, _)),
  !.

% Legajo, apellido y nombre, calle y altura de aquellos empleados cuyo domicilio NO esté situado en Córdoba.t
trabajadores_que_no_son_de_cordoba(Legajo, Apellido, Nombre, Calle, Altura) :-
  trabajador(Legajo, Nombre, Apellido, domicilio(Calle, Altura, Localidad), _, _),
  localidad(Localidad, NombreLocalidad),
  NombreLocalidad \= 'Cordoba'.

% Legajo, nombre, apellido, nombre de la localidad, nombre del área y cantidad de horas trabajadas por mes de aquellos empleados contratados que trabajen al mes más de 125hs.
trabajadores_contratados_mas_de_125hs(Legajo, Nombre, Apellido, NombreLocalidad, NombreArea, HorasMensuales) :-
  trabajador(Legajo, Nombre, Apellido, domicilio(_, _, Localidad), AreaCodigo, contratado(CantidadDias, _, Horas)),
  HorasMensuales is Horas * CantidadDias,
  HorasMensuales > 125,
  localidad(Localidad, NombreLocalidad),
  area(AreaCodigo, NombreArea).

% Legajo y salario (sin incluir los viáticos) de cada uno de los empleados, tanto contratados como efectivos.
trabajadores_y_su_salario(Legajo, Salario) :-
  (trabajador(Legajo, _, _, _, _, contratado(CantidadDias, PrecioPorHora, Horas)),
    Salario is (CantidadDias * PrecioPorHora * Horas))
  ; (trabajador(Legajo, _, _, _, _, efectivo(Basico, Antiguedad, Coeficiente)),
    Salario is (Basico + (Basico * Antiguedad * Coeficiente / 100))).

% Legajo, nombre, apellido, descripción del área y descripción de la localidad de aquellos empleados a los que les corresponde viáticos.
trabajadores_con_viaticos(Legajo, Nombre, Apellido, Localidad, Area) :-
  trabajadores_que_no_son_de_cordoba(Legajo, _, _, _, _),
  trabajador(Legajo, Nombre, Apellido, domicio(_, _, CodigoLocalidad), CodigoArea, _),
  localidad(CodigoLocalidad, Localidad),
  area(CodigoArea, Area).

salarios(Legajo, Salario) :-
  trabajadores_y_su_salario(Legajo, SB),
  (((trabajador(Legajo, _, _, _, _, contratado(_,_,_))
    ; trabajadores_que_no_son_de_cordoba(Legajo, _, _, _, _) ),
    Salario is SB)
  ; Salario is SB + 250).

salario_inferior_a(Valor, Legajo, Apellido, Nombre, Area, Localidad) :-
  salarios(Legajo, Salario),
  Salario < Valor,
  trabajador(Legajo, Nombre, Apellido, domicilio(_, _, CodigoLocalidad), CodigoArea, _),
  localidad(CodigoLocalidad, Localidad),
  area(CodigoArea, Area).

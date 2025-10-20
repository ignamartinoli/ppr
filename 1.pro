# Predicados de test de tipos y de instanciación (consultas)

% 1
?- integer(3).
% 2
?- float(2.0).
% 3
?- number(100).
% 4
?- number('ppr').
% 5
?- var(X).
% 6
?- var(x).
% 7
?- nonvar(X).
% 8
?- nonvar(siete).
% 9
?- nonvar(' ').
% 10
?- nonvar(100).

# `is/2` con aritmética (consultas)`

% 1
?- 5 is 3 + 2.
% 2
?- 7 is 10 - 3.
% 3
?- 150 is 3 * 50.
% 4
?- 25 is 100 / 4.     % ojo: / devuelve float; si querés entero, usar // o div
%    25 is 100 // 4.  % división entera
% 5
?- 16 is 2 ** 4.      % potencia
% 6
?- 10 is sqrt(100).
% 7
?- 33 is 100 // 3.    % ó: 33 is 100 div 3.
% 8
?- 1 is 100 mod 3.
% 9
?- R is 10 * pi.
% 10
?- A is abs(-3).

# Reglas propias con aritmética (`aritmetica.pl`)

:- module(aritmetica, [
  '++'/2, '--'/2, '+'/=3, pow/3, raiz/2, resto/3, esPar/1
]).

% 1) ++/2: incrementa en 1
'++'(X, Y) :- Y is X + 1.

% 2) --/2: decrementa en 1
'--'(X, Y) :- Y is X - 1.

% 3) +=/3: Z = X + Y
'+='(X, Y, Z) :- Z is X + Y.

% 4) pow/3: Z = B ** E
pow(B, E, Z) :- Z is B ** E.

% 5) raíz/2: Y = sqrt(X)
raiz(X, Y) :- Y is sqrt(X).

% 6) resto/3: R = N mod D
resto(N, D, R) :- R is N mod D.

% 7) esPar/1: cierto si X es par
esPar(X) :- 0 is X mod 2.

?- '++'(4, Y).
?- '--'(4, Y).
?- '+='(3, 7, Z).
?- pow(2, 4, Z).
?- raiz(100, R).
?- resto(100, 3, R).
?- esPar(10).

# Sucursales: hechos, reglas y goals (`sucursales.pl`)

:- module(sucursales, [
  sucursal/3,
  nombre_sucursal/1,
  nombre_mas_de/2,
  nombre_menos_de/2,
  nombre_exactos/2,
  nombre_no_exactos/2
]).

/*
 Hechos: sucursal(Cod, Nombre, CantEmpleados).
*/
sucursal(1, 'Buenos Aires', 300).
sucursal(2, 'Córdoba',       200).
sucursal(3, 'Rosario',       150).

/*
 Reglas pedidas
*/
nombre_sucursal(N)    :- sucursal(_, N, _).
nombre_mas_de(N, K)   :- sucursal(_, N, C), C >  K.
nombre_menos_de(N, K) :- sucursal(_, N, C), C <  K.
nombre_exactos(N, K)  :- sucursal(_, N, C), C =:= K.
nombre_no_exactos(N,K):- sucursal(_, N, C), C =\= K.

?- [sucursales].

% a) nombres de todas
?- nombre_sucursal(N).

% b) más de 180
?- nombre_mas_de(N, 180).

% c) menos de 250
?- nombre_menos_de(N, 250).

% d) exactamente 200
?- nombre_exactos(N, 200).

% e) no exactamente 200
?- nombre_no_exactos(N, 200).

% Preguntas extra de la guía:
% c) ¿En 'Córdoba' hay >180?
?- (nombre_mas_de('Córdoba', 180) -> writeln(si); writeln(no)).

% e) ¿En 'Buenos Aires' hay <250?
?- (nombre_menos_de('Buenos Aires', 250) -> writeln(si); writeln(no)).

% f) ¿En 'Rosario' hay sucursales (existe)?
?- (sucursal(_, 'Rosario', _) -> writeln(si); writeln(no)).

% j) ¿Cuántos empleados en 'Córdoba'?
?- sucursal(_, 'Córdoba', C).

% k) ¿Cuántos empleados por sucursal?
?- sucursal(Cod, N, C).

# Caso de estudio "pyme": hechos, reglas y goals (`empresa.pl`)

:- module(empresa, [
  % Hechos
  area/2, localidad/2, trabajador/6,

  % Reglas pedidas en clase (2a–2h)
  emp_en_cordoba/5,
  existe_calamu_o_area1/0,
  emp_fuera_cordoba/5,
  contratados_mas125/6,
  salario_sin_viaticos/2,
  con_viaticos/5,
  salario_final/2,
  salario_inferior_a/5,

  % Reglas de tarea (4a–4e)
  empleados_de_area/4,
  horas_contratados_por_area/3,
  efectivos_mas_de_8/6,
  efectivos_hasta_8/6,
  efectivos_con_salario_final/7
]).

/* =========================
   HECHOS
   ========================= */

area(1, 'Gerencia').
area(2, 'Marketing').
area(3, 'Limpieza').

localidad(1, 'Córdoba').
localidad(2, 'Capilla del Monte').
localidad(3, 'Calamuchita').
localidad(4, 'Laborde').

/*
trabajador(
  Leg, Nombre, Apellido,
  domicilio(Calle, Nro, CodLoc),
  CodArea,
  contratado(HsDia, PrecioHora, DiasMes)
  | efectivo(Basico, Antig, Coef)
).
*/
trabajador(111, 'María',   'Ricciardi', domicilio('Jujuy', 142, 1), 3, contratado(24, 1500.5, 5)).
trabajador(222, 'Vera',    'Petro',     domicilio('Salta', 339, 2), 3, contratado(20, 1500.5, 7)).
trabajador(333, 'Lara',    'Pointer',   domicilio('Perú',  721, 3), 2, efectivo(82000, 1, 20.0)).
trabajador(444, 'Victoria','Dove',      domicilio('Jujuy', 344, 4), 2, efectivo(80000,12, 10.5)).
trabajador(555, 'Ximena',  'Coraggio',  domicilio('Salta', 545, 1), 3, contratado(24, 1500.5, 8)).
trabajador(666, 'Gaspar',  'Gioia',     domicilio('Chile', 123, 3), 3, contratado(20, 1500.5, 7)).
trabajador(777, 'Diana',   'Bambini',   domicilio('Salta', 339, 2), 3, efectivo(85000, 8, 20.5)).
trabajador(888, 'Gastón',  'Bravi',     domicilio('Luján', 104, 1), 2, efectivo(78000, 9, 20.0)).

/* =========================
   REGLAS (clase)
   ========================= */

% 2a) Leg, Ap, Nom, Calle, Altura: empleados con domicilio en Córdoba
emp_en_cordoba(Leg, Ap, Nom, Calle, Alt) :-
  trabajador(Leg, Nom, Ap, domicilio(Calle, Alt, CodL), _ , _),
  localidad(CodL, 'Córdoba').

% 2b) ¿Existe alguien en Calamuchita o que trabaje en área 1?
existe_calamu_o_area1 :-
  ( trabajador(_,_,_,domicilio(_,_,CodL),_,_), localidad(CodL,'Calamuchita')
  ; trabajador(_,_,_,_,1,_) ).

% 2c) Empleados cuyo domicilio NO sea Córdoba
emp_fuera_cordoba(Leg, Ap, Nom, Calle, Alt) :-
  trabajador(Leg, Nom, Ap, domicilio(Calle, Alt, CodL), _ , _),
  localidad(CodL, Loc), Loc \= 'Córdoba'.

% 2d) Contratados con más de 125 hs/mes
% HorasMes = HsDia * DiasMes
contratados_mas125(Leg, Nom, Ap, LocNom, AreaNom, HorasMes) :-
  trabajador(Leg, Nom, Ap, domicilio(_, _, CodL), CodA, contratado(HsDia, _Precio, DiasMes)),
  HorasMes is HsDia * DiasMes,
  HorasMes > 125,
  localidad(CodL, LocNom),
  area(CodA, AreaNom).

% 2e) Legajo y salario (contratados y efectivos) sin viáticos
salario_sin_viaticos(Leg, Sal) :-
  trabajador(Leg, _, _, _, _, contratado(HsDia, Precio, DiasMes)),
  Sal is Precio * HsDia * DiasMes).
salario_sin_viaticos(Leg, Sal) :-
  trabajador(Leg, _, _, _, _, efectivo(Basico, Antig, Coef)),
  Sal is Basico + Basico * Antig * (Coef/100).

% 2f) Empleados con viáticos (solo contratados con domicilio != Córdoba)
con_viaticos(Leg, Nom, Ap, AreaNom, LocNom) :-
  trabajador(Leg, Nom, Ap, domicilio(_, _, CodL), CodA, contratado(_, _, _)),
  localidad(CodL, LocNom), LocNom \= 'Córdoba',
  area(CodA, AreaNom).

% 2g) Salario final (agrega $250 si corresponde viático)
salario_final(Leg, Total) :-
  salario_sin_viaticos(Leg, S0),
  ( con_viaticos(Leg,_,_,_,_) -> Total is S0 + 250
  ; Total = S0 ).

% 2h) Empleados cuyo salario (final) sea < Valor
salario_inferior_a(Leg, Ap, Nom, AreaNom, LocNom, Valor) :-
  trabajador(Leg, Nom, Ap, domicilio(_,_,CodL), CodA, _),
  area(CodA, AreaNom),
  localidad(CodL, LocNom),
  salario_final(Leg, S), S < Valor.

/* =========================
   REGLAS (tarea)
   ========================= */

% 4a) Empleados de un área por nombre de área
empleados_de_area(Leg, Ap, Nom, AreaNombre) :-
  trabajador(Leg, Nom, Ap, _, CodA, _),
  area(CodA, AreaNombre).

% 4b) Contratados: legajo, horas/mes y nombre de área
horas_contratados_por_area(Leg, HorasMes, AreaNom) :-
  trabajador(Leg, _, _, _, CodA, contratado(HsDia, _, DiasMes)),
  HorasMes is HsDia * DiasMes,
  area(CodA, AreaNom).

% 4c) Efectivos con > 8 años
efectivos_mas_de_8(Leg, Nom, Ap, LocNom, AreaNom, Antig) :-
  trabajador(Leg, Nom, Ap, domicilio(_,_,CodL), CodA, efectivo(_, Antig, _)),
  Antig > 8,
  localidad(CodL, LocNom),
  area(CodA, AreaNom).

% 4d) Efectivos con antigüedad <= 8
efectivos_hasta_8(Leg, Nom, Ap, LocNom, AreaNom, Antig) :-
  trabajador(Leg, Nom, Ap, domicilio(_,_,CodL), CodA, efectivo(_, Antig, _)),
  Antig =< 8,
  localidad(CodL, LocNom),
  area(CodA, AreaNom).

% 4e) Efectivos con salario final (no llevan viáticos)
efectivos_con_salario_final(Leg, Nom, Ap, AreaNom, LocNom, Antig, SalarioFinal) :-
  trabajador(Leg, Nom, Ap, domicilio(_,_,CodL), CodA, efectivo(Basico, Antig, Coef)),
  Salario is Basico + Basico * Antig * (Coef/100),
  SalarioFinal = Salario,
  localidad(CodL, LocNom),
  area(CodA, AreaNom).

?- [empresa].

% 3a) Legajos de empleados en Córdoba
?- emp_en_cordoba(Leg, _, _, _, _).

% 3b) ¿Existe alguien en Calamuchita o área 1?
?- (existe_calamu_o_area1 -> writeln(si); writeln(no)).

% 3c) Domicilios de quienes NO viven en Córdoba
?- emp_fuera_cordoba(_, Ap, Nom, Calle, Alt).

% 3d) Contratados con >125 hs/mes (legajo y horas)
?- contratados_mas125(Leg, _, _, _, _, Horas).

% 3e) ¿Al legajo 222 le corresponden viáticos?
?- (con_viaticos(222,_,_,_,_) -> writeln(si); writeln(no)).

% 3f) Legajo y salario sin viáticos de cada empleado
?- salario_sin_viaticos(Leg, S).

% 3g) Legajo y salario final (incluye viáticos cuando corresponda)
?- salario_final(Leg, SFinal).

% 3h) Empleados con salario final < 200000
?- salario_inferior_a(Leg, Ap, Nom, Area, Loc, 200000).

% --- Tarea (5a–5e) ---
% 5a) Empleados del área "Marketing"
?- empleados_de_area(Leg, Ap, Nom, 'Marketing').

% 5b) Contratados del área Marketing: legajo y horas/mes
?- horas_contratados_por_area(Leg, Horas, 'Marketing').

% 5c) Legajo, nombre y apellido de cada contratado
?- trabajador(Leg, Nom, Ap, _, _, contratado(_,_,_)).

% 5d) Efectivos con antigüedad <= 8: legajo y antigüedad
?- efectivos_hasta_8(Leg, _, _, _, _, Antig).

% 5e) Salario final de la efectiva llamada 'Diana Gioia'
?- efectivos_con_salario_final(Leg, 'Diana', 'Gioia', Area, Loc, Antig, Sal).

# Cómo cargar todo y probar rápido

?- [aritmetica, sucursales, empresa].
?- nombre_mas_de(N, 180).
?- salario_final(Leg, S).

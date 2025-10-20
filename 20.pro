pedido(1, 111, 30000000, 'Salta', 250, 1, ['television por cable', 'wi fi']).
pedido(2, 111, 20000000, 'Av. Colon', 101, 2, ['wi fi']).
pedido(3, 222, 15000000, 'San Martin', 1321, 1, ['internet por cable']).
pedido(4, 333, 12000000, 'Avellaneda', 3213, 2, ['internet por cable', 'wi fi']).
pedido(5, 333, 25000000, '9 de Julio', 2123, 1, ['television por cable']).
pedido(6, 111, 20000000, 'Urquiza', 1203, 3, ['television satelital']).

tecnico(111, 'Olazabal', 'Juliana').
tecnico(222, 'Luchetti', 'Gertudis').
tecnico(333, 'Manfredi', 'Luiggi').

descuento_barrio(1, 'Centro', 10).
descuento_barrio(2, 'Alberdi', 20).
descuento_barrio(3, 'Cofico', 15).
descuento_barrio(4, 'Maipu', 20).

regla2(Dni) :-
  pedido(_, _, Dni, _, _, _, _),
  !.

regla3(Pedido, Apellido, Nombre, ImporteTotal) :-
  pedido(Pedido, Tecnico, _, _, _, Barrio, Servicios),
  tecnico(Tecnico, Apellido, Nombre),
  length(Servicios, Cantidad),
  descuento_barrio(Barrio, _, Descuento),
  ImporteTotal is (Cantidad * 500) * (100 - Descuento) / 100.

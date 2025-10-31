%ft=prolog

regla1(Articulos) :-
  findall(Articulo,
          ( pedidos(_, _, _, articulo(Codigo, _), _),
            articulos(Codigo, Articulo)
          ),
          ArticulosDuplicados),
  sort(ArticulosDuplicados, Articulos).

regla2(Articulo) :-
  pedidos(_, _, _, articulo(Codigo, _), _),
  articulos(Codigo, Articulo),
  !.

regla3(Nombre, Suma) :-
  findall(ImporteFinal,
          ( pedidos(_, _, Nombre, articulo(Codigo, Cantidad), Promocion),
            articulos(Codigo, _, Precio),
            promociones(Promocion, Porcentaje),
            Importe is Cantidad * Precio,
            ImporteFinal is Importe - Importe * Porcentaje
          ),
          Importes),
  sum(Importes, Suma).

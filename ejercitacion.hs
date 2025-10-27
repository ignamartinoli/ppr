-- 1) Penúltimo elemento (seguro ante listas cortas)
-- penultimo :: [a] -> Maybe a
-- penultimo [x, _] = Just x
-- penultimo (_ : xs) = penultimo xs
-- penultimo _ = Nothing

penultimo :: (Integral a) => [a] -> a
penultimo [m, _] = m
penultimo (_ : xs) = penultimo xs

-- Ejemplos:
-- penultimo [1..5] == Just 4
-- penultimo [7]    == Nothing

-- 3) Pares en [min,max]
filtrarParesEnRango :: [Int] -> Int -> Int -> [Int]
filtrarParesEnRango xs minV maxV =
  [x | x <- xs, even x, x >= minV, x <= maxV]

filtrar :: (Integral a) => [a] -> a -> a -> [a]
filtrar [] _ _ = []
filtrar (x : xs) min max
  | even x && x >= min && x <= max = x : filtrar xs min max
  | otherwise = filtrar xs min max

-- filtrarParesEnRango [1..20] 5 12 == [6,8,10,12]

-- 4) Mostrar los valores de una lista como un solo String
-- (con espacios entre elementos)
mostrarLista :: (Show a) => [a] -> String
mostrarLista = unwords . map show

mostrar :: (Show a) => [a] -> String
mostrar [] = ""
mostrar [x] = show x
mostrar (x : xs) = show x ++ " , " ++ mostrar xs

-- 5) Cantidad de valores menores a p
cantidadMenores :: (Ord a) => [a] -> a -> Int
cantidadMenores xs p = length [x | x <- xs, x < p]

cantidadMenores' :: (Ord a) => [a] -> a -> Int
cantidadMenores' [] _ = 0
cantidadMenores' (x : xs) p
  | x < p = 1 + cantidadMenores' xs p
  | otherwise = cantidadMenores' xs p

-- cantidadMenores [1,7,3,2] 3 == 2

-- 6) Porcentaje de valores menores a p
porcentajeMenores :: (Ord a) => [a] -> a -> Double
porcentajeMenores [] _ = 0
porcentajeMenores xs p =
  100 * fromIntegral (cantidadMenores xs p) / fromIntegral (length xs)

-- porcentajeMenores [1,2,5,8] 5 == 50.0

-- 7) Lista descendente usando comprensión
descendente :: Int -> [Int]
descendente n = [x | x <- [n, n - 1 .. 1]]

-- descendente 5 == [5,4,3,2,1]

-- 8) Cuadrado de los elementos de una lista en el rango [5..15]
cuadradosRango5a15 :: [Int] -> [Int]
cuadradosRango5a15 xs = [x * x | x <- xs, x >= 5, x <= 15]

-- cuadradosRango5a15 [1..20] == map (^2) [5..15]

-- 10) Números impares menores a 15
imparesMenores15 :: [Int]
imparesMenores15 = [x | x <- [1 .. 14], odd x]

-- imparesMenores15 == [1,3,5,7,9,11,13]

-- 11) Sumatoria de elementos en el rango [1..5] usando comprensión
sumatoria1a5 :: [Int] -> Int
sumatoria1a5 xs = sum [x | x <- xs, x >= 1, x <= 5]

-- sumatoria1a5 [0,1,3,6,5] == 9

-- 13) Elementos múltiplos de n
multiplosDe :: Int -> [Int] -> [Int]
multiplosDe 0 _ = [] -- evita división por cero
multiplosDe n xs = [x | x <- xs, mod x n == 0]

-- multiplosDe 3 [1..12] == [3,6,9,12]

-- 14) Lambda que calcula el cubo y aplicarla a [2..10]
cubo :: (Num a) => a -> a
cubo = (^ 3)

cubos2a10 :: [Int]
cubos2a10 = [cubo x | x <- [2 .. 10]]

-- cubos2a10 == [8,27,64,125,216,343,512,729,1000]

-- 15) Evaluar 5x^2 + 2x - 10
polinomio :: (Num a) => a -> a
polinomio x = 5 * x ^ 2 + 2 * x - 10

-- polinomio 3 == 5*9 + 6 - 10 == 41
-- polinomio 4 == 5*16 + 8 - 10 == 78

-- ====== 1) Vector en el plano a partir de dos puntos ======
-- Un punto y un vector como tuplas (x,y)
type Punto = (Double, Double)

type Vector = (Double, Double)

vectorEntre :: (Double, Double) -> (Double, Double) -> (Double, Double)
vectorEntre (x1, y1) (x2, y2) = (x2 - x1, y2 - y1)

vectorEntre' :: (Double, Double) -> (Double, Double) -> (Double, Double)
vectorEntre' v1 v2 = (fst v2 - fst v1, snd v2 - snd v1)

-- Ejemplo: vectorEntre (1,2) (5,7) == (4,5)

-- ====== 2) Operaciones con productos en tuplas ======
-- (nombre, precioUnitario, stock)
type Producto = (String, Double, Int)

-- a) Nombre y valor total (precio * stock) de un producto
nombreYValorTotal :: [Producto] -> [(String, Double)]
nombreYValorTotal ps = [(nombre, precio * fromIntegral stock) | (nombre, precio, stock) <- ps]

-- Ej.: nombreYValorTotal ("Lapicera", 120.5, 3) == ("Lapicera", 361.5)

-- b) Listar todos los productos (sus nombres)
listarProductos :: [Producto] -> [String]
listarProductos ps = [nombre | (nombre, _, _) <- ps]

-- Ej.: listarProductos [("A",10,1),("B",20,2)] == ["A","B"]

-- c) Valor total del stock (suma de precio*stock)
valorTotalStock :: [Producto] -> Double
valorTotalStock ps = sum [precio * fromIntegral stock | (_, precio, stock) <- ps]

-- Ej.: valorTotalStock [("A",10,2),("B",5,4)] == 40.0

-- d) Contar productos con precio > umbral
contarProductosMayorPrecio :: Double -> [Producto] -> Int
contarProductosMayorPrecio umbral ps = length [precio | (_, precio, _) <- ps, precio > umbral]

-- Ej.: contarProductosMayorPrecio 12 [("A",10,1),("B",15,3)] == 1

montoFinal :: (Integral a) => a -> Double -> Double
montoFinal 1 montoBase = montoBase * ((100 - 3) / 100)
montoFinal 2 montoBase = montoBase * ((100 - 5) / 100)
montoFinal 3 montoBase = montoBase * ((100 - 7) / 100)
montoFinal _ _ = 0

montoFinal' :: (Integral a) => a -> Double -> Double
montoFinal' cod montoBase
  | cod == 1 = montoBase * ((100 - 3) / 100)
  | cod == 2 = montoBase * ((100 - 5) / 100)
  | cod == 3 = montoBase * ((100 - 7) / 100)
  | otherwise = 0

montoFinal'' :: (Integral a) => a -> Double -> Double
montoFinal'' cod montoBase = case cod of
  1 -> montoBase * ((100 - 3) / 100)
  2 -> montoBase * ((100 - 5) / 100)
  3 -> montoBase * ((100 - 7) / 100)
  _ -> 0

lista :: [Integer]
lista = [1808, 2619, 3995, 4428, 2448, 7811]

abonadosEntre :: Integer -> Integer -> [Integer]
abonadosEntre min max = [x | x <- lista, between min max x]
  where
    between num1 num2 valor = num1 < valor && valor > num2

suma [] _ = 0
suma (x : xs) p =
  if x > p
    then x + suma xs p
    else suma xs p

largo [] = 0
largo (x : xs) = 1 + largo xs

porcentaje :: Integer -> Double
porcentaje p = fromIntegral (suma lista p) / largo lista

funcion11 x
  | x == 'A' = '9'

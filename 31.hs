funcion1 :: Char -> Char
funcion1 'A' = '9'
funcion1 'E' = '8'
funcion1 'I' = '9'
funcion1 'O' = '7'
funcion1 'U' = '6'
funcion1 _   = '0'

codificar :: String -> String
codificar "" = ""
codificar (x : xs)
  | esCaracter x = x : codificar xs
  | otherwise = funcion1 x : codificar xs
  where
    esCaracter x = funcion1 x == '0'

func1 :: Double -> Int -> Int -> Double
func1 precio cantidad descuento =
  precio * fromIntegral cantidad - (precio * fromIntegral cantidad * promocion descuento)
  where
    promocion codigo = case codigo of
      0 -> 0
      1 -> 0.5
      2 -> 0.25
      3 -> 0.1
      _ -> 0

lista :: [Integer]
lista = [23454, 12432, 7890, 10000, 0, 0, 12345, 5555]

func2 lista =
  [ totales
  | totales <- lista,
    totales <= 8000,
    totales /= 0
  ]

contar []       = 0
contar (x : xs) = 1 + contar xs

suma []       = 0
suma (x : xs) = x + suma xs

func3 lista = suma lista / contar lista

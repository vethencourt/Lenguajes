module Haskinator where

main = do
	putStrLn "Haskinator!"
	putStrLn "Seleccione una opcion indicando su numero:"
	putStrLn "(1) Crear oraculo nuevo."
	putStrLn "(2) Predecir"
	putStrLn "(3) Cargar"
	putStrLn "(4) Consultar pregunta crucial"
	opcion <- getLine

	case getLine of
	1 ->
	2 ->
	3 ->
	4 ->
	main

crearOraculo :: Maybe Oraculo
crearOraculo = Nothing

predecir :: Oraculo

persistir :: String -> File

cargar :: String -> Maybe Oraculo

pregCrucial :: String -> String -> Maybe Oraculo

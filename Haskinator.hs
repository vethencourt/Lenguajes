module Haskinator where
import Oraculo

main = do
	putStrLn "Haskinator!"
	putStrLn "Seleccione una opcion indicando su numero:"
	putStrLn "(1) Crear oraculo nuevo."
	putStrLn "(2) Predecir"
	putStrLn "(3) Cargar"
	putStrLn "(4) Consultar pregunta crucial"
	opcion <- getLine

{-	case opcion of 
	1 -> let oraculo = crearOraculo
	2 -> 
	3 ->
	4 ->
-}	main

crearOraculo :: Maybe Oraculo
crearOraculo = Nothing

persistir :: String -> Maybe Oraculo -> IO ()
persistir fileName (Just oraculo) = writeFile fileName (show oraculo) 
persistir fileName Nothing = error "Oraculo vacio"


--predecir :: Oraculo


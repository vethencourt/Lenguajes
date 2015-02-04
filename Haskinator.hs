module Haskinator (main) where

import Oraculo
import Data.Maybe

main = do
	putStrLn ""
	putStrLn "Bienvenido a ¡¡HASKINATOR!!"
	menu Nothing
	main

menu :: Maybe Oraculo -> IO ()
menu x = do
	putStrLn ""
	putStrLn "Seleccione una opcion indicando su numero:"
	putStrLn "(1) Crear oraculo nuevo."
	putStrLn "(2) Predecir"
	putStrLn "(3) Persistir"
	putStrLn "(4) Cargar"
	putStrLn "(5) Consultar pregunta crucial"
	putStrLn "(6) Consultar estadística"
	opcion <- getLine
	putStrLn ""

	case opcion of 	
		"1" -> menu crearOraculo
		"2" -> do
					orc <-predecir x
					menu orc
		"3" -> do
			putStrLn "Especifique el nombre del archivo donde se guardara el oraculo"
			fileName <- getLine
			persistir fileName x
			menu x
		"4" -> do
			putStrLn "Especifique el nombre del archivo para cargar el oraculo"
			fileName <- getLine
			x <- cargar fileName
			putStrLn "Archivo cargado satisfactoriamente"
			putStrLn ""
			menu x
		"5" -> do
			putStrLn "Introduzca la primera predicción"
			s1 <- getLine
			putStrLn "Introduzca la segunda predicción"			
			s2 <- getLine
			putStrLn (pregCrucial s1 s2 x)
			menu x
		"6" -> 
			if isNothing x then
				putStrLn "Oraculo vacío"
			else
				do 
					putStrLn (showObtEst (obtenerEstadisticas (fromJust x)))
					menu x
		_ -> do
			putStrLn "Introduzca un número válido"
			menu x

crearOraculo :: Maybe Oraculo
crearOraculo = Nothing

persistir :: String -> Maybe Oraculo -> IO ()
persistir fileName (Just oraculo) = writeFile fileName (show oraculo) 
persistir fileName Nothing = error "Oraculo vacío"

pregCrucial :: String -> String -> Maybe Oraculo -> String
pregCrucial s1 s2 (Just oraculo) =
	let encontrado1 = fromMaybe [("0",False)] (obtenerCadena oraculo s1); 
		encontrado2 = fromMaybe [("0",False)] (obtenerCadena oraculo s2) in
		if ((encontrado1 == [("0",False)]) || (encontrado2 == [("0",False)])) then
			"Consulta inválida, predicción no encontrada"
		else 
			let length1 = (length encontrado1); length2 = (length encontrado2) in
			--	if length1 == 0 || length2 == 0 then
				if length1 < length2 then
					findPadre (reverse encontrado1) (reverse (take length1 encontrado2))
				else
					findPadre (reverse (take length2 encontrado1)) (reverse encontrado2)
				where
					findPadre (x1:xs1) (x2:xs2) = 
						if (fst x1) == (fst x2) then (fst x1)
						else if xs1 /= [] && xs2 /= [] then
							findPadre xs1 xs2
						else
							"Error"
					findPadre [] [] = "No existen preguntas en el oraculo"

predecir :: Maybe Oraculo -> IO (Maybe Oraculo)
predecir (Just x) = 
	do
		aux <- predecirAux x
		return (Just aux)
predecir Nothing = 
	do
		putStrLn "El oráculo está vacío."
		putStrLn ""
		putStrLn "Escribe una pregunta"
		preg <- getLine
		putStrLn "Escribe la respuesta que lo cumpla"
		oPos <- getLine
		putStrLn "Escribe otra respuesta que no lo cumpla"
		oNeg <- getLine
		putStrLn ""
		return (Just (crearPregunta preg (crearPrediccion oPos) (crearPrediccion oNeg)))

predecirAux :: Oraculo -> IO Oraculo
predecirAux (Pregunta s1 oPos oNeg) =  
	do
		putStrLn s1
		rpta <- getLine
		case rpta of
			"si" -> do
				opos <- predecirAux oPos
				return (Pregunta s1 opos oNeg)
			"no" -> do
				oneg <- predecirAux oNeg
				return (Pregunta s1 oPos oneg)
			_ -> 
				do
					putStrLn "debes responder 'si' o 'no'"
					predecirAux (Pregunta s1 oPos oNeg)
predecirAux (Prediccion s) = 
	do
		putStrLn ("¿Pensaste en: " ++ s ++ "?")
		rpta <- getLine
		case rpta of
			"si" ->  return (Prediccion s)
			"no" -> 
				do
					putStrLn "Escribe una pregunta que diferencie lo que pensaste de lo que yo predije"
					putStrLn "cuya respuesta afirmativa sea lo que tu pensaste"
					preg <- getLine
					putStrLn "Escribe lo que pensaste"
					rpta <- getLine
					putStrLn ""
					return (Pregunta preg (Prediccion rpta) (Prediccion s))
			_ ->
				do
					putStrLn "debes responder 'si' o 'no'"
					predecirAux (Prediccion s)


showObtEst :: (Integer,Integer,Integer) -> String
showObtEst (x,y,z) = "(minimo: " ++ show x ++ ", maximo: " ++ show y ++ ", promedio: " ++ show z ++ ")"

cargar :: String -> IO (Maybe Oraculo)
cargar fileName = 
	do
		x <- readFile fileName
		let oraculo :: Oraculo ; oraculo = (read x) in
			return (Just oraculo)
		


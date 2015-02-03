import Oraculo
import Data.Maybe

main = do
	menu (Just (Prediccion "Es priki"))
	main

menu :: Maybe Oraculo -> IO ()
menu x = do
	putStrLn "Haskinator!"
	putStrLn "Seleccione una opcion indicando su numero:"
	putStrLn "(1) Crear oraculo nuevo."
	putStrLn "(2) Predecir"
	putStrLn "(3) Persistir"
	putStrLn "(4) Cargar"
	putStrLn "(5) Consultar pregunta crucial"
	putStrLn "(6) Consultar estadistica"
	opcion <- getLine

	case opcion of 	
		"1" -> menu crearOraculo
		"2" -> menu x
		"3" -> do
			putStrLn "Especifique el nombre del archivo donde se guardara el oraculo"
			fileName <- getLine
			persistir fileName x
		"4" -> menu x {- do
			putStrLn "Especifique el nombre del archivo para cargar el oraculo"
			fileName <- getLine
			cargar (read fileName)
			--menu (Just y)-}
		"5" -> do
			putStrLn "Introduzca la primera prediccion"
			s1 <- getLine
			putStrLn "Introduzca la segunda prediccion"			
			s2 <- getLine
			putStrLn (pregCrucial s1 s2 x)
			menu x
		"6" -> 
			if isNothing x then
				putStrLn "Oraculo vacio"
			else
				do 
					putStrLn (showObtEst (obtenerEstadisticas (fromJust x)))
					menu x


crearOraculo :: Maybe Oraculo
crearOraculo = Nothing

persistir :: String -> Maybe Oraculo -> IO ()
persistir fileName (Just oraculo) = writeFile fileName (show oraculo) 
persistir fileName Nothing = error "Oraculo vacio"

pregCrucial :: String -> String -> Maybe Oraculo -> String
pregCrucial _ _ Nothing = "Consulta invalida, oraculo vacio"
pregCrucial s1 s2 (Just oraculo) = 
	let encontrado1 = obtenerCadena oraculo s1; encontrado2 = obtenerCadena oraculo s2 in
	if ((encontrado1 == Nothing) || (encontrado2 == Nothing)) 
	then "Consulta invalida, prediccion no encontrada"
	else 
		if encontrado1 /= (Just [])
		then (findPadre encontrado1 encontrado2)
		else
			"Solo hay una prediccion, no hay preguntas en el oraculo"
		where
			findPadre (Just ((str1,bool1):tl1)) (Just ((str2,bool2):tl2)) = 
				if (tl1 !! 0) == (tl2 !! 0) 
				then findPadre (Just tl1) (Just tl2)
				else str1

predecir :: Maybe Oraculo -> IO (Maybe Oraculo)
predecir (Just x) = 
	do
		aux <- predecirAux x
		return (Just aux)
predecir Nothing = return Nothing

predecirAux :: Oraculo -> IO Oraculo
predecirAux (Pregunta s1 oPos oNeg) =  
	do
		opos <- predecirAux oPos
		oneg <- predecirAux oNeg
		putStrLn s1
		rpta <- getLine
		case rpta of
			"si" -> return (Pregunta s1 opos oNeg)
			"no" -> return (Pregunta s1 oPos oneg)
			_ -> 
				{-do
					putStrLn "debes responder 'si' o 'no'"-}
				predecirAux (Pregunta s1 oPos oNeg)
predecirAux (Prediccion s) = 
	do
		putStrLn ("¿Pensaste en: " ++ s ++ "?")
		rpta <- getLine
		case rpta of
			"si" -> return (Prediccion s)
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
showObtEst (x,y,z) = "(" ++ show x ++ "," ++ show y ++ "," ++ show z ++ ")"
--no conseguir = Nothing

{-
cargar :: IO String -> Maybe Oraculo
cargar x = let y <- x in (Just y) --(\x -> (y<-x) -> Just y)
--predecir :: Oraculo
-}

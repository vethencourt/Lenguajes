module Oraculo where

data Oraculo = Prediccion String | Pregunta String Oraculo Oraculo
	deriving (Show,Eq)
	
crearPrediccion :: String -> Oraculo
crearPrediccion = Prediccion

crearPregunta :: String -> Oraculo -> Oraculo -> Oraculo
crearPregunta = Pregunta

prediccion :: Oraculo -> String
prediccion (Prediccion s) = s
prediccion (Pregunta _ _ _) = error "Esto no es una Pregunta"

pregunta :: Oraculo -> String
pregunta (Pregunta s _ _) = s
pregunta (Prediccion _) = error "Esto no es una Prediccion"

positivo :: Oraculo -> Oraculo
positivo (Pregunta _ o _) = o
positivo (Prediccion _) = error "Esto no es una Prediccion"

negativo :: Oraculo -> Oraculo
negativo (Pregunta _ _ o) = o
negativo (Prediccion _) = error "Esto no es una Prediccion"

obtenerCadena :: Oraculo -> String -> Maybe [(String, Bool)]
obtenerCadena (Pregunta s1 oPos oNeg) s2 =  
	let positivo = obtenerCadena oPos s2 ; negativo = obtenerCadena oNeg s2 in
	case positivo of
		Nothing -> case negativo of
			Nothing -> Nothing
			Just l  -> Just ([(s1,False)] ++ l)
		Just l -> Just ([(s1,True)] ++ l)
obtenerCadena (Prediccion s1) s2 = if s1 == s2 then Just [] else Nothing

-- Funcion auxiliar para obtenerCadena 
justAppend :: Maybe [(String, Bool)] -> Maybe [(String, Bool)] -> Maybe [(String, Bool)]
justAppend (Just x) (Just y) = Just (x++y)
justAppend Nothing x = x
justAppend x Nothing = x

obtenerEstadisticas :: Oraculo -> (Integer,Integer,Integer)
obtenerEstadisticas x = (\(min,max,answers,sumLength) -> (min,max,div sumLength answers)) (obtEst x 0)

obtEst :: Oraculo -> Integer -> (Integer,Integer,Integer,Integer)
obtEst (Pregunta _ oPos oNeg) nivel = (\(min1,max1,answers1,sumLength1) (min2,max2,answers2,sumLength2) -> 
						if min1<min2 then
							if max1>max2 then
								(min1,max1,answers1+answers2,sumLength1+sumLength2)
							else
								(min1,max2,answers1+answers2,sumLength1+sumLength2)
						else
							if max1>max2 then
								(min2,max1,answers1+answers2,sumLength1+sumLength2)
							else
								(min2,max2,answers1+answers2,sumLength1+sumLength2)
					) (obtEst oPos (nivel+1)) (obtEst oNeg (nivel+1))
obtEst (Prediccion _) nivel = (nivel,nivel,1,nivel)

{-
andMaybe :: Maybe[(String,Bool)] -> Maybe[(String,Bool)] -> Maybe[(String,Bool)] 
andMaybe (Just x) _ = Just x
andMaybe Nothing x = x
-}

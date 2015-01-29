module Haskinator where

crearOraculo :: Maybe Oraculo
crearOraculo = Nothing

predecir :: Oraculo
predecir (Pregunta s1 oPos oNeg) = -print- s1 ; if "si" then predecir oPos else predecir oNeg
predecir (Prediccion s) = s ; if "si" then -print- "Woohoo" else "en q c dif?" ...

persistir (imprimir en archivo) :: String -> File

cargar :: String -> Maybe Oraculo

pregCrucial :: String -> String -> Maybe Oraculo


 
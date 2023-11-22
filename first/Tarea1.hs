--TODO add the most general definition for each function
--PARTE 1
--1
esNoTanBit::Int -> Bool
esNoTanBit x = x == 0 || x == 1

--2
negarBit:: Int -> Int
negarBit x = if esNoTanBit(x) then 1 else error "invalid input"

--3
-- x = [Int]. return Bool

type Checker = [Int] -> Bool

--a with guards
esSecuenciaNoTanBits1:: Checker
esSecuenciaNoTanBits1 [] = True
esSecuenciaNoTanBits1 (x:xs)
  | esNoTanBit x && esSecuenciaNoTanBits1 xs = True
  | otherwise = False

--b 
esSecuenciaNoTanBits2:: Checker
esSecuenciaNoTanBits2 [] = True
esSecuenciaNoTanBits2 (x:xs) = esNoTanBit x && esSecuenciaNoTanBits2 xs

--c
esSecuenciaNoTanBits3:: Checker
esSecuenciaNoTanBits3 = all esNoTanBit


--4 
type Mapper = [Int] -> [Int]
inverter::Int->Int
inverter x = -(x-1)

--a
invertirNoTanBits:: Mapper
invertirNoTanBits [] = []
invertirNoTanBits (x:xs) = inverter x:invertirNoTanBits xs

--b
invertirNoTanBits2::Mapper
invertirNoTanBits2 = map inverter

--c
invertirNoTanBits3::Mapper
invertirNoTanBits3 xs = [inverter x | x <- xs]

--5 se asume q x solo contiene noTanBits (0,1)
contarNoTanBits::[Int] -> (Int,Int)
contarNoTanBits x = (length(x) - n, n)
  where n = foldl (+) 0 x

--6
secuenciasNoTanBits::Int -> [[Int]]
-- tomamos el caso base requerido. Luego llamamos la funcion para generar
-- el arreglo del n-1 y duplicamos su tama;o. A la mitad le agregamos 1 y
-- la otra mitad 0. De esta manera obtenemos las combinaciones.
secuenciasNoTanBits n 
  | n <= 0 = []
  | otherwise = map (1:) prev  ++ map (0:) prev
    where prev = secuenciasNoTanBits (n-1)

--PARTE2

data Lista a = Vacia | Const a (Lista a)
 deriving Show

--7
aLista:: [a] -> Lista a

aLista [] = Vacia
aLista (x:xs) = Const x (aLista xs)

--8
aListaHaskell :: Lista a -> [a]

aListaHaskell Vacia = []
aListaHaskell (Const a rest)= a:aListaHaskell rest

-- No usar funciones ya definidas de aqui en adelante

--9
concatena :: Lista a -> Lista a -> Lista a

concatena  Vacia (Const a rest)= Const a rest
concatena  (Const x xs) (Const y ys)= Const x (concatena xs (Const y ys))

--10

--(++):: Lista a -> Lista a -> Lista a
--(Const x xs) ++ (Const y ys) = concatena(Const(x xs), Const(y ys))

--11

eliminaTodos:: (a -> Bool) -> Lista a -> Lista a

eliminaTodos f Vacia = Vacia
eliminaTodos f (Const x xs) = if f x then (Const x rest) else rest
  where rest = eliminaTodos f xs

--12

ordenar:: Lista a -> Lista a
ordenar a = Vacia





module Tarea1 where
--PARTE 1

--1
esNoTanBit::(Num a, Ord a) => a -> Bool
esNoTanBit x = x == 0 || x == 1

--2
negarBit::  (Num a, Ord a) => a -> a
negarBit x = if esNoTanBit(x) then -(x-1) else error "invalid input"

--3
-- x = [Int]. return Bool

type Checker a = [a] -> Bool

--a with guards
esSecuenciaNoTanBits1:: (Num a, Ord a)=> Checker a
esSecuenciaNoTanBits1 [] = True
esSecuenciaNoTanBits1 (x:xs)
  | esNoTanBit x && esSecuenciaNoTanBits1 xs = True
  | otherwise = False

--b 
esSecuenciaNoTanBits2:: (Num a, Ord a)=> Checker a
esSecuenciaNoTanBits2 [] = True
esSecuenciaNoTanBits2 (x:xs) = esNoTanBit x && esSecuenciaNoTanBits2 xs

--c
esSecuenciaNoTanBits3:: (Num a, Ord a)=> Checker a
esSecuenciaNoTanBits3 = all esNoTanBit


--4 
type Mapper a = [a] -> [a]

--a
invertirNoTanBits:: (Num a, Ord a) => Mapper a
invertirNoTanBits [] = []
invertirNoTanBits (x:xs) = negarBit x:invertirNoTanBits xs

--b
invertirNoTanBits2::(Num a, Ord a) => Mapper a
invertirNoTanBits2 = map negarBit

--c
invertirNoTanBits3::(Num a, Ord a) => Mapper a
invertirNoTanBits3 xs = [negarBit x | x <- xs]

--5 se asume q x solo contiene noTanBits (0,1)
contarNoTanBits::[Int] -> (Int,Int)
contarNoTanBits x = (length(x) - n, n)
  where n = foldl (+) 0 x

--6
secuenciasNoTanBits::(Num a, Ord a) => a -> [[Int]]
-- tomamos el caso base de n=0 y n=1. Es necesario especificar n=1 ya que
-- basicamente "multiplicamos" el arreglo por 2 en cada iteracion. 
-- Luego llamamos la funcion para generar el arreglo del n-1 y hacemos 2 copias.
-- A una copia le agregamos 1 al frente de cada elemento a la otra le agregamos 0.
secuenciasNoTanBits n 
  | n <= 0 = []
  | n == 1 = [[0],[1]]
  | otherwise = map (0:) prev  ++ map (1:) prev
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

concatena  Vacia Vacia = Vacia
concatena  Vacia (Const a rest)= Const a rest
concatena  (Const a rest) Vacia = Const a rest
concatena  (Const x xs) (Const y ys)= Const x (concatena xs (Const y ys))

--10

--(++):: Lista a -> Lista a -> Lista a
--(Const x xs) ++ (Const y ys) = concatena(Const(x xs), Const(y ys))

--11

eliminaTodos:: (a -> Bool) -> Lista a -> Lista a

eliminaTodos f Vacia = Vacia
eliminaTodos f (Const x xs) = if not (f x) then (Const x rest) else rest
  where rest = eliminaTodos f xs

--12

ordenar :: Ord a => Lista a -> Lista a

ordenar Vacia = Vacia
ordenar (Const x xs) = lower xs `concatena` (Const x Vacia) `concatena` upper xs
  where lower = ordenar . eliminaTodos (>=x) 
        upper = ordenar . eliminaTodos (<x) 





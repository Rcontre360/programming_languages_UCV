--25

data Arbol= Hoja Int | Nodo Int Arbol Arbol

isHeap::Arbol -> Bool

isHeap (Hoja _) = True
isHeap (Nodo val (Hoja x) (Hoja y)) = val <= x && val <= y

isHeap (Nodo val (Nodo y left_y right_y) (Hoja x)) = val <= y && val <= x && isHeap (Nodo y left_y right_y)
isHeap (Nodo val (Hoja x) (Nodo y left_y right_y)) = val <= x && val <= y && isHeap(Nodo y left_y right_y)
isHeap (Nodo val (Nodo x left_x right_x) (Nodo y left_y right_y)) = val <= x && val <= y && 
  isHeap(Nodo x left_x right_x) && isHeap(Nodo y left_y right_y)


-- 24

weirdFilter :: [[Int]] -> [[Int]]

weirdFilter [] = []
weirdFilter (x:xs) = (x:weirdFilter final)
  where final = map (filter_fn x)  xs
        filter_fn list_a list_b = filter (\b -> not (elem b list_a)) list_b

-- 23 TODO

permutaciones::[Int] -> [[Int]]

permutaciones [] = []
permutaciones [x] = [[x]]
permutaciones x = aux x []

aux::[Int] -> [Int] -> [[Int]]

aux [] [] = []
aux [] x = [x]
aux x y = map (\el->el:y) x

-- 22

prodCart::[Int] -> [Int] -> [(Int,Int)]

prodCart [] [] = []
prodCart x [] = []
prodCart [] x = []

prodCart x y = [ (elx, ely) | elx <- x, ely <- y ]

-- 21

mLista :: [Int] -> [[Int]]

mLista [] = []
mLista (x:xs) = [[x,n,x*n]] ++ (mLista.filter (x/=) $ xs)
  where n = 1 + length(filter (x==) xs)

-- 20

mMatriz::[[Int]] -> [[Int]] -> [[Int]]
mMatriz a b = b
-- nawebona, dificil

--19

mSublista::[Int] -> Int -> [[Int]]

mSublista [] _ = []
mSublista [x] a = if x == a then [[]] else []
mSublista list el = if isIn then first:(mSublista rest el) else [list]
  where isIn = any (el==) list
        first = takeWhile (el/=) list
        one:rest = dropWhile (el/=) list
--ALMOST

data Expr = Numero Integer
  | Suma Expr Expr
  | Producto Expr Expr

toString :: Expr -> String

toString (Numero n) = show n
toString (Suma a b) = (toString a) ++ "+" ++ (toString b)
toString (Producto a b) = "(" ++ (toString a) ++ "*" ++ (toString b) ++ ")"

toString (Producto a b) = "(" ++ (toString a) ++ "*" ++ (toString b) ++ ")"

eval::Expr -> Integer

eval (Numero n) = n
eval (Suma a b) = (eval a) + (eval b)
eval (Producto a b) = (eval a) * (eval b)

data Arbin a = Node a (Arbin a) (Arbin a)
  | Leaf a

max3Node:: (Ord a, Num a) => Arbin a -> (a , a , a)

max3Node (Leaf a) = (a,0,0)
max3Node (Node a b c) = (maxTuple (a, getCurrent b, getCurrent c) (maxTuple left right))
  where left = max3Node b
        right = max3Node c
        maxTuple (a,b,c) (x,y,z) = if a+b+c > x+y+z then (a,b,c) else (x,y,z)

getCurrent::(Ord a,Num a) => Arbin a -> a
getCurrent (Node one two three) = one
getCurrent (Leaf a) = a

insertar::a -> [a] -> [[a]]

insertar a [] = [[a]]
insertar a (x:xs) = (a:x:xs):map (\el -> x:el) (insertar a xs)

funcion_misteriosa::[Int] -> [[Int]]

funcion_misteriosa (x:xs) = foldl(\a b->concat $ map (insertar b) a)[[x]] xs





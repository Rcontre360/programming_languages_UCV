import Control.Exception (SomeException, try, evaluate)
import Tarea1

instance (Eq a) => Eq (Lista a) where
    Vacia == Vacia = True
    Const x xs == Const y ys = x == y && xs == ys
    _ == _ = False

-- A simple test function that takes a test name, a function, an expected value, and an actual value
expect :: (Eq a, Show a) => String -> a -> a -> IO ()
expect testName expected actual =
  if expected == actual
  then putStrLn $ "    " ++ testName ++ ": Success"
  else putStrLn $ "    " ++ testName ++ ": Failure. Expected " ++ show expected ++ ", but got " ++ show actual

expectException :: Show a => String -> a -> (a -> Int) -> IO ()
expectException testName input action = do
    result <- try (evaluate (action input)) :: IO (Either SomeException Int)
    case result of
        Left _  -> putStrLn $ "    " ++ testName ++ ": Success"
        Right _ -> putStrLn $ "    " ++testName ++ ": Failure, no exception caught"


describe :: String -> IO()
describe suite = do
  putStrLn $ "Testing: " ++ suite

esNoTanBitTests:: IO()
esNoTanBitTests = do
  describe "esNoTanBit"
  expect "with 0" True (esNoTanBit 0)
  expect "with 1" True (esNoTanBit 1)
  expect "with 2" False (esNoTanBit 2)
  expect "with -1" False (esNoTanBit 31)

negarBitTests:: IO()
negarBitTests = do
  describe "negarBit"
  expect "with 0" 1 (negarBit 0)
  expect "with 1" 1 (negarBit 1)
  expectException "Not bit" 2 negarBit
  expectException "Not bit" 4 negarBit

esSecuenciaNoTanBits1Tests:: IO()
esSecuenciaNoTanBits1Tests = do
  describe "esSecuenciaNoTanBits1"
  expect "empty list" True (esSecuenciaNoTanBits1 [])
  expect "with bits" True (esSecuenciaNoTanBits1 [0,0,0,0,0])
  expect "with bits" True (esSecuenciaNoTanBits1 [1,1,1,1,1])
  expect "with bits" True (esSecuenciaNoTanBits1 [1,0,0,1,0])
  expect "with no bits" False (esSecuenciaNoTanBits1 [1,0,0,1,2])
  expect "with no bits" False (esSecuenciaNoTanBits1 [5])

esSecuenciaNoTanBits2Tests:: IO()
esSecuenciaNoTanBits2Tests = do
  describe "esSecuenciaNoTanBits2"
  expect "empty list" True (esSecuenciaNoTanBits2 [])
  expect "with bits" True (esSecuenciaNoTanBits2 [0,0,0,0,0])
  expect "with bits" True (esSecuenciaNoTanBits2 [1,1,1,1,1])
  expect "with bits" True (esSecuenciaNoTanBits2 [1,0,0,1,0])
  expect "with no bits" False (esSecuenciaNoTanBits2 [1,0,0,1,2])
  expect "with no bits" False (esSecuenciaNoTanBits2 [5])

esSecuenciaNoTanBits3Tests:: IO()
esSecuenciaNoTanBits3Tests = do
  describe "esSecuenciaNoTanBits3"
  expect "empty list" True (esSecuenciaNoTanBits3 [])
  expect "with bits" True (esSecuenciaNoTanBits3 [0,0,0,0,0])
  expect "with bits" True (esSecuenciaNoTanBits3 [1,1,1,1,1])
  expect "with bits" True (esSecuenciaNoTanBits3 [1,0,0,1,0])
  expect "with no bits" False (esSecuenciaNoTanBits3 [1,0,0,1,2])
  expect "with no bits" False (esSecuenciaNoTanBits3 [5])

invertirNoTanBitsTest:: IO()
invertirNoTanBitsTest = do
  describe "invertirNoTanBits"
  expect "empty list" [] (invertirNoTanBits [])
  expect "zeroes" [1,1,1,1,1] (invertirNoTanBits [0,0,0,0,0])
  expect "ones" [0,0,0,0,0] (invertirNoTanBits [1,1,1,1,1])
  expect "combined" [0,1,1,0,1] (invertirNoTanBits [1,0,0,1,0])
  expect "one" [0] (invertirNoTanBits [1])
  expect "zero" [1] (invertirNoTanBits [0])

invertirNoTanBits2Test:: IO()
invertirNoTanBits2Test = do
  describe "invertirNoTanBits2"
  expect "empty list" [] (invertirNoTanBits2 [])
  expect "zeroes" [1,1,1,1,1] (invertirNoTanBits2 [0,0,0,0,0])
  expect "ones" [0,0,0,0,0] (invertirNoTanBits2 [1,1,1,1,1])
  expect "combined" [0,1,1,0,1] (invertirNoTanBits2 [1,0,0,1,0])
  expect "one" [0] (invertirNoTanBits2 [1])
  expect "zero" [1] (invertirNoTanBits2 [0])

invertirNoTanBits3Test:: IO()
invertirNoTanBits3Test = do
  describe "invertirNoTanBits3"
  expect "" [] (invertirNoTanBits3 [])
  expect "" [1,1,1,1,1] (invertirNoTanBits3 [0,0,0,0,0])
  expect "" [0,0,0,0,0] (invertirNoTanBits3 [1,1,1,1,1])
  expect "" [0,1,1,0,1] (invertirNoTanBits3 [1,0,0,1,0])
  expect "" [0] (invertirNoTanBits3 [1])
  expect "" [1] (invertirNoTanBits3 [0])

contarNoTanBitsTest:: IO()
contarNoTanBitsTest = do
  describe "contarNoTanBitsTest"
  expect "" (0,0) (contarNoTanBits [])
  expect "" (5,0) (contarNoTanBits [0,0,0,0,0])
  expect "" (0,5) (contarNoTanBits [1,1,1,1,1])
  expect "" (3,2) (contarNoTanBits [1,0,0,1,0])
  expect "" (0,1) (contarNoTanBits [1])
  expect "" (1,0) (contarNoTanBits [0])

secuenciasNoTanBitsTest:: IO()
secuenciasNoTanBitsTest = do
  describe "secuenciasNoTanBitsTest"
  expect "" [] (secuenciasNoTanBits 0)
  expect "" [[1],[0]] (secuenciasNoTanBits 1)
  expect "" [[1,1],[1,0],[0,1],[0,0]] (secuenciasNoTanBits 2)
  expect "" 
      [[1,1,1],[1,1,0],[1,0,1],[1,0,0],
      [0,1,1],[0,1,0],[0,0,1],[0,0,0]] (secuenciasNoTanBits 3)
  expect "" 
      [[1,1,1,1],[1,1,1,0],[1,1,0,1],[1,1,0,0],
      [1,0,1,1],[1,0,1,0],[1,0,0,1],[1,0,0,0],
      [0,1,1,1],[0,1,1,0],[0,1,0,1],[0,1,0,0],
      [0,0,1,1],[0,0,1,0],[0,0,0,1],[0,0,0,0]] (secuenciasNoTanBits 4)

aListaTest:: IO()
aListaTest = do
  describe "aListaTest"
  expect "" Vacia (aLista([] :: [Int]))
  expect "" Vacia (aLista([] :: [Int]))
  expect "" (Const 1 Vacia) (aLista [1])
  expect "" (Const 1 (Const 2 Vacia)) (aLista [1,2])
  expect "" (Const 1 (Const 2 (Const 5 Vacia))) (aLista [1,2,5])

aListaHaskellTest:: IO()
aListaHaskellTest = do
  describe "aListaHaskellTest"
  expect "" ([] :: [Int]) (aListaHaskell Vacia)
  expect "" [1] (aListaHaskell (Const 1 Vacia))
  expect "" [1,2] (aListaHaskell (Const 1 (Const 2 Vacia)))
  expect "" [1,2,3] (aListaHaskell (Const 1 (Const 2 (Const 3 Vacia))))

concatenaTest:: IO()
concatenaTest = do
  describe "concatenaTest"
  expect "" (Vacia :: Lista Int) (concatena Vacia Vacia)
  expect "" (Const 1 Vacia) (concatena (Const 1 Vacia) Vacia)
  expect "" (Const 1 Vacia) (concatena Vacia (Const 1 Vacia))
  expect "" (Const 1 (Const 2 Vacia)) (concatena (Const 1 Vacia) (Const 2 Vacia))
  expect "" (Const 1 (Const 2 (Const 3 Vacia))) (concatena (Const 1 Vacia) (Const 2 (Const 3 Vacia)))
  expect "" (Const 1 (Const 2 (Const 3 Vacia))) (concatena (Const 1 (Const 2 Vacia)) (Const 3 Vacia))

eliminaTodosTest:: IO()
eliminaTodosTest = do
  describe "eliminaTodosTest"
  expect "" Vacia (eliminaTodos odd Vacia)
  expect "" Vacia (eliminaTodos odd (Const 1 Vacia))
  expect "" (Const 2 Vacia) (eliminaTodos odd (Const 1 (Const 2 Vacia)))
  expect "" (Const 2 (Const 4 (Const 6 Vacia))) (eliminaTodos odd (Const 1 (Const 2 (Const 3 (Const 4 (Const 6 Vacia))))))

ordenarTest:: IO()
ordenarTest = do
  describe "ordenarTest"
  expect "" (Vacia :: Lista Int) (ordenar Vacia)
  expect "" (Const 1 Vacia) (ordenar (Const 1 Vacia))
  expect "" (Const 1 (Const 2 Vacia)) (ordenar (Const 1 (Const 2 Vacia)))
  expect "" (Const 2 (Const 4 (Const 6 Vacia))) (ordenar (Const 6 (Const 4 (Const 2 Vacia))))
  expect "" (Const 2 (Const 4 (Const 6 Vacia))) (ordenar (Const 2 (Const 6 (Const 4 Vacia))))
  expect "" (Const 1 (Const 2 (Const 3 (Const 4 Vacia)))) (ordenar (Const 1 (Const 3 (Const 2 (Const 4 Vacia)))))
  expect "" (Const 1 (Const 2 (Const 3 (Const 4 Vacia)))) (ordenar (Const 3 (Const 1 (Const 4 (Const 2 Vacia)))))
  expect "" (Const 1 (Const 1 (Const 1 (Const 4 Vacia)))) (ordenar (Const 1 (Const 1 (Const 1 (Const 4 Vacia)))))


main :: IO ()
main = do
  esNoTanBitTests
  negarBitTests
  esSecuenciaNoTanBits1Tests
  esSecuenciaNoTanBits2Tests
  esSecuenciaNoTanBits3Tests
  invertirNoTanBitsTest
  invertirNoTanBits2Test
  invertirNoTanBits3Test
  contarNoTanBitsTest
  secuenciasNoTanBitsTest
  aListaTest
  aListaHaskellTest
  concatenaTest
  eliminaTodosTest
  ordenarTest





main::IO()
main = do
  foldr (\i a -> i+a) 0 [1,2,3]
  putStrLn "test" 

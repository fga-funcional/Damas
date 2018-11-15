module Main where

import Datas
import Functions
import JSON


main :: IO ()
main = putStrLn "Hello, Haskell!"
-- main = do
--     -- Get JSON data and decode it
--     d <- (eitherDecode <$> getJSON) :: IO (Either String [Board])
--     -- If d is Left, the JSON was malformed.
--     -- In that case, we report the error.
--     -- Otherwise, we perform the operation of
--     -- our choice. In this case, just print it.
--     case d of
--         Left err -> putStrLn err
--         Right ps -> print ps
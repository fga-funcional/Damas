module JSON where

import Data.Aeson
import qualified Data.ByteString.Lazy as B
import Network.HTTP.Conduit (simpleHttp)
import GHC.Generics

-- Instances to convert our type to/from JSON.

instance FromJSON Board
instance ToJSON Board


jsonURL :: String
-- jsonURL = "http://daniel-diaz.github.io/misc/pizza.json"

getJSON :: IO B.ByteString
getJSON = simpleHttp jsonURL

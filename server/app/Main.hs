{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Data.Monoid ((<>))
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import Web.Scotty

data Player =
  Player {
    playerColor     :: Bool,    -- False - White player / True - Red player
    isPlayerTurn    :: Bool
  } deriving (Show, Generic)

data Piece =
  Piece {
    color   :: Bool,    -- False - White    / True - Red
    isDama  :: Bool,
    posX    :: Int,
    posY    :: Int
  } deriving (Show, Generic)

data Board =
  Board {
    board   :: [Piece]
  } deriving (Show, Generic)

data Game =
  Game {
    gameId :: Int,
    whitePlayer :: Player,
    redPlayer :: Player,
    whiteBoard :: Board,
    redBoard :: Board
  } deriving (Show, Generic)

instance ToJSON Game
instance FromJSON Game

game :: Game
game = Game {
  gameId = 1,
  whitePlayer = Player {
    playerColor = False,
    isPlayerTurn = True
  },
  redPlayer = Player {
    playerColor = True,
    isPlayerTurn = False
  },
  whiteBoard = Board {
    [(False, False, 1, 1), (False, False, 3, 1), (False, False, 5, 1), (False, False, 7, 1), 
    (False, False, 2, 2), (False, False, 4, 2), (False, False, 6, 2), (False, False, 8, 2), 
    (False, False, 1, 3), (False, False, 3, 3), (False, False, 5, 3), (False, False, 7, 3)]
  },
  redBoard = Board {
    [(True, False, 1, 1), (True, False, 3, 1), (True, False, 5, 1), (True, False, 7, 1), 
    (True, False, 2, 2), (True, False, 4, 2), (True, False, 6, 2), (True, False, 8, 2), 
    (True, False, 1, 3), (True, False, 3, 3), (True, False, 5, 3), (True, False, 7, 3)]
  }
}

main = do
  putStrLn "Starting Server..."
  scotty 3000 $ do
    get "/newGame" $ do
      json game





-- data User = User { userId :: Int, userName :: String } deriving (Show, Generic)
-- instance ToJSON User
-- instance FromJSON User

-- bob :: User
-- bob = User { userId = 1, userName = "bob" }

-- jenny :: User
-- jenny = User { userId = 2, userName = "jenny" }

-- allUsers :: [User]
-- allUsers = [bob, jenny]

-- matchesId :: Int -> User -> Bool
-- matchesId id user = userId user == id

-- main = do
--   putStrLn "Starting Server..."
--   scotty 3000 $ do
--     get "/hello/:name" $ do
--         name <- param "name"
--         text ("hello " <> name <> "!")

--     get "/users" $ do
--       json allUsers

--     get "/users/:id" $ do
--       id <- param "id"
--       json (filter (matchesId id) allUsers)
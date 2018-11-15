module Datas where

data Player =
    Player {
        playerColor     :: Bool,    -- False - White player / True - Red player
        isPlayerTurn    :: Bool
    } deriving (Show,Generic)

data Piece =
    Piece {
        color   :: Bool,    -- False - White    / True - Red
        isDama  :: Bool,
        posX    :: Int,
        posY    :: Int
    } deriving (Show,Generic)

data Board =
    Board {
        player  :: Player,
        -- board   :: List Piece
        piece   :: Piece
    } deriving (Show,Generic)

-- type Board = (
--     Player,
--     PlayerTurn,
--     (Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece),
--     (Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece, Piece)
-- )

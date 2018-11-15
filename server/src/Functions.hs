module Functions where

newBoardWhitePlayer :: Board
newBoardWhitePlayer = (
        False,
        False,
        ((True, False, 2, 8), (True, False, 4, 8), (True, False, 6, 8), (True, False, 8, 8), 
        (True, False, 1, 7), (True, False, 3, 7), (True, False, 5, 7), (True, False, 7, 7), 
        (True, False, 2, 6), (True, False, 4, 6), (True, False, 6, 6), (True, False, 8, 6)),
        ((False, False, 1, 3), (False, False, 3, 3), (False, False, 5, 3), (False, False, 7, 3), 
        (False, False, 2, 2), (False, False, 4, 2), (False, False, 6, 2), (False, False, 8, 2), 
        (False, False, 1, 1), (False, False, 3, 1), (False, False, 5, 1), (False, False, 7, 1))
    )

newBoardRedPlayer :: Board
newBoardRedPlayer = (
        True,
        False,
        ((False, False, 2, 8), (False, False, 4, 8), (False, False, 6, 8), (False, False, 8, 8), 
        (False, False, 1, 7), (False, False, 3, 7), (False, False, 5, 7), (False, False, 7, 7), 
        (False, False, 2, 6), (False, False, 4, 6), (False, False, 6, 6), (False, False, 8, 6)),
        ((True, False, 1, 3), (True, False, 3, 3), (True, False, 5, 3), (True, False, 7, 3), 
        (True, False, 2, 2), (True, False, 4, 2), (True, False, 6, 2), (True, False, 8, 2), 
        (True, False, 1, 1), (True, False, 3, 1), (True, False, 5, 1), (True, False, 7, 1))
    )

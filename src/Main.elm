module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html exposing (..)

import Svg
import Svg.Attributes as SvgAtt
import String
import Basics exposing (..)

--model

type alias Square = 
    {positionX: Int
    ,positionY: Int
    ,color: String
    }

--update

--view

generateSquare: (Int,List Int) -> List Square
generateSquare (line_number, collum_array) =
    List.map (\x -> Square ((x)*70) ((line_number)*70)

     (
         if modBy 2 line_number == 0 then
            if modBy 2 x == 0 then
                "black"
            else
                "white"
        else
             if modBy 2 x == 0 then
                "white"
            else
                "black"
     )
    
    ) collum_array

generateBoard: List Square
generateBoard = 
    let
        board_size = [(0,List.range 0 7)
                    ,(1,List.range 0 7)
                    ,(2,List.range 0 7)
                    ,(3,List.range 0 7)
                    ,(4,List.range 0 7)
                    ,(5,List.range 0 7)
                    ,(6,List.range 0 7)
                    ,(7,List.range 0 7)]
    in

    List.concat (List.map generateSquare board_size)

    

showSquare: Square -> Svg.Svg msg
showSquare square =
    Svg.rect
        [SvgAtt.x (String.fromInt square.positionX)
        , SvgAtt.y (String.fromInt square.positionY)
        , SvgAtt.width "70"
        , SvgAtt.height "70"
        , SvgAtt.stroke "black"
        , SvgAtt.fill square.color
        ]
        []

showCanvas: List Square -> Html msg
showCanvas square_list = 
    Svg.svg
        [ SvgAtt.width "1000"
        , SvgAtt.height "1000"
        ]
        (List.map (showSquare) square_list)

main= 
    showCanvas (generateBoard)
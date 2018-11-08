module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Browser
import Browser.Dom exposing (Viewport, getViewport)
import Browser.Events as Events
import Svg
import Svg.Attributes as SvgAtt
import Task
import Html.Events.Extra.Mouse as Mouse



import Json.Decode as D
import Json.Encode exposing (Value)



import String
import Basics exposing (..)

--model

type alias Model = 
    {squares: List Square
    ,pices: List Piece
    }


type alias Square = 
    {id:Int
    ,positionX: Int
    ,positionY: Int
    ,color: String
    ,piece: Maybe Piece
    }

type alias Piece = 
    {id: Int
    ,positionX: Float
    ,positionY: Float
    ,color: String
    ,clicked: Bool
    }

init : flags -> ( Model, Cmd Msg )
init f =
    let
        square_list = (putSquareIds generateBoard)
        piece_list = putPiecesIds (List.map(\x -> Maybe.withDefault (Piece 404 2000 2000 "" False) (x.piece)) square_list)
    in

    (Model square_list piece_list, Cmd.none )

putSquareIds: List Square -> List Square
putSquareIds square_list=
    List.map (\x->
            Square 
                (Tuple.first x) 
                (Tuple.second x).positionX 
                (Tuple.second x).positionY 
                (Tuple.second x).color 
                (Tuple.second x).piece
            )        
    (List.indexedMap Tuple.pair square_list)


putPiecesIds: List Piece -> List Piece
putPiecesIds piece_list=
    List.map (\x->
                Piece 
                    (Tuple.first x) 
                    (Tuple.second x).positionX 
                    (Tuple.second x).positionY 
                    (Tuple.second x).color
                    (Tuple.second x).clicked
            )
    (List.indexedMap Tuple.pair piece_list)


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

generateSquare: (Int,List Int) -> List Square
generateSquare (line_number, collum_array) =
    List.map (\x -> Square 0 ((x)*70) ((line_number)*70)
     ( 
         if modBy 2 line_number == 0 then
            if modBy 2 x == 0 then
                "white"
            else
                "black"
        else
             if modBy 2 x == 0 then
                "black"
            else
                "white"
     ) 
     (
        if (modBy 2 line_number == 0 && modBy 2 x /= 0)||(modBy 2 line_number /= 0 && modBy 2 x == 0) then
            if line_number >= 5 then
                Just (Piece 0 (toFloat ((x)*70)+35) (toFloat ((line_number)*70)+35) "white" False)
            else if line_number < 3 then
                Just (Piece 0 (toFloat ((x)*70)+35) (toFloat ((line_number)*70)+35) "brown" False)
            else
                Maybe.Nothing
        else
            Maybe.Nothing
     )
    
    ) collum_array


--update
type Msg
    = NoOp
    | Message
    | MouseMsg
    | MouseMove ( Float, Float )
    | MouseDownAt ( Float, Float )
    | MouseUp ( Float, Float )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseDownAt t->
            ( Model (generateBoard)(List.map 
            (\x ->
                if ((Tuple.first t) < (x.positionX+20) && (Tuple.first t) > (x.positionX-20) && 
                    (Tuple.second t) < (x.positionY+20) && (Tuple.second t) > (x.positionY-20)) then
                    Piece  x.id x.positionX x.positionY x.color (not x.clicked)
                else
                    x
            )
            model.pices)
            , Cmd.none )
        
        MouseUp t->
            ( Model (generateBoard)(List.map 
            (\x ->
                if ((Tuple.first t) < (x.positionX+20) && (Tuple.first t) > (x.positionX-20) && 
                    (Tuple.second t) < (x.positionY+20) && (Tuple.second t) > (x.positionY-20)) then
                    Piece x.id x.positionX x.positionY x.color (not x.clicked)
                else
                    x
            )
            model.pices)
            , Cmd.none )

        MouseMove t->
            ( Model (generateBoard) (List.map 
            (\x->
                if x.clicked then 
                    Piece x.id (Tuple.first t) (Tuple.second t) x.color x.clicked
                else
                    x        
            )
            model.pices)
            , Cmd.none )
            
        NoOp ->
            ( Model generateBoard ( List.map
            (\x ->
                x
            )
            model.pices)
            , Cmd.none )

        option1 ->
            ( model, Cmd.none )

isInside: Piece -> Square -> Bool
isInside piece square = 
    let
        square_centerX = toFloat (square.positionX + 35)
        square_centerY = toFloat (square.positionY + 35)
    in
    (
    (piece.positionX < (square_centerX +30)) &&
    (piece.positionX > (square_centerX-30)) &&
    (piece.positionY < (square_centerY +30)) &&
    (piece.positionY > (square_centerY-30))
    )


--putPiece: List Square -> Piece -> Piece
--putPiece square_list piece = 
--    List.map()    



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [Events.onClick (D.succeed MouseMsg)]


--view



    

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


showPiece: Piece -> Svg.Svg msg
showPiece piece =
    Svg.circle
        [SvgAtt.cx (String.fromFloat piece.positionX)
        , SvgAtt.cy (String.fromFloat piece.positionY)
        , SvgAtt.r "30"
        , SvgAtt.stroke "black"
        , SvgAtt.fill piece.color
        ]
        []

showCanvas: List Square -> List Piece -> Html msg
showCanvas square_list piece_list = 
    Svg.svg
        [ SvgAtt.width "560"
        , SvgAtt.height "560"
        ]
        (List.append (List.map showSquare square_list) (List.map showPiece piece_list))



view : Model -> Html Msg
view model =
     div[
        Mouse.onDown (\event -> MouseDownAt event.offsetPos)
        ,Mouse.onUp  (\event -> MouseUp event.offsetPos)
        ,Mouse.onMove (\event -> MouseMove event.offsetPos)
        ]
        [
        showCanvas model.squares model.pices
        ]

main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
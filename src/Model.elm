module Model exposing (Model, init)

import AspectRatios exposing (AspectRatio(..))
import Calculate exposing (heightFromWidth)
import PixelAspectRatio exposing (PAR(..))


type alias Model =
    { aspectRatio : AspectRatio
    , height : Maybe Float
    , width : Maybe Float
    , par : PAR
    , helpPanelOpen : Bool
    }


init : ( Model, Cmd msg )
init =
    let
        ratio =
            HD

        w =
            800

        par =
            Square
    in
    ( { aspectRatio = ratio
      , width = Just w
      , height = Just <| heightFromWidth ratio par w
      , par = par
      , helpPanelOpen = False
      }
    , Cmd.none
    )

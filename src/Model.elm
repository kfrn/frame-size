module Model exposing (Model, init)

import AspectRatios exposing (AspectRatio(..))
import Calculate exposing (heightFromWidth)
import PixelAspectRatio exposing (PAR(..))


type alias Model =
    { aspectRatio : AspectRatio
    , height : Float
    , width : Float
    , par : PAR
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
      , width = w
      , height = w |> heightFromWidth ratio par
      , par = par
      }
    , Cmd.none
    )

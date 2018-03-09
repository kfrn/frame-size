module Model exposing (Model, init)

import AspectRatios exposing (AspectRatio(..))
import Calculate exposing (heightFromWidth)


type alias Model =
    { aspectRatio : AspectRatio
    , height : Float
    , width : Float
    }


init : ( Model, Cmd msg )
init =
    let
        ratio =
            HD

        w =
            800
    in
    ( { aspectRatio = ratio
      , width = w
      , height = w |> heightFromWidth ratio
      }
    , Cmd.none
    )

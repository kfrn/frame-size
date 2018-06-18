module Model exposing (Model, init)

import Animation
import Animation.Messenger
import AspectRatios exposing (AspectRatio(..))
import Calculate exposing (heightFromWidth)
import Messages exposing (Msg)
import PixelAspectRatio exposing (PAR(..))


type alias Model =
    { aspectRatio : AspectRatio
    , height : Maybe Float
    , width : Maybe Float
    , par : PAR
    , helpPanelOpen : Bool
    , parStyle : Animation.Messenger.State Msg
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

        style =
            Animation.style [ Animation.opacity 1.0 ]
    in
    ( { aspectRatio = ratio
      , width = Just w
      , height = Just <| heightFromWidth ratio par w
      , par = par
      , helpPanelOpen = False
      , parStyle = style
      }
    , Cmd.none
    )

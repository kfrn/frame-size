module Model exposing (HelpPanel, Model, init)

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
    , helpPanel : HelpPanel
    }


type alias HelpPanel =
    { open : Bool
    , style : Animation.Messenger.State Msg
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

        initStyle =
            Animation.style [ Animation.opacity 1.0 ]
    in
    ( { aspectRatio = ratio
      , width = Just w
      , height = Just <| heightFromWidth ratio par w
      , par = par
      , helpPanel =
            { open = False
            , style = initStyle
            }
      }
    , Cmd.none
    )

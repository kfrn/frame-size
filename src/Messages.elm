module Messages exposing (Msg(..))

import Animation
import AspectRatios exposing (AspectRatio)
import PixelAspectRatio exposing (PAR)


type Msg
    = ChangeAspectRatio AspectRatio
    | UpdateWidth String
    | UpdateHeight String
    | ChangePAR PAR
    | Animate Animation.Msg
    | FadeIn Msg
    | OpenHelpPanel
    | FadeOut Msg
    | CloseHelpPanel
    | NoOp

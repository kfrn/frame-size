module Messages exposing (ElementToStyle(..), Msg(..))

import Animation
import AspectRatios exposing (AspectRatio_UI)
import PixelAspectRatio exposing (PAR)


type ElementToStyle
    = PARHelp


type Msg
    = ChangeAspectRatio AspectRatio_UI
    | UpdateWidth String
    | UpdateHeight String
    | ChangePAR PAR
    | Animate Animation.Msg
    | FadeIn ElementToStyle Msg
    | OpenHelpPanel
    | FadeOut ElementToStyle Msg
    | CloseHelpPanel
    | NoOp

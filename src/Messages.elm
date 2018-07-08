module Messages exposing (ElementToStyle(..), Msg(..))

import Animation
import AspectRatios exposing (AspectRatio)
import PixelAspectRatio exposing (PAR)


type ElementToStyle
    = PARHelp



-- | Ratio


type Msg
    = ChangeAspectRatio AspectRatio
    | UpdateWidth String
    | UpdateHeight String
    | ChangePAR PAR
    | Animate Animation.Msg
    | FadeIn ElementToStyle Msg
    | OpenHelpPanel
    | FadeOut ElementToStyle Msg
    | CloseHelpPanel
    | NoOp

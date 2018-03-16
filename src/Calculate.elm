module Calculate exposing (..)

import AspectRatios exposing (AspectRatio(..))
import PixelAspectRatio exposing (PAR(..), sdHeight, sdWidth)
import Types exposing (..)


heightFromWidth : AspectRatio -> PAR -> (Width -> Height)
heightFromWidth ratio par =
    case ratio of
        Academy ->
            academyHeight

        SD ->
            sdHeight par

        HD ->
            hdHeight

        WidescreenEU ->
            widescreenEUHeight

        Widescreen185 ->
            widescreen185Height

        Widescreen239 ->
            widescreen239Height


widthFromHeight : AspectRatio -> PAR -> (Height -> Width)
widthFromHeight ratio par =
    case ratio of
        Academy ->
            academyWidth

        SD ->
            sdWidth par

        HD ->
            hdWidth

        WidescreenEU ->
            widescreenEUWidth

        Widescreen185 ->
            widescreen185Width

        Widescreen239 ->
            widescreen239Width


academyHeight : Width -> Height
academyHeight width =
    width / 1.375


academyWidth : Height -> Width
academyWidth height =
    height * 1.375


hdHeight : Width -> Height
hdHeight width =
    (width / 16) * 9


hdWidth : Height -> Width
hdWidth height =
    (height / 9) * 16


widescreenEUHeight : Width -> Height
widescreenEUHeight width =
    (width / 5) * 3


widescreenEUWidth : Height -> Width
widescreenEUWidth height =
    (height / 3) * 5


widescreen185Height : Width -> Height
widescreen185Height width =
    width / 1.85


widescreen185Width : Height -> Width
widescreen185Width height =
    height * 1.85


widescreen239Height : Width -> Height
widescreen239Height width =
    width / 2.39


widescreen239Width : Height -> Width
widescreen239Width height =
    height * 2.39

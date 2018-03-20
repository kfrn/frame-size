module PixelAspectRatio exposing (..)

import Types exposing (..)


type PAR
    = Square
    | NTSC
    | PAL


allPARs : List PAR
allPARs =
    [ Square, NTSC, PAL ]


displayNameForPAR : PAR -> String
displayNameForPAR par =
    case par of
        Square ->
            "Square"

        NTSC ->
            "480i (NTSC), 10/11"

        PAL ->
            "576i (PAL), 59/54"


sdWidth : PAR -> Height -> Width
sdWidth par height =
    let
        adjustedHeight =
            height / pixelAspectRatio par
    in
    (adjustedHeight / 3) * 4


sdHeight : PAR -> Width -> Height
sdHeight par width =
    (width / 4) * 3 * pixelAspectRatio par


pixelAspectRatio : PAR -> Float
pixelAspectRatio par =
    case par of
        Square ->
            1.0

        NTSC ->
            10.0 / 11.0

        PAL ->
            59.0 / 54.0

module AspectRatios exposing (..)

import PixelAspectRatio exposing (PAR(..))


type AspectRatio
    = Academy
    | SD PAR
    | HD
    | WidescreenEU
    | Widescreen185
    | Widescreen239


type AspectRatio_UI
    = Academy_UI
    | SD_UI
    | HD_UI
    | WidescreenEU_UI
    | Widescreen185_UI
    | Widescreen239_UI


arToUI : AspectRatio -> AspectRatio_UI
arToUI ar =
    case ar of
        Academy ->
            Academy_UI

        SD _ ->
            SD_UI

        HD ->
            HD_UI

        WidescreenEU ->
            WidescreenEU_UI

        Widescreen185 ->
            Widescreen185_UI

        Widescreen239 ->
            Widescreen239_UI


uiToAR : AspectRatio_UI -> AspectRatio
uiToAR ui =
    case ui of
        Academy_UI ->
            Academy

        SD_UI ->
            SD Square

        HD_UI ->
            HD

        WidescreenEU_UI ->
            WidescreenEU

        Widescreen185_UI ->
            Widescreen185

        Widescreen239_UI ->
            Widescreen239


allAspectRatios : List AspectRatio_UI
allAspectRatios =
    [ Academy_UI, SD_UI, HD_UI, WidescreenEU_UI, Widescreen185_UI, Widescreen239_UI ]


displayNameForAspectRatio : AspectRatio_UI -> String
displayNameForAspectRatio ratio =
    case ratio of
        Academy_UI ->
            "Academy (1.375:1)"

        SD_UI ->
            "SD (4:3)"

        HD_UI ->
            "HD (16:9)"

        WidescreenEU_UI ->
            "5:3"

        Widescreen185_UI ->
            "Widescreen (1.85:1)"

        Widescreen239_UI ->
            "Widescreen (2.39:1)"

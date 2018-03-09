module AspectRatios exposing (..)


type AspectRatio
    = Academy
    | SD
    | HD
    | WidescreenEU
    | Widescreen185
    | Widescreen239


allAspectRatios : List AspectRatio
allAspectRatios =
    [ Academy, SD, HD, WidescreenEU, Widescreen185, Widescreen239 ]


aspectRatioDisplayName : AspectRatio -> String
aspectRatioDisplayName ratio =
    case ratio of
        Academy ->
            "Academy (1.375:1)"

        SD ->
            "SD (4:3)"

        HD ->
            "HD (16:9)"

        WidescreenEU ->
            "5:3"

        Widescreen185 ->
            "Widescreen (1.85:1)"

        Widescreen239 ->
            "Widescreen (2.39:1)"

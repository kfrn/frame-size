module Links exposing (..)

import Html exposing (Html, a, i, span, text)
import Html.Attributes exposing (class, href)


type LinkName
    = Email
    | PARArticle
    | Rec601
    | SourceCode


link : LinkName -> Html msg
link name =
    case name of
        Email ->
            a [ href "mailto:kfnagels@gmail.com" ]
                [ span [ class "icon is-medium" ]
                    [ i [ class "fa fa-envelope" ] []
                    ]
                ]

        PARArticle ->
            a [ href "https://bavc.org/blog/par-sar-and-dar-making-sense-standard-definition-sd-video-pixels" ]
                [ text "Read more here" ]

        Rec601 ->
            a [ href "https://en.wikipedia.org/wiki/Rec._601" ]
                [ text "Rec.601" ]

        SourceCode ->
            a [ href "https://github.com/kfrn/frame-size" ]
                [ span [ class "icon" ]
                    [ i [ class "fa fa-github" ] []
                    ]
                ]

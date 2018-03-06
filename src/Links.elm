module Links exposing (..)

import Html exposing (Html, a, i, span, text)
import Html.Attributes exposing (class, href)


type LinkName
    = Email
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

        SourceCode ->
            a [ href "#" ]
                [ span [ class "icon" ]
                    [ i [ class "fa fa-github" ] []
                    ]
                ]

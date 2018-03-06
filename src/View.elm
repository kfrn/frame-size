module View exposing (view)

import Html exposing (Html, div, em, h1, i, nav, p, span, text)
import Html.Attributes exposing (attribute, class, id)
import Links exposing (LinkName(..), link)
import Model exposing (Model)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ div [ id "content" ]
            [ navbar
            , pageContent
            , footer
            ]
        ]


navbar : Html Msg
navbar =
    nav [ class "navbar", attribute "role" "navigation" ]
        [ div [ class "navbar-brand" ]
            [ div [ class "navbar-item" ]
                [ p [ class "title" ]
                    [ span [ class "icon" ] [ i [ class "fa fa-film" ] [] ]
                    , span [ class "app-title" ] [ text "title" ]
                    ]
                ]
            , div [ class "navbar-item app-tagline" ]
                [ p [ class "is-size-6" ] [ em [] [ text "tagline goes here" ] ]
                ]
            ]
        ]


footer : Html Msg
footer =
    div [ class "level app-footer" ]
        [ div [ class "level-left left-offset" ] [ text "By Katherine Nagels" ]
        , div [ class "is-size-6 right-offset" ] [ link Email, link SourceCode ]
        ]


pageContent : Html Msg
pageContent =
    div [ id "main-content" ] [ text "page content will go here!" ]

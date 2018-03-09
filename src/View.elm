module View exposing (view)

import AspectRatios exposing (allAspectRatios, aspectRatioDisplayName)
import Html exposing (Html, div, em, h1, i, input, nav, p, span, text)
import Html.Attributes exposing (attribute, class, id, placeholder, type_, value)
import Html.Events exposing (onInput)
import Links exposing (LinkName(..), link)
import Model exposing (Model)
import Round
import Update exposing (Msg(..))
import ViewHelpers exposing (renderSelect)


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ div [ id "content" ]
            [ navbar
            , pageContent model
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
                    , span [ class "app-title" ] [ text "aspect ratio" ]
                    ]
                ]
            , div [ class "navbar-item app-tagline" ]
                [ p [ class "is-size-6" ] [ em [] [ text "calculate frame size here!" ] ]
                ]
            ]
        ]


footer : Html Msg
footer =
    div [ class "level app-footer" ]
        [ div [ class "level-left left-offset" ] [ text "By Katherine Nagels" ]
        , div [ class "is-size-6 right-offset" ] [ link Email, link SourceCode ]
        ]


pageContent : Model -> Html Msg
pageContent model =
    div [ id "main-content" ]
        [ calculator model
        , div [] [ text "image will go here" ]
        ]


calculator : Model -> Html Msg
calculator model =
    div [ id "calculator" ]
        [ renderSelect model.aspectRatio ChangeAspectRatio aspectRatioDisplayName allAspectRatios
        , createInput model.width UpdateWidth
        , createInput model.height UpdateHeight
        , div [] [ text <| "current AR is: " ++ toString model.aspectRatio ]
        , div [] [ text <| "current width is: " ++ toString model.width ]
        , div [] [ text <| "current height is: " ++ toString model.height ]
        ]


createInput : Float -> (String -> Msg) -> Html Msg
createInput val message =
    let
        roundNumber r =
            -- TODO: improve this? There must be a method to check this
            r == (toFloat <| floor r)

        numForDisplay =
            if roundNumber val then
                toString val
            else
                Round.round 2 val
    in
    input
        [ class "input"
        , type_ "number"
        , placeholder numForDisplay
        , onInput message

        -- , value numForDisplay
        ]
        []

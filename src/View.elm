module View exposing (view)

import AspectRatios exposing (AspectRatio(..), allAspectRatios, aspectRatioDisplayName)
import Html exposing (Html, div, em, h1, i, img, input, label, nav, p, span, text)
import Html.Attributes exposing (attribute, class, id, placeholder, src, type_, value)
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
                [ p [ class "is-size-6" ] [ em [] [ text "calculate frame sizes" ] ]
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
        , referenceImage model.aspectRatio
        , div [] [ text <| "current width is: " ++ toString model.width ]
        , div [] [ text <| "current height is: " ++ toString model.height ]
        ]


calculator : Model -> Html Msg
calculator model =
    div [ id "calculator" ]
        [ selectAspectRatio model.aspectRatio
        , inputFields model
        ]


selectAspectRatio : AspectRatio -> Html Msg
selectAspectRatio currentAR =
    div [ id "select-aspect-ratio" ]
        [ div [ class "field is-horizontal" ]
            [ div [ class "field-label is-normal" ]
                [ label [] [ text "Choose aspect ratio: " ]
                ]
            , div [ class "field-body" ]
                [ renderSelect currentAR ChangeAspectRatio aspectRatioDisplayName allAspectRatios ]
            ]
        ]


inputFields : Model -> Html Msg
inputFields model =
    div [ id "number-inputs" ]
        [ div [ class "field is-horizontal" ]
            [ div [ class "field-label is-normal" ]
                [ label [] [ text "Height: " ]
                ]
            , div [ class "field-body" ]
                [ createInput model.width UpdateWidth ]
            ]
        , div [ class "field is-horizontal" ]
            [ div [ class "field-label is-normal" ]
                [ label [] [ text "Width: " ]
                ]
            , div [ class "field-body" ]
                [ createInput model.height UpdateHeight ]
            ]
        ]


createInput : Float -> (String -> Msg) -> Html Msg
createInput val message =
    let
        roundNumber r =
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


referenceImage : AspectRatio -> Html Msg
referenceImage ratio =
    let
        imgSrc =
            "/images/prince_guitar_" ++ namePart ++ ".jpg"

        namePart =
            case ratio of
                Academy ->
                    "Academy"

                SD ->
                    "4_3"

                HD ->
                    "16_9"

                WidescreenEU ->
                    "5_3"

                Widescreen185 ->
                    "1-85_1"

                Widescreen239 ->
                    "Scope_2-39_1"
    in
    div [ id "reference-image" ]
        [ img [ src imgSrc ] []
        ]

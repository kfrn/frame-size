module View exposing (view)

import Animation
import Animation.Messenger
import AspectRatios exposing (AspectRatio(..), allAspectRatios, displayNameForAspectRatio)
import Html exposing (Html, b, button, div, em, h1, i, img, input, label, nav, p, span, text)
import Html.Attributes exposing (attribute, class, id, placeholder, src, step, type_, value)
import Html.Events exposing (onClick, onInput)
import Links exposing (LinkName(..), link)
import Messages exposing (ElementToStyle(..), Msg(..))
import Model exposing (Model)
import PixelAspectRatio exposing (..)
import Round
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
                    , span [ class "app-title" ] [ text "frame size" ]
                    ]
                ]
            , div [ class "navbar-item app-tagline" ]
                [ p [ class "is-size-6" ] [ em [] [ text "calculate per aspect ratio" ] ]
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
        [ calculator model, referenceImage model.aspectRatio ]


calculator : Model -> Html Msg
calculator model =
    div [ id "calculator" ]
        [ selectRatios model
        , inputFields model
        ]


selectRatios : Model -> Html Msg
selectRatios model =
    div []
        [ selectAspectRatio model.aspectRatio
        , selectPAR model
        ]


selectAspectRatio : AspectRatio -> Html Msg
selectAspectRatio currentAR =
    div [ class "select-ratio" ]
        [ div [ class "field is-horizontal" ]
            [ div [ class "field-label is-normal" ]
                [ label [] [ text "Choose aspect ratio: " ]
                ]
            , div [ class "field-body" ]
                [ renderSelect currentAR ChangeAspectRatio displayNameForAspectRatio allAspectRatios ]
            ]
        ]


selectPAR : Model -> Html Msg
selectPAR model =
    let
        ( msg, iconClass ) =
            case model.helpPanel.open of
                False ->
                    ( FadeIn PARHelp OpenHelpPanel, "fa-question-circle" )

                True ->
                    ( FadeOut PARHelp CloseHelpPanel, "fa-caret-up" )

        parSelect =
            div [ class "field is-horizontal" ]
                [ div [ class "field-label is-normal" ]
                    [ label [] [ text "Choose a pixel aspect ratio: " ]
                    ]
                , div [ class "field-body" ]
                    [ renderSelect model.par ChangePAR displayNameForPAR allPARs
                    , button
                        [ class "button", id "par-help", onClick msg ]
                        [ span [ class "icon" ] [ i [ class <| "fa " ++ iconClass ] [] ] ]
                    ]
                ]
    in
    case model.aspectRatio of
        SD ->
            div []
                [ div [ id "select-par", class "select-ratio" ] [ parSelect ]
                , div [] [ helpPanel model.helpPanel.open model.helpPanel.style ]
                ]

        _ ->
            div [] []


helpPanel : Bool -> Animation.Messenger.State Msg -> Html Msg
helpPanel panelOpen style =
    case panelOpen of
        True ->
            div (Animation.render style ++ [ id "help-panel" ])
                [ p []
                    [ p [] [ b [] [ text "Wait - non-square pixels?" ] ]
                    , p []
                        [ text "SD video pixels are generally not square. "
                        , link PARArticle
                        , text "."
                        ]
                    ]
                , p []
                    [ p [] [ b [] [ text "Why aren't I seeing 720x576 (for 576i) or 720x480 (for 480i)?" ] ]
                    , p []
                        [ link Rec601
                        , text " specifies a sampling rate of 13.5 MHz per video scanline, which actually yields ~703-704 ‘active’ pixels for each scanline. In practice, 720 (or sometimes 704) pixels are captured, allowing for some headroom."
                        ]
                    ]
                ]

        False ->
            div [] []


inputFields : Model -> Html Msg
inputFields model =
    div [ id "number-inputs" ]
        [ div [ class "field is-horizontal" ]
            [ div [ class "field-label is-normal" ]
                [ label [] [ text "Width: " ]
                ]
            , div [ class "field-body" ]
                [ createInput model.width UpdateWidth ]
            ]
        , div [ class "field is-horizontal" ]
            [ div [ class "field-label is-normal" ]
                [ label [] [ text "Height: " ]
                ]
            , div [ class "field-body" ]
                [ createInput model.height UpdateHeight ]
            ]
        ]


createInput : Maybe Float -> (String -> Msg) -> Html Msg
createInput mVal message =
    let
        roundNumber num =
            num == (toFloat <| floor num)

        oneDecimalPlace num =
            toString num == Round.round 1 num

        numForDisplay val =
            if roundNumber val then
                toString val
            else if oneDecimalPlace val then
                Round.round 1 val
            else
                Round.round 2 val

        ( inputValue, placeholderText ) =
            case mVal of
                Just value ->
                    ( numForDisplay value, numForDisplay value )

                Nothing ->
                    ( "", "Enter a num" )
    in
    input
        [ class "input"
        , type_ "number"
        , placeholder placeholderText
        , step "0.01"
        , onInput message
        , value inputValue
        ]
        []


referenceImage : AspectRatio -> Html Msg
referenceImage ratio =
    let
        imgSrc =
            "%PUBLIC_URL%/images/prince_guitar_" ++ namePart ++ ".jpg"

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

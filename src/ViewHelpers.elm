module ViewHelpers exposing (..)

import Html exposing (Html, div, option, select, text)
import Html.Attributes exposing (class, selected)
import Html.Events exposing (on)
import Json.Decode as Json
import List.Extra as ListX
import Messages exposing (Msg(..))


renderSelect : a -> (a -> Msg) -> (a -> String) -> List a -> Html Msg
renderSelect selectedOption message makeOptionName options =
    let
        makeOptionTag opt =
            option
                [ selected <| selectedOption == opt ]
                [ text <| makeOptionName opt ]

        displayNameToMsg displayName =
            case ListX.find (\item -> makeOptionName item == displayName) options of
                Just opt ->
                    message opt

                Nothing ->
                    NoOp
    in
    div [ class "select" ]
        [ select [ onChange displayNameToMsg ] (List.map makeOptionTag options)
        ]


onChange : (String -> msg) -> Html.Attribute msg
onChange makeMessage =
    on "change" (Json.map makeMessage Html.Events.targetValue)

module Update exposing (Msg(..), update)

import AspectRatios exposing (AspectRatio)
import Calculate exposing (heightFromWidth, widthFromHeight)
import Model exposing (Model)


type Msg
    = ChangeAspectRatio AspectRatio
    | UpdateWidth String
    | UpdateHeight String
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeAspectRatio ratio ->
            let
                newHeight =
                    model.width |> heightFromWidth ratio

                newModel =
                    { model | aspectRatio = ratio, height = newHeight }
            in
            ( newModel, Cmd.none )

        UpdateWidth w ->
            case String.toFloat w of
                Ok width ->
                    let
                        newHeight =
                            width |> heightFromWidth model.aspectRatio

                        newModel =
                            { model | width = width, height = newHeight }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        UpdateHeight h ->
            case String.toFloat h of
                Ok height ->
                    let
                        newWidth =
                            height |> widthFromHeight model.aspectRatio

                        newModel =
                            { model | height = height, width = newWidth }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

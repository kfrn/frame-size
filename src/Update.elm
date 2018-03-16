module Update exposing (Msg(..), update)

import AspectRatios exposing (AspectRatio(..))
import Calculate exposing (heightFromWidth, widthFromHeight)
import Model exposing (Model)
import PixelAspectRatio exposing (PAR(..))


type Msg
    = ChangeAspectRatio AspectRatio
    | UpdateWidth String
    | UpdateHeight String
    | ChangePAR PAR
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeAspectRatio newRatio ->
            let
                newPAR =
                    case newRatio of
                        SD ->
                            model.par

                        _ ->
                            Square

                newHeight =
                    model.width |> heightFromWidth newRatio newPAR

                newModel =
                    { model | aspectRatio = newRatio, height = newHeight, par = newPAR }
            in
            ( newModel, Cmd.none )

        UpdateWidth w ->
            case String.toFloat w of
                Ok width ->
                    let
                        newHeight =
                            width |> heightFromWidth model.aspectRatio model.par

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
                            height |> widthFromHeight model.aspectRatio model.par

                        newModel =
                            { model | height = height, width = newWidth }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        ChangePAR newPAR ->
            let
                newHeight =
                    model.width |> heightFromWidth model.aspectRatio newPAR

                newModel =
                    { model | par = newPAR, height = newHeight }
            in
            ( newModel, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

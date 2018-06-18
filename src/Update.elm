module Update exposing (update)

import Animation
import Animation.Messenger
import AspectRatios exposing (AspectRatio(..))
import Calculate exposing (heightFromWidth, widthFromHeight)
import Messages exposing (Msg(..))
import Model exposing (Model)
import PixelAspectRatio exposing (PAR(..))


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
                    model.width
                        |> Maybe.andThen
                            (\w -> Just <| heightFromWidth newRatio newPAR w)

                newModel =
                    { model | aspectRatio = newRatio, height = newHeight, par = newPAR }
            in
            ( newModel, Cmd.none )

        UpdateWidth w ->
            case String.toFloat w of
                Ok width ->
                    let
                        newHeight =
                            Just <| heightFromWidth model.aspectRatio model.par width

                        newModel =
                            { model | width = Just width, height = newHeight }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( unsetDimensions model, Cmd.none )

        UpdateHeight h ->
            case String.toFloat h of
                Ok height ->
                    let
                        newWidth =
                            Just <| widthFromHeight model.aspectRatio model.par height

                        newModel =
                            { model | height = Just height, width = newWidth }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( unsetDimensions model, Cmd.none )

        ChangePAR newPAR ->
            let
                newWidth =
                    model.height
                        |> Maybe.andThen
                            (\h -> Just <| widthFromHeight model.aspectRatio newPAR h)

                newModel =
                    { model | par = newPAR, width = newWidth }
            in
            ( newModel, Cmd.none )

        Animate animMsg ->
            let
                ( newStyle, cmd ) =
                    Animation.Messenger.update animMsg model.parStyle
            in
            ( { model | parStyle = newStyle }, cmd )

        FadeIn msg ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity 1
                            ]
                        , Animation.Messenger.send msg
                        ]
                        model.parStyle
            in
            ( { model | parStyle = newStyle }, Cmd.none )

        OpenHelpPanel ->
            ( { model | helpPanelOpen = True }, Cmd.none )

        FadeOut msg ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity 0
                            ]
                        , Animation.Messenger.send msg
                        ]
                        model.parStyle
            in
            ( { model | parStyle = newStyle }, Cmd.none )

        CloseHelpPanel ->
            ( { model | helpPanelOpen = False }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


unsetDimensions : Model -> Model
unsetDimensions model =
    { model | width = Nothing, height = Nothing }

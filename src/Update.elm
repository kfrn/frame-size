module Update exposing (update)

import Animation
import Animation.Messenger
import AspectRatios exposing (AspectRatio(..), uiToAR)
import Calculate exposing (heightFromWidth, widthFromHeight)
import Messages exposing (ElementToStyle(..), Msg(..))
import Model exposing (HelpPanel, Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeAspectRatio uiRatio ->
            let
                newRatio =
                    uiToAR uiRatio

                newHeight =
                    model.width
                        |> Maybe.andThen
                            (\w -> Just <| heightFromWidth newRatio w)

                newModel =
                    { model | aspectRatio = newRatio, height = newHeight }
            in
            ( newModel, Cmd.none )

        UpdateWidth w ->
            case String.toFloat w of
                Ok width ->
                    let
                        newHeight =
                            Just <| heightFromWidth model.aspectRatio width

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
                            Just <| widthFromHeight model.aspectRatio height

                        newModel =
                            { model | height = Just height, width = newWidth }
                    in
                    ( newModel, Cmd.none )

                Err e ->
                    ( unsetDimensions model, Cmd.none )

        ChangePAR newPAR ->
            let
                newAspectRatio =
                    SD newPAR

                newWidth =
                    model.height
                        |> Maybe.andThen
                            (\h -> Just <| widthFromHeight newAspectRatio h)

                newModel =
                    { model | aspectRatio = newAspectRatio, width = newWidth }
            in
            ( newModel, Cmd.none )

        Animate animMsg ->
            let
                helpPanel =
                    model.helpPanel

                ( newStyle, cmd ) =
                    Animation.Messenger.update animMsg model.helpPanel.style

                newHelpPanel =
                    { helpPanel | style = newStyle }
            in
            ( { model | helpPanel = newHelpPanel }, cmd )

        FadeIn elem msg ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity 1
                            ]
                        , Animation.Messenger.send msg
                        ]
                        (elementToStyle elem model)
            in
            ( setStyle elem newStyle model, Cmd.none )

        OpenHelpPanel ->
            -- TODO: why not toggle this ??
            ( { model | helpPanel = openHelpPanel model.helpPanel }, Cmd.none )

        FadeOut elem msg ->
            let
                newStyle =
                    Animation.interrupt
                        [ Animation.to
                            [ Animation.opacity 0
                            ]
                        , Animation.Messenger.send msg
                        ]
                        (elementToStyle elem model)
            in
            ( setStyle elem newStyle model, Cmd.none )

        CloseHelpPanel ->
            ( { model | helpPanel = closeHelpPanel model.helpPanel }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


unsetDimensions : Model -> Model
unsetDimensions model =
    { model | width = Nothing, height = Nothing }


setStyle : ElementToStyle -> Animation.Messenger.State Msg -> Model -> Model
setStyle elem newStyle model =
    case elem of
        PARHelp ->
            { model | helpPanel = setHelpPanelStyle newStyle model.helpPanel }


setHelpPanelStyle : Animation.Messenger.State Msg -> HelpPanel -> HelpPanel
setHelpPanelStyle newStyle panel =
    { panel | style = newStyle }


elementToStyle : ElementToStyle -> Model -> Animation.Messenger.State Msg
elementToStyle elem model =
    case elem of
        PARHelp ->
            model.helpPanel.style


openHelpPanel : HelpPanel -> HelpPanel
openHelpPanel panel =
    { panel | open = True }


closeHelpPanel : HelpPanel -> HelpPanel
closeHelpPanel panel =
    { panel | open = False }

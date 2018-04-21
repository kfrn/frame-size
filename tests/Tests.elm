module Tests exposing (..)

import Calculate
import Expect
import PixelAspectRatio exposing (PAR(..))
import Test exposing (..)


-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


all : Test
all =
    describe "Aspect ratio calculation" <|
        [ describe "Academy ratio"
            [ test "academyWidth" <|
                let
                    width =
                        Calculate.academyWidth 100
                in
                \_ -> Expect.equal width 137.5
            , test "academyHeight" <|
                let
                    height =
                        Calculate.academyHeight 137.5
                in
                \_ ->
                    Expect.equal height 100
            ]
        , describe "SD"
            [ test "sdWidth with square pixels" <|
                let
                    width =
                        PixelAspectRatio.sdWidth Square 576
                in
                \_ -> Expect.equal width 768
            , test "sdWidth with PAL pixels" <|
                let
                    width =
                        PixelAspectRatio.sdWidth PAL 576
                in
                \_ -> Expect.equal (toFloat <| round width) 703
            , test "sdWidth with NTSC pixels" <|
                let
                    width =
                        PixelAspectRatio.sdWidth NTSC 480
                in
                \_ -> Expect.equal (toFloat <| round width) 704
            , test "sdHeight with square pixels" <|
                let
                    height =
                        PixelAspectRatio.sdHeight Square 768
                in
                \_ ->
                    Expect.equal height 576
            , test "sdHeight with PAL pixels" <|
                let
                    height =
                        PixelAspectRatio.sdHeight PAL 703
                in
                \_ ->
                    Expect.equal (toFloat <| round height) 576
            , test "sdHeight with NTSC pixels" <|
                let
                    height =
                        PixelAspectRatio.sdHeight NTSC 704
                in
                \_ ->
                    Expect.equal (toFloat <| round height) 480
            ]
        , describe "HD"
            [ test "hdWidth" <|
                let
                    width =
                        Calculate.hdWidth 90
                in
                \_ -> Expect.equal width 160
            , test "hdHeight" <|
                let
                    height =
                        Calculate.hdHeight 160
                in
                \_ ->
                    Expect.equal height 90
            ]
        , describe "Widescreen EU"
            [ test "widescreenEUWidth" <|
                let
                    width =
                        Calculate.widescreenEUWidth 300
                in
                \_ -> Expect.equal width 500
            , test "widescreenEUHeight" <|
                let
                    height =
                        Calculate.widescreenEUHeight 250
                in
                \_ ->
                    Expect.equal height 150
            ]
        , describe "Widescreen 185"
            [ test "widescreen185Width" <|
                let
                    width =
                        Calculate.widescreen185Width 100
                in
                \_ -> Expect.equal width 185
            , test "widescreen185Height" <|
                let
                    height =
                        Calculate.widescreen185Height 370
                in
                \_ ->
                    Expect.equal height 200
            ]
        , describe "Widescreen 239"
            [ test "widescreen239Width" <|
                let
                    width =
                        Calculate.widescreen239Width 100
                in
                \_ -> Expect.equal width 239
            , test "widescreen239Height" <|
                let
                    height =
                        Calculate.widescreen239Height 478
                in
                \_ ->
                    Expect.equal height 200
            ]
        ]

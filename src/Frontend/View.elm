module Frontend.View exposing (..)

import Css
import Frontend.Icons as Icons
import Html.Styled as H
import Html.Styled.Attributes as HA
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw


{-| Utility function to help visualize the layout of the page
-}
explainTw : List Css.Style
explainTw =
    [ Tw.outline_2
    , Tw.outline_color Tw.red_500
    , Tw.outline
    ]


prosspectreHeader : H.Html msg
prosspectreHeader =
    H.div
        [ HA.css
            [ Tw.w_80
            , Tw.flex
            , Tw.flex_col
            , Tw.items_center
            , Tw.p_1
            ]
        ]
        [ H.div
            [ HA.css
                [ Tw.w_full
                , Tw.mb_1
                ]
            ]
            [ Icons.prosspectreLogo ]
        , H.div
            [ HA.css
                [ Tw.italic
                , Tw.text_sm
                ]
            ]
            [ H.text "a game by Crazy Cockatoo Games™"
            ]
        ]


asteroidDesignation : String -> H.Html msg
asteroidDesignation designation =
    H.div
        [ HA.css
            [ Tw.w_64
            ]
        ]
        [ Icons.asteroidDesignation designation
        ]


sectorMap : (Int -> Int -> msg) -> H.Html msg
sectorMap fn_message =
    H.div
        [ HA.css
            [ Tw.w_full
            ]
        ]
        [ Icons.sectorMap Tw.neutral_300 fn_message ]


emptyHoleIcon : H.Html msg
emptyHoleIcon =
    Icons.emptyHoleIcon 24 24 Icons.prosspectreColorPalette.empty_hole


possibleSpectireIcon : H.Html msg
possibleSpectireIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.possible_spectrite


confirmedSpectriteIcon : H.Html msg
confirmedSpectriteIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.confirmed_spectrite


spectreFlagIcon : H.Html msg
spectreFlagIcon =
    Icons.spectreFlagIcon 24 24 Icons.prosspectreColorPalette.spectre


realFlagIcon : H.Html msg
realFlagIcon =
    Icons.realFlagIcon 24 24 Icons.prosspectreColorPalette.real_flag


spectreIcon : H.Html msg
spectreIcon =
    Icons.spectreIcon 24 24


numberedHillIcon : Int -> H.Html msg
numberedHillIcon hill_number =
    case hill_number of
        1 ->
            Icons.hill1Icon 24 24 Icons.prosspectreColorPalette.hills

        2 ->
            Icons.hill2Icon 24 24 Icons.prosspectreColorPalette.hills

        3 ->
            Icons.hill3Icon 24 24 Icons.prosspectreColorPalette.hills

        4 ->
            Icons.hill4Icon 24 24 Icons.prosspectreColorPalette.hills

        5 ->
            Icons.hill5Icon 24 24 Icons.prosspectreColorPalette.hills

        6 ->
            Icons.hill6Icon 24 24 Icons.prosspectreColorPalette.hills

        _ ->
            Icons.hill7Icon 24 24 Icons.prosspectreColorPalette.hills


helpIcon : H.Html msg
helpIcon =
    Icons.helpIcon 24 24 Icons.prosspectreColorPalette.help


newGameIcon : H.Html msg
newGameIcon =
    Icons.newGameIcon 24 24 Icons.prosspectreColorPalette.new_game


areaGPRIcon : H.Html msg
areaGPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.areaGPRIcon ]


pointGPRIcon : H.Html msg
pointGPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.pointGPRIcon ]


digIcon : H.Html msg
digIcon =
    Icons.digIcon 24 24 Icons.prosspectreColorPalette.dig


point0GPRIcon : H.Html msg
point0GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point0GPRIcon ]


point1GPRIcon : H.Html msg
point1GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point1GPRIcon ]


point2GPRIcon : H.Html msg
point2GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point2GPRIcon ]


point3GPRIcon : H.Html msg
point3GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point3GPRIcon ]


point4GPRIcon : H.Html msg
point4GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point4GPRIcon ]


point5GPRIcon : H.Html msg
point5GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point5GPRIcon ]


point6GPRIcon : H.Html msg
point6GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point6GPRIcon ]


point7GPRIcon : H.Html msg
point7GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point7GPRIcon ]


point8GPRIcon : H.Html msg
point8GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.point8GPRIcon ]


area0GPRIcon : H.Html msg
area0GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area0GPRIcon ]


area1GPRIcon : H.Html msg
area1GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area1GPRIcon ]


area2GPRIcon : H.Html msg
area2GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area2GPRIcon ]


area3GPRIcon : H.Html msg
area3GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area3GPRIcon ]


area4GPRIcon : H.Html msg
area4GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area4GPRIcon ]


area5GPRIcon : H.Html msg
area5GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area5GPRIcon ]


area6GPRIcon : H.Html msg
area6GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area6GPRIcon ]


area7GPRIcon : H.Html msg
area7GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area7GPRIcon ]


area8GPRIcon : H.Html msg
area8GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area8GPRIcon ]


area9GPRIcon : H.Html msg
area9GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area9GPRIcon ]


area10GPRIcon : H.Html msg
area10GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area10GPRIcon ]


area11GPRIcon : H.Html msg
area11GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area11GPRIcon ]


area12GPRIcon : H.Html msg
area12GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area12GPRIcon ]


area13GPRIcon : H.Html msg
area13GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area13GPRIcon ]


area14GPRIcon : H.Html msg
area14GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area14GPRIcon ]


area15GPRIcon : H.Html msg
area15GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area15GPRIcon ]


area16GPRIcon : H.Html msg
area16GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area16GPRIcon ]


area17GPRIcon : H.Html msg
area17GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area17GPRIcon ]


area18GPRIcon : H.Html msg
area18GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area18GPRIcon ]


area19GPRIcon : H.Html msg
area19GPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.area19GPRIcon ]

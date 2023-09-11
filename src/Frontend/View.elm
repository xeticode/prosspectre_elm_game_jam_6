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

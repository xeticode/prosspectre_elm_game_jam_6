module Frontend.View exposing (..)

import Css
import Dict
import Frontend.Icons as Icons
import Html.Styled as H
import Html.Styled.Attributes as HA
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw
import Types exposing (..)


{-| Utility function to help visualize the layout of the page
-}
explainTw : List Css.Style
explainTw =
    [ Tw.outline_2
    , Tw.outline_color Tw.red_500
    , Tw.outline
    ]


explainTwWithBorderColor : Tw.Color -> List Css.Style
explainTwWithBorderColor color =
    [ Tw.outline_2
    , Tw.outline_color color
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
            [ H.text "Elm Game Jam 6 Edition. Engineering by Dirk Johnson, Copyright Crazy Cockatoo Games™"
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


sectorMap : AxialHexLocations -> (Int -> Int -> msg) -> H.Html msg
sectorMap location_dict fn_message =
    H.div
        [ HA.css
            [ Tw.relative
            , Css.width <| Css.px 384.0
            ]
        ]
        [ H.div
            [ HA.css
                [ Tw.z_0
                , Tw.w_full
                ]
            ]
            [ Icons.sectorMap Tw.neutral_300 fn_message ]
        , H.div
            [ HA.css
                ([ Tw.z_10
                 , Tw.absolute
                 , Tw.w_full
                 , Tw.h_full
                 , Css.top <| Css.px 0.0
                 , Tw.pointer_events_none
                 ]
                    ++ explainTwWithBorderColor Tw.green_500
                )
            ]
            (List.map sectorMapLocationOverlay (Dict.values location_dict))
        ]


sectorMapLocationOverlay : Location -> H.Html msg
sectorMapLocationOverlay ({ sector_position } as location) =
    H.div
        [ HA.css
            [ Tw.absolute
            , Tw.w_10
            , Tw.h_10
            , Tw.flex
            , Tw.flex_row
            , Tw.justify_center
            , Tw.items_center
            , Tw.bg_color Tw.green_500
            , Css.top <| Css.px (Tuple.first sector_position) -- top 156.5 w_10 h_10
            , Css.left <| Css.px (Tuple.second sector_position) -- top 175.0 w_10 h_10
            ]
        ]
        (locationDetailsFromLocation location)


locationDetailsFromLocation : Location -> List (H.Html msg)
locationDetailsFromLocation { state, dig_status, materials } =
    -- 1. Add Digged status icon if digged (adjust contents if necessary)
    -- 1. Gather icons for flag gpr and echo into a list
    -- 3. Based on list size generate the element (0 - 3)
    let
        ( flag_state, gpr_state, echo_state ) =
            state

        starting_icon_elements =
            addIconElementForGPR gpr_state []

        icon_elements =
            case dig_status of
                Undug ->
                    addIconElementForFlag flag_state starting_icon_elements
                        |> addIconElementForEcho echo_state

                Dug ->
                    case materials of
                        SpectriteMaterials ->
                            confirmedSpectriteIcon :: starting_icon_elements

                        _ ->
                            emptyHoleIcon :: starting_icon_elements
    in
    case List.length icon_elements of
        1 ->
            icon_elements

        2 ->
            icon_elements

        3 ->
            icon_elements

        _ ->
            []



-- addDiggedDetailsFromDigStatusAndMaterials : DigStatus -> Materials -> List (H.Html msg) -> List (H.Html msg)
-- addDiggedDetailsFromDigStatusAndMaterials dig_status materials icon_elements =
--     [ H.text "" ]
-- stateDetailsFromLocationState : LocationState -> List (H.Html msg)
-- stateDetailsFromLocationState ( flag_state, gpr_state, echo_state ) =
--     addIconElementForFlag flag_state []
--         |> addIconElementForGPR gpr_state
--         |> addIconElementForEcho echo_state


addIconElementForFlag : LocationFlag -> List (H.Html msg) -> List (H.Html msg)
addIconElementForFlag flag icon_elements =
    case flag of
        RealFlag ->
            realFlagIcon :: icon_elements

        SpectreFlag ->
            spectreFlagIcon :: icon_elements

        _ ->
            icon_elements


addIconElementForGPR : LocationGPR -> List (H.Html msg) -> List (H.Html msg)
addIconElementForGPR gpr icon_elements =
    case gpr of
        AreaGPR reading ->
            areaGPRIconForReading reading :: icon_elements

        PointGPR reading ->
            pointGPRIconForReading reading :: icon_elements

        _ ->
            icon_elements


areaGPRIconForReading : AreaGPRReading -> H.Html msg
areaGPRIconForReading reading =
    case reading of
        AreaGPRReading00 ->
            area0GPRIcon

        AreaGPRReading01 ->
            area1GPRIcon

        AreaGPRReading02 ->
            area2GPRIcon

        AreaGPRReading03 ->
            area3GPRIcon

        AreaGPRReading04 ->
            area4GPRIcon

        AreaGPRReading05 ->
            area5GPRIcon

        AreaGPRReading06 ->
            area6GPRIcon

        AreaGPRReading07 ->
            area7GPRIcon

        AreaGPRReading08 ->
            area8GPRIcon

        AreaGPRReading09 ->
            area9GPRIcon

        AreaGPRReading10 ->
            area10GPRIcon

        AreaGPRReading11 ->
            area11GPRIcon

        AreaGPRReading12 ->
            area12GPRIcon

        AreaGPRReading13 ->
            area13GPRIcon

        AreaGPRReading14 ->
            area14GPRIcon

        AreaGPRReading15 ->
            area15GPRIcon

        AreaGPRReading16 ->
            area16GPRIcon

        AreaGPRReading17 ->
            area17GPRIcon

        AreaGPRReading18 ->
            area18GPRIcon

        AreaGPRReading19 ->
            area19GPRIcon


pointGPRIconForReading : PointGPRReading -> H.Html msg
pointGPRIconForReading reading =
    case reading of
        PointGPRReading00 ->
            point0GPRIcon

        PointGPRReading01 ->
            point1GPRIcon

        PointGPRReading02 ->
            point2GPRIcon

        PointGPRReading03 ->
            point3GPRIcon

        PointGPRReading04 ->
            point4GPRIcon

        PointGPRReading05 ->
            point5GPRIcon

        PointGPRReading06 ->
            point6GPRIcon

        PointGPRReading07 ->
            point7GPRIcon

        PointGPRReading08 ->
            point8GPRIcon


addIconElementForEcho : LocationEcho -> List (H.Html msg) -> List (H.Html msg)
addIconElementForEcho echo icon_elements =
    case echo of
        SpectriteEcho ->
            possibleSpectireIcon :: icon_elements

        NoEcho ->
            icon_elements


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
    Icons.flagIcon 24 24 Icons.prosspectreColorPalette.spectre


realFlagIcon : H.Html msg
realFlagIcon =
    Icons.flagIcon 24 24 Icons.prosspectreColorPalette.real_flag


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

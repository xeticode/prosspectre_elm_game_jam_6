module Frontend.View exposing (..)

import Css
import Dict
import Frontend.Icons as Icons
import Html.Styled as H
import Html.Styled.Attributes as HA
import Html.Styled.Events as HE
import Rules as R
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
                , Tw.flex
                , Tw.flex_col
                , Tw.items_center
                ]
            ]
            [ H.div [] [ H.text "Elm Game Jam 6 Edition" ]
            , H.div [] [ H.text "Design and engineering by Dirk Johnson" ]
            , H.div [] [ H.text "Copyright Crazy Cockatoo Games™" ]
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
                [ Tw.z_10
                , Tw.absolute
                , Tw.w_full
                , Tw.h_full
                , Css.top <| Css.px 0.0
                , Tw.pointer_events_none
                ]
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

            -- , Tw.bg_color Tw.green_500
            , Css.top <| Css.px (Tuple.first sector_position) -- top 156.5 w_10 h_10
            , Css.left <| Css.px (Tuple.second sector_position) -- top 175.0 w_10 h_10
            ]
        ]
        (locationDetailsFromLocation location)


locationDetailsFromLocation : Location -> List (H.Html msg)
locationDetailsFromLocation { state, dig_status, materials, terrain } =
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
            [ terrainIconForTerrain terrain ]


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
        PointGPRReadingX ->
            pointXGPRIcon

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


terrainIconForTerrain : Terrain -> H.Html msg
terrainIconForTerrain terrain =
    case terrain of
        NoTerrain ->
            H.text ""

        PointedPeaks ->
            Icons.pointedPeaksIcon 24 24 Icons.prosspectreColorPalette.hills

        RoundedHills ->
            Icons.roundedHillsIcon 24 24 Icons.prosspectreColorPalette.hills

        MountainPassages ->
            Icons.mountainPassagesIcon 24 24 Icons.prosspectreColorPalette.hills

        SweepingMountains ->
            Icons.sweepingMountainsIcon 24 24 Icons.prosspectreColorPalette.hills

        ImposingPeak ->
            Icons.imposingPeakIcon 24 24 Icons.prosspectreColorPalette.hills

        AgelessMountains ->
            Icons.agelessMountainsIcon 24 24 Icons.prosspectreColorPalette.hills

        CraggyMountains ->
            Icons.craggyMountainsIcon 24 24 Icons.prosspectreColorPalette.hills


toolBar : Tool -> (Tool -> msg) -> H.Html msg
toolBar selected_tool fn_message =
    H.div
        [ HA.css
            [ Tw.flex
            , Tw.flex_row
            , Tw.items_center
            , Tw.gap_2
            ]
        ]
        [ toolBarItem selected_tool fn_message HelpTool helpIcon
        , toolBarItem selected_tool fn_message NewGameTool newGameIcon
        , verticalRulerLeft
        , toolBarItem selected_tool fn_message SpectreFlagTool spectreFlagIcon
        , toolBarItem selected_tool fn_message RealFlagTool realFlagIcon
        , verticalRulerRight
        , toolBarItem selected_tool fn_message AreaGPRTool areaGPRIcon
        , toolBarItem selected_tool fn_message PointGPRTool pointGPRIcon
        , toolBarItem selected_tool fn_message DigTool digIcon
        ]


verticalRulerLeft : H.Html msg
verticalRulerLeft =
    H.hr
        [ HA.css
            [ Tw.w_7
            , Tw.rotate_90
            , Tw.border_color Tw.black
            , Tw.border
            , Tw.rounded_b_full
            ]
        ]
        []


verticalRulerRight : H.Html msg
verticalRulerRight =
    H.hr
        [ HA.css
            [ Tw.w_7
            , Tw.neg_rotate_90
            , Tw.border_color Tw.black
            , Tw.border
            , Tw.rounded_b_full
            ]
        ]
        []


toolBarItem : Tool -> (Tool -> msg) -> Tool -> H.Html msg -> H.Html msg
toolBarItem selected_tool fn_message tool icon =
    H.div
        [ HA.css
            [ Tw.cursor_pointer
            , Tw.py_1
            , Tw.border_y_4
            , Tw.rounded_b_md
            , Tw.rounded_t_md
            , Tw.border_color <|
                if selected_tool == tool then
                    Icons.prosspectreColorPalette.tool_selected

                else
                    Tw.white
            ]
        , HE.onClick (fn_message tool)
        ]
        [ icon ]


scoreboardView : Int -> Int -> Tool -> H.Html msg
scoreboardView hours creds selected_tool =
    H.div
        [ HA.css
            ([ Tw.flex
             , Tw.flex_col
             , Tw.items_center
             , Tw.gap_2
             ]
                ++ (if selected_tool == NoTool then
                        [ Tw.border_2
                        , Tw.rounded_md
                        , Tw.border_color Icons.prosspectreColorPalette.final_score
                        , Tw.p_4
                        ]

                    else
                        []
                   )
            )
        ]
        [ H.div
            [ HA.css
                [ Tw.flex
                , Tw.flex_row
                , Tw.gap_2
                , Tw.items_center
                , Tw.text_3xl
                ]
            ]
            [ H.div
                [ HA.css
                    [ Tw.text_color Icons.prosspectreColorPalette.hours
                    ]
                ]
                [ H.text <| String.fromInt hours ++ " hours" ]
            , verticalRulerLeft
            , H.div
                [ HA.css
                    [ Tw.text_color Icons.prosspectreColorPalette.score
                    ]
                ]
                [ H.text <| String.fromInt creds ++ " ¢reds" ]
            ]
        , if selected_tool == NoTool then
            H.div
                [ HA.css
                    [ Tw.text_2xl
                    , Tw.text_color Icons.prosspectreColorPalette.final_score
                    ]
                ]
                [ H.text "Final Score" ]

          else
            H.div [] []
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
    Icons.flagIcon 24 24 Icons.prosspectreColorPalette.spectre


realFlagIcon : H.Html msg
realFlagIcon =
    Icons.flagIcon 24 24 Icons.prosspectreColorPalette.real_flag


spectreIcon : H.Html msg
spectreIcon =
    Icons.spectreIcon 24 24


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


pointXGPRIcon : H.Html msg
pointXGPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.pointXGPRIcon ]


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


helpView : msg -> List (H.Html msg)
helpView fn_message =
    [ H.div
        [ HE.onClick fn_message
        ]
        [ H.text "Welcome to help. Link to source code." ]
    , spectreIcon
    ]


gameView : Int -> Int -> AxialHexLocations -> (Int -> Int -> msg) -> Tool -> (Tool -> msg) -> List (H.Html msg)
gameView hours creds layout_contents fn_message_int_int selected_tool fn_message_tool =
    [ asteroidDesignation R.randomAsteroidDesignation
    , sectorMap layout_contents fn_message_int_int
    , toolBar selected_tool fn_message_tool
    , scoreboardView hours creds selected_tool
    , spectreIcon
    ]

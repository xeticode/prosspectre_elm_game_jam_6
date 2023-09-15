module Frontend.View exposing (..)

import Css exposing (baseline, help)
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
            , H.div [] [ helpLink "Copyright 2023 Crazy Cockatoo Games™" "https://crazy-cockatoo-games.com" ]
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
        , toolBarItem selected_tool fn_message ClockOutTool clockOutIcon
        , verticalRulerLeft
        , toolBarItem selected_tool fn_message SpectreFlagTool spectreFlagIcon
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
    let
        ( message, outline_attributes ) =
            if selected_tool == NoTool then
                ( H.div
                    [ HA.css
                        [ Tw.text_2xl
                        , Tw.text_color Icons.prosspectreColorPalette.final_score
                        , Tw.text_center
                        ]
                    ]
                    [ H.text <| scorePhraseForReputationHoursAndCreds (R.reputationGivenCreds creds) hours creds ]
                , [ Tw.border_2
                  , Tw.rounded_md
                  , Tw.border_color Icons.prosspectreColorPalette.final_score
                  , Tw.p_4
                  ]
                )

            else
                ( H.div [] [], [] )
    in
    H.div
        [ HA.css
            ([ Tw.flex
             , Tw.flex_col
             , Tw.items_center
             , Tw.gap_2
             ]
                ++ outline_attributes
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
                    [ Tw.text_color Icons.prosspectreColorPalette.creds
                    ]
                ]
                [ H.text <| String.fromInt creds ++ " ¢reds" ]
            ]
        , message
        ]


scorePhraseForReputationHoursAndCreds : ProsSpectreReputation -> Int -> Int -> String
scorePhraseForReputationHoursAndCreds reputation hours creds =
    "Your reputation is " ++ descriptorForProsSpectreReputation reputation ++ " " ++ descriptorForProsSpectreHoursAndCreds hours creds ++ "."


descriptorForProsSpectreReputation : ProsSpectreReputation -> String
descriptorForProsSpectreReputation =
    stringFromProsSpectreReputation


descriptorForProsSpectreHoursAndCreds : Int -> Int -> String
descriptorForProsSpectreHoursAndCreds hours creds =
    if creds <= 0 then
        stringFromProsSpectreEarlyBirdTitle Wannabee

    else if creds <= 5 then
        stringFromProsSpectreEarlyBirdTitle Bulwarker

    else
        case hours of
            1 ->
                stringFromProsSpectreEarlyBirdTitle Molerat

            2 ->
                stringFromProsSpectreEarlyBirdTitle Digger

            3 ->
                stringFromProsSpectreEarlyBirdTitle Hewer

            4 ->
                stringFromProsSpectreEarlyBirdTitle Miner

            5 ->
                stringFromProsSpectreEarlyBirdTitle Haulier

            6 ->
                stringFromProsSpectreEarlyBirdTitle Diggity

            7 ->
                stringFromProsSpectreEarlyBirdTitle PitStomper

            8 ->
                stringFromProsSpectreEarlyBirdTitle Groover

            9 ->
                stringFromProsSpectreEarlyBirdTitle Groundbreaker

            10 ->
                stringFromProsSpectreEarlyBirdTitle Landbaster

            11 ->
                stringFromProsSpectreEarlyBirdTitle MajorMiner

            _ ->
                stringFromProsSpectreEarlyBirdTitle Bulwarker


emptyHoleIcon : H.Html msg
emptyHoleIcon =
    Icons.emptyHoleIcon 24 24 Icons.prosspectreColorPalette.empty_hole


possibleSpectireIcon : H.Html msg
possibleSpectireIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.possible_spectrite


confirmedSpectriteIcon : H.Html msg
confirmedSpectriteIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.confirmed_spectrite


spectriteSmallIcon : H.Html msg
spectriteSmallIcon =
    Icons.spectriteIcon 10 10 Icons.prosspectreColorPalette.confirmed_spectrite


spectralPositiveSmallIcon : H.Html msg
spectralPositiveSmallIcon =
    Icons.spectriteIcon 10 10 Icons.prosspectreColorPalette.possible_spectrite


spectreSmallIcon : H.Html msg
spectreSmallIcon =
    Icons.spectreIcon 12 12


spectreFlagIcon : H.Html msg
spectreFlagIcon =
    Icons.flagIcon 24 24 Icons.prosspectreColorPalette.spectre


spectreFlagSmallIcon : H.Html msg
spectreFlagSmallIcon =
    Icons.flagIcon 10 10 Icons.prosspectreColorPalette.spectre


spectreIcon : H.Html msg
spectreIcon =
    Icons.spectreIcon 24 24


helpIcon : H.Html msg
helpIcon =
    Icons.helpIcon 24 24 Icons.prosspectreColorPalette.help


helpSmallIcon : H.Html msg
helpSmallIcon =
    Icons.helpIcon 10 10 Icons.prosspectreColorPalette.help


newGameIcon : H.Html msg
newGameIcon =
    Icons.newGameIcon 24 24 Icons.prosspectreColorPalette.new_game


newGameSmallIcon : H.Html msg
newGameSmallIcon =
    Icons.newGameIcon 10 10 Icons.prosspectreColorPalette.new_game


areaGPRIcon : H.Html msg
areaGPRIcon =
    H.div
        [ HA.css
            [ Tw.w_8
            , Tw.h_8
            ]
        ]
        [ Icons.areaGPRIcon ]


areaGPRSmallIcon : H.Html msg
areaGPRSmallIcon =
    H.div
        [ HA.css
            [ Tw.w_3
            , Tw.h_3
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


pointGPRSmallIcon : H.Html msg
pointGPRSmallIcon =
    H.div
        [ HA.css
            [ Tw.w_3
            , Tw.h_3
            ]
        ]
        [ Icons.pointGPRIcon ]


digIcon : H.Html msg
digIcon =
    Icons.digIcon 24 24 Icons.prosspectreColorPalette.dig


digSmallIcon : H.Html msg
digSmallIcon =
    Icons.digIcon 10 10 Icons.prosspectreColorPalette.dig


clockOutIcon : H.Html msg
clockOutIcon =
    Icons.clockOutIcon 24 24 Icons.prosspectreColorPalette.clock_out


clockOutSmallIcon : H.Html msg
clockOutSmallIcon =
    Icons.clockOutIcon 14 14 Icons.prosspectreColorPalette.clock_out


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


helpSpectriteSpan : H.Html msg
helpSpectriteSpan =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ spectriteSmallIcon, H.text "spectrite" ]


helpSpectralPositivesSpan : H.Html msg
helpSpectralPositivesSpan =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ spectralPositiveSmallIcon, H.text "spectral positives" ]


helpProsSpectreSpan : H.Html msg
helpProsSpectreSpan =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ H.text "ProsSpectre", spectreSmallIcon ]


helpCred : H.Html msg
helpCred =
    H.span
        [ HA.css
            [ Tw.text_color Icons.prosspectreColorPalette.creds
            , Tw.font_bold
            ]
        ]
        [ H.text "¢red" ]


helpHour : H.Html msg
helpHour =
    H.span
        [ HA.css
            [ Tw.text_color Icons.prosspectreColorPalette.hours
            , Tw.font_bold
            ]
        ]
        [ H.text "hour" ]


helpCreds : H.Html msg
helpCreds =
    H.span
        [ HA.css
            [ Tw.text_color Icons.prosspectreColorPalette.creds
            , Tw.font_bold
            ]
        ]
        [ H.text "¢reds" ]


helpHours : H.Html msg
helpHours =
    H.span
        [ HA.css
            [ Tw.text_color Icons.prosspectreColorPalette.hours
            , Tw.font_bold
            ]
        ]
        [ H.text "hours" ]


helpUndug : H.Html msg
helpUndug =
    H.span
        [ HA.css
            [ Tw.italic
            , Tw.font_bold
            ]
        ]
        [ H.text "undug " ]


helpSpectreFlag : H.Html msg
helpSpectreFlag =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ spectreFlagSmallIcon, H.text "flag" ]


helpAreaGPR : H.Html msg
helpAreaGPR =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ areaGPRSmallIcon, H.text "Area GPR" ]


helpPointGPR : H.Html msg
helpPointGPR =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ pointGPRSmallIcon, H.span [ HA.css [ Tw.ml_1 ] ] [ H.text "Point GPR" ] ]


helpDiggingRig : H.Html msg
helpDiggingRig =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ digSmallIcon, H.text "Digging Rig" ]


helpHelp : H.Html msg
helpHelp =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ helpSmallIcon, H.span [ HA.css [ Tw.ml_1 ] ] [ H.text "Help" ] ]


helpNewGame : H.Html msg
helpNewGame =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ newGameSmallIcon, H.text "New Game" ]


helpClockOut : H.Html msg
helpClockOut =
    H.span
        [ HA.css
            [ Tw.inline_flex
            , Tw.items_baseline
            , Tw.font_bold
            ]
        ]
        [ H.span
            [ HA.css
                [ Tw.relative
                , Tw.top_1
                ]
            ]
            [ clockOutSmallIcon ]
        , H.span [] [ H.text "Clock Out Early" ]
        ]


helpLink : String -> String -> H.Html msg
helpLink display href =
    H.a
        [ HA.href href
        , HA.target "_blank"
        , HA.css
            [ Tw.text_color Icons.prosspectreColorPalette.link
            , Tw.underline
            , Tw.font_bold
            ]
        ]
        [ H.text display ]


helpEmailLink : String -> H.Html msg
helpEmailLink display =
    H.a
        [ HA.href "mailto:prosspectre@crazy-cockatoo.com"
        , HA.target "_blank"
        , HA.css
            [ Tw.text_color Icons.prosspectreColorPalette.link
            , Tw.underline
            , Tw.font_bold
            ]
        ]
        [ H.text display ]


helpPlay : msg -> H.Html msg
helpPlay fn_message =
    H.div
        [ HE.onClick fn_message
        , HA.css
            [ Tw.py_2
            , Tw.px_6
            , Tw.border_2
            , Tw.cursor_pointer
            , Tw.rounded_md
            , Tw.border_color Icons.prosspectreColorPalette.spectre
            , Tw.bg_color Tw.white
            ]
        ]
        [ H.text "Play" ]


helpCCGLogo : H.Html msg
helpCCGLogo =
    H.a
        [ HA.href "https://crazy-cockatoo-games.com"
        , HA.target "_blank"
        ]
        [ H.img
            [ HA.src "/assets/images/ccg-logo-256x384.png"
            , HA.css
                [ Tw.w_5
                , Tw.object_contain
                , Tw.object_center
                ]
            ]
            []
        ]


footer : H.Html msg
footer =
    H.div
        [ HA.css
            [ Tw.flex
            , Tw.flex_row
            , Tw.gap_1
            ]
        ]
        [ spectreIcon
        , helpCCGLogo
        ]


helpView : msg -> List (H.Html msg)
helpView fn_message =
    [ helpPlay fn_message
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Inroduction" ]
    , H.p []
        [ H.text "You are a "
        , helpProsSpectreSpan
        , H.text " – a prospector who searches the asteroid belt for the rare "
        , helpSpectriteSpan
        , H.text
            ". But "
        , helpSpectriteSpan
        , H.text " is illusive, and often sends back an echo to your ground penetrating radar (GPR) that shows up as additional deposits; these are called "
        , helpSpectralPositivesSpan
        , H.text ", and are indistinguishable from the real thing. Using your GPR, and good bit of intuition, your goal is to leave your prospecting site with positive "
        , helpCreds
        , H.text ". However, you only get 12 "
        , helpHours
        , H.text " to prospect, and each time you use your GPR or do a dig, it costs both "
        , helpCreds
        , H.text " and "
        , helpHours
        , H.text ". So, if you want to stay in business, use your resources wisely. Good luck, "
        , helpProsSpectreSpan
        , H.text "!"
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "How to Play" ]
    , H.p []
        [ H.text "You start prospecting with 12 "
        , helpHours
        , H.text " and 5 "
        , helpCreds
        , H.text ". Your goal is to come away with as much "
        , helpCreds
        , H.text " as possible, hopefully more than you started with."
        ]
    , H.p
        [ HA.css
            [ Tw.self_start
            ]
        ]
        [ H.text "You have 2 tools at your disposal:"
        ]
    , H.ol
        [ HA.css
            [ Tw.self_start
            , Tw.list_decimal
            , Tw.ml_5
            ]
        ]
        [ H.li
            [ HA.css
                [ Tw.font_bold
                ]
            ]
            [ H.text "Ground Penetrating Radar (GPR)"
            ]
        , H.li
            []
            [ helpDiggingRig
            ]
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Ground Penetrating Radar (GPR)" ]
    , H.p []
        [ H.text "The GPR has 2 modes: Area and Point. "
        , helpAreaGPR
        , H.text " has a radius of 2 from center. It reports any possible "
        , helpUndug
        , helpSpectriteSpan
        , H.text " deposits it sees within that radius. Some of these deposits are real, and some are "
        , helpSpectralPositivesSpan
        , H.text ". Thankfully, your GPR is smart enough to predict the number of real deposits there are in the total, however, it cannot tell you which of the deposits they are. You will need your "
        , helpPointGPR
        , H.text " to help you determine that."
        ]
    , H.p []
        [ helpPointGPR
        , H.text " is a more focused radar, and therefore cannot be fooled by "
        , helpSpectralPositivesSpan
        , H.text ", however, it can only report how close it is to the nearest "
        , helpUndug
        , H.text "real deposit and not its actual location - "
        , helpSpectriteSpan
        , H.text " is just too illusive."
        ]
    , H.p []
        [ H.text "Whether you use "
        , helpAreaGPR
        , H.text " or "
        , helpPointGPR
        , H.text ", it costs 1 "
        , helpHour
        , H.text " and 1 "
        , helpCred
        , H.text " to use."
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ helpDiggingRig ]
    , H.p []
        [ H.text "Using both your "
        , helpAreaGPR
        , H.text " and "
        , helpPointGPR
        , H.text ", you should be able to pinpoint with some certainty where the real "
        , helpSpectriteSpan
        , H.text " deposits are and use your "
        , helpDiggingRig
        , H.text " to extract them. Digging costs 1 "
        , helpHour
        , H.text " and 2 "
        , helpCreds
        , H.text ". If you dig in the wrong place, you will come up empty handed, having spent the resources for nothing, so use your intuition and pray for a healthy dose of good fortune when you start digging."
        ]
    , H.p []
        [ H.text "Each time you dig, you either uncover a real "
        , helpSpectriteSpan
        , H.text " deposit, or you leave an empty hole. Each "
        , helpSpectriteSpan
        , H.text " deposit is worth 7 "
        , helpCreds
        , H.text ", holes are worth nothing. Note that once you dig in a location, you can no longer use GPR there, so be careful where and when you choose to dig."
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Flagging" ]
    , H.p []
        [ H.text "To help you keep track of where you think the "
        , helpSpectreFlag
        , H.text " are, you may set a purple "
        , helpSpectreFlag
        , H.text " on the propsecting map at any "
        , helpUndug
        , H.text " location. This will help you avoid digging in the wrong place. There are no "
        , helpHours
        , H.text " or "
        , helpCreds
        , H.text " cost to placing or removing a "
        , helpSpectreFlag
        , H.text "."
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Scoring" ]
    , H.p []
        [ H.text "Your have a maximum of 12 "
        , helpHours
        , H.text " to complete your prospecting. However, you can either end your prospecting early by selecting "
        , helpClockOut
        , H.text " , or you can prospect until you run out of time."
        , H.text " Either way, you want to have ended your prospecting with a positive amount of "
        , helpCreds
        , H.text "; the more "
        , helpCreds
        , H.text " you have, the greater your reputation. Should you end your prospecting early with "
        , helpHours
        , H.text " remaining, you will also earn yourself a fitting title."
        ]
    , H.p
        [ HA.css
            [ Tw.self_start
            ]
        ]
        [ H.text "Scoring is as follows:" ]
    , H.ul
        [ HA.css
            [ Tw.self_start
            , Tw.list_disc
            , Tw.ml_5
            ]
        ]
        [ H.li
            []
            [ H.text "End with <1 "
            , helpCreds
            , H.text ": Bankrupt "
            , helpProsSpectreSpan
            ]
        , H.li
            []
            [ H.text "End with 1-5 "
            , helpCreds
            , H.text ": Novice "
            , helpProsSpectreSpan
            ]
        , H.li
            []
            [ H.text "End with 6-15 "
            , helpCreds
            , H.text ": Experienced "
            , helpProsSpectreSpan
            ]
        , H.li
            []
            [ H.text "End with 16-25 "
            , helpCreds
            , H.text ": Expert "
            , helpProsSpectreSpan
            ]
        , H.li
            []
            [ H.text "End with 26-40 "
            , helpCreds
            , H.text ": Master "
            , helpProsSpectreSpan
            ]
        , H.li
            []
            [ H.text "End with 41+ "
            , helpCreds
            , H.text ": Legendary "
            , helpProsSpectreSpan
            ]
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Help" ]
    , H.p []
        [ H.text "If at any time you want to review these instructions, click on "
        , helpHelp
        , H.text ". Or, if you want to contact us directly, feel free to "
        , helpEmailLink "send us an email."
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "New Prospecting Site" ]
    , H.p []
        [ H.text "Should you go bankrupt or you just want to try again, click on "
        , helpNewGame
        , H.text " to head to a new prospecting site."
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Thanks!" ]
    , H.p []
        [ H.text "Thanks to "
        , helpLink "Lue" "https://lue-bird.itch.io/"
        , H.text " for organizing the Elm Game Jam 6 this year. Thanks to all the participants for making this such a fun event. And thanks to the entire Elm community over the years who have helped keep the Elm ecosystem moving forward!"
        ]
    , H.h1
        [ HA.css
            [ Tw.font_bold
            ]
        ]
        [ H.text "Source Code" ]
    , H.p []
        [ helpLink "The source code" "https://github.com/xeticode/prosspectre_elm_game_jam_6"
        , H.text " is available. Have fun! And remember this was just written in one week. ;)"
        ]
    , helpPlay fn_message
    , footer
    ]


gameView : String -> Int -> Int -> AxialHexLocations -> (Int -> Int -> msg) -> Tool -> (Tool -> msg) -> List (H.Html msg)
gameView designation hours creds layout_contents fn_message_int_int selected_tool fn_message_tool =
    [ asteroidDesignation <| designation
    , sectorMap layout_contents fn_message_int_int
    , toolBar selected_tool fn_message_tool
    , scoreboardView hours creds selected_tool
    , footer
    ]

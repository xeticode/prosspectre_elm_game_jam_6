module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict
import Hex
import Hex.Layout as HexL
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , url : Url
    , locations : AxialHexLocations
    , selected_tool : Tool
    , showing_help : Bool
    , creds : Int
    , hours : Int
    }


type Tool
    = NoTool
    | HelpTool
    | NewGameTool
    | SpectreFlagTool
    | RealFlagTool
    | AreaGPRTool
    | PointGPRTool
    | DigTool


type LocationFlag
    = NoFlag
    | SpectreFlag
    | RealFlag


type LocationGPR
    = NoGPR
    | AreaGPR AreaGPRReading
    | PointGPR PointGPRReading


type AreaGPRReading
    = AreaGPRReading00
    | AreaGPRReading01
    | AreaGPRReading02
    | AreaGPRReading03
    | AreaGPRReading04
    | AreaGPRReading05
    | AreaGPRReading06
    | AreaGPRReading07
    | AreaGPRReading08
    | AreaGPRReading09
    | AreaGPRReading10
    | AreaGPRReading11
    | AreaGPRReading12
    | AreaGPRReading13
    | AreaGPRReading14
    | AreaGPRReading15
    | AreaGPRReading16
    | AreaGPRReading17
    | AreaGPRReading18
    | AreaGPRReading19


areaGPRReadingFromInt : Int -> AreaGPRReading
areaGPRReadingFromInt count =
    case count of
        1 ->
            AreaGPRReading01

        2 ->
            AreaGPRReading02

        3 ->
            AreaGPRReading03

        4 ->
            AreaGPRReading04

        5 ->
            AreaGPRReading05

        6 ->
            AreaGPRReading06

        7 ->
            AreaGPRReading07

        8 ->
            AreaGPRReading08

        9 ->
            AreaGPRReading09

        10 ->
            AreaGPRReading10

        11 ->
            AreaGPRReading11

        12 ->
            AreaGPRReading12

        13 ->
            AreaGPRReading13

        14 ->
            AreaGPRReading14

        15 ->
            AreaGPRReading15

        16 ->
            AreaGPRReading16

        17 ->
            AreaGPRReading17

        18 ->
            AreaGPRReading18

        19 ->
            AreaGPRReading19

        _ ->
            AreaGPRReading00


type PointGPRReading
    = PointGPRReadingX
    | PointGPRReading00
    | PointGPRReading01
    | PointGPRReading02
    | PointGPRReading03
    | PointGPRReading04
    | PointGPRReading05
    | PointGPRReading06
    | PointGPRReading07
    | PointGPRReading08


pointGPRReadingFromInt : Int -> PointGPRReading
pointGPRReadingFromInt count =
    case count of
        0 ->
            PointGPRReading00

        1 ->
            PointGPRReading01

        2 ->
            PointGPRReading02

        3 ->
            PointGPRReading03

        4 ->
            PointGPRReading04

        5 ->
            PointGPRReading05

        6 ->
            PointGPRReading06

        7 ->
            PointGPRReading07

        8 ->
            PointGPRReading08

        _ ->
            PointGPRReadingX


type LocationEcho
    = NoEcho
    | SpectriteEcho


type alias LocationState =
    ( LocationFlag, LocationGPR, LocationEcho )


type DigStatus
    = Undug
    | Dug


type Materials
    = NoMaterials
    | SpectriteMaterials


type Terrain
    = NoTerrain
    | PointedPeaks
    | RoundedHills
    | MountainPassages
    | SweepingMountains
    | ImposingPeak
    | AgelessMountains
    | CraggyMountains


terrainList : List Terrain
terrainList =
    [ NoTerrain
    , PointedPeaks
    , RoundedHills
    , MountainPassages
    , SweepingMountains
    , ImposingPeak
    , AgelessMountains
    , CraggyMountains
    ]


type alias Location =
    { axial_hex_index : AxialHexIndex
    , sector_position : HexL.Point
    , state : LocationState
    , dig_status : DigStatus
    , materials : Materials
    , terrain : Terrain
    }


type Action
    = ActionDoNothing
    | ActionDig Location
    | ActionClearFlag Location
    | ActionSetSpectreFlag Location
    | ActionSetRealFlag Location
    | AreaGPRAction Location
    | PointGPRAction Location


type alias AxialHexIndex =
    -- col (q) row (r)
    ( Int, Int )


axialHexIndexFromHex : Hex.Hex -> AxialHexIndex
axialHexIndexFromHex hex =
    -- TODO I know that I am dealing with Axials here so this is "safe", but I really should write a function for HexLib that is hexToAxial that converts any hex to axial and then I can safely return the axial hex index
    ( Hex.getQ hex, Hex.getR hex )



-- TODO Some of these Axial functions should probably move to Hexlib


type alias AxialHexLocations =
    Dict.Dict AxialHexIndex Location


type ProsSpectreReputation
    = Bankrupt
    | Novice
    | Experienced
    | Expert
    | Master
    | Legendary


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg String
    | MapClick Int Int -- col row
    | ToolClick Tool
    | HelpClose


type alias BackendModel =
    { message : String
    }


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg String


type ToFrontend
    = NoOpToFrontend

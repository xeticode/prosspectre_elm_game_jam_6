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
    , layout : HexL.Layout
    , layout_contents : AxialHexLocations
    , selected_tool : Tool
    , showing_help : Bool
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


type PointGPRReading
    = PointGPRReading00
    | PointGPRReading01
    | PointGPRReading02
    | PointGPRReading03
    | PointGPRReading04
    | PointGPRReading05
    | PointGPRReading06
    | PointGPRReading07
    | PointGPRReading08


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
    { sector_position : HexL.Point
    , state : LocationState
    , dig_status : DigStatus
    , materials : Materials
    , terrain : Terrain
    }


type Action
    = ActionDoNothing
    | ActionDig
    | ActionClearFlag
    | ActionSetSpectreFlag
    | ActionSetRealFlag
    | AreaGPRAction
    | PointGPRAction


type alias AxialHexIndex =
    ( Int, Int )


axialHexIndexFromHex : Hex.Hex -> AxialHexIndex
axialHexIndexFromHex hex =
    -- TODO I know that I am dealing with Axials here so this is "safe", but I really should write a function for HexLib that is hexToAxial that converts any hex to axial and then I can safely return the axial hex index
    ( Hex.getQ hex, Hex.getR hex )



-- TODO Some of these Axial functions should probably move to Hexlib


type alias AxialHexLocations =
    Dict.Dict AxialHexIndex Location


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

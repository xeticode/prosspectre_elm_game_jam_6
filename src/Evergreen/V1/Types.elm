module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V1.Hex.Layout
import Random
import Url


type alias AxialHexIndex =
    ( Int, Int )


type LocationFlag
    = NoFlag
    | SpectreFlag
    | RealFlag


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


type LocationGPR
    = NoGPR
    | AreaGPR AreaGPRReading
    | PointGPR PointGPRReading


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


type alias Location =
    { axial_hex_index : AxialHexIndex
    , sector_position : Evergreen.V1.Hex.Layout.Point
    , state : LocationState
    , dig_status : DigStatus
    , materials : Materials
    , terrain : Terrain
    }


type alias AxialHexLocations =
    Dict.Dict AxialHexIndex Location


type Tool
    = NoTool
    | HelpTool
    | NewGameTool
    | SpectreFlagTool
    | RealFlagTool
    | AreaGPRTool
    | PointGPRTool
    | DigTool


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , url : Url.Url
    , seed : Random.Seed
    , designation : String
    , locations : AxialHexLocations
    , selected_tool : Tool
    , showing_help : Bool
    , creds : Int
    , hours : Int
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOpFrontendMsg String
    | MapClick Int Int
    | ToolClick Tool
    | HelpClose
    | StartGame Random.Seed


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg String


type ToFrontend
    = NoOpToFrontend

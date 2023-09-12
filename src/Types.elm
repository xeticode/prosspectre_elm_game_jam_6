module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict
import Hex.Layout as HexL
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , url : Url
    , layout : HexL.Layout
    , layout_contents : AxialHexLocation
    , selected_tool : Tool
    }


type Tool
    = NoTool
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
    | AreaGPR
    | PointGPR


type LocationEcho
    = NoEcho
    | SpectriteEcho


type LocationState
    = LocationState LocationFlag LocationGPR LocationEcho


type DigStatus
    = NotDigged
    | Digged


type Materials
    = NoMaterials
    | SpectriteMaterials


type alias Location =
    { sector_position : HexL.Point
    , state : LocationState
    , dig_status : DigStatus
    , materials : Materials
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


type alias AxialHexLocation =
    Dict.Dict AxialHexIndex Location


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg String
    | MapClick Int Int -- col row
    | SelectTool Tool


type alias BackendModel =
    { message : String
    }


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg String


type ToFrontend
    = NoOpToFrontend

module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Hex.Layout as HexL
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , url : Url
    , layout : HexL.Layout
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg String
    | MapClick Int Int -- col row


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg String


type ToFrontend
    = NoOpToFrontend

module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict
import Hex
import Hex.Layout as HexL
import Random
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , url : Url
    , seed : Random.Seed
    , designation : String
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
    | ClockOutTool
    | SpectreFlagTool
    | AreaGPRTool
    | PointGPRTool
    | DigTool


type LocationFlag
    = NoFlag
    | SpectreFlag


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


terrain_list : ( Terrain, List Terrain )
terrain_list =
    ( NoTerrain
    , [ PointedPeaks
      , RoundedHills
      , MountainPassages
      , SweepingMountains
      , ImposingPeak
      , AgelessMountains
      , CraggyMountains
      ]
    )


type AsteroidSeries
    = AsteroidSeriesA
    | AsteroidSeriesB
    | AsteroidSeriesC
    | AsteroidSeriesD
    | AsteroidSeriesE
    | AsteroidSeriesF
    | AsteroidSeriesG
    | AsteroidSeriesH
    | AsteroidSeriesI
    | AsteroidSeriesJ
    | AsteroidSeriesK
    | AsteroidSeriesL
    | AsteroidSeriesM
    | AsteroidSeriesN
    | AsteroidSeriesO
    | AsteroidSeriesP
    | AsteroidSeriesQ
    | AsteroidSeriesR
    | AsteroidSeriesS
    | AsteroidSeriesT
    | AsteroidSeriesU
    | AsteroidSeriesV
    | AsteroidSeriesW
    | AsteroidSeriesX
    | AsteroidSeriesY
    | AsteroidSeriesZ


asteroid_series_list : ( AsteroidSeries, List AsteroidSeries )
asteroid_series_list =
    ( AsteroidSeriesA
    , [ AsteroidSeriesB
      , AsteroidSeriesC
      , AsteroidSeriesD
      , AsteroidSeriesE
      , AsteroidSeriesF
      , AsteroidSeriesG
      , AsteroidSeriesH
      , AsteroidSeriesI
      , AsteroidSeriesJ
      , AsteroidSeriesK
      , AsteroidSeriesL
      , AsteroidSeriesM
      , AsteroidSeriesN
      , AsteroidSeriesO
      , AsteroidSeriesP
      , AsteroidSeriesQ
      , AsteroidSeriesR
      , AsteroidSeriesS
      , AsteroidSeriesT
      , AsteroidSeriesU
      , AsteroidSeriesV
      , AsteroidSeriesW
      , AsteroidSeriesX
      , AsteroidSeriesY
      , AsteroidSeriesZ
      ]
    )


stringFromAsteroidSeries : AsteroidSeries -> String
stringFromAsteroidSeries series =
    case series of
        AsteroidSeriesA ->
            "A"

        AsteroidSeriesB ->
            "B"

        AsteroidSeriesC ->
            "C"

        AsteroidSeriesD ->
            "D"

        AsteroidSeriesE ->
            "E"

        AsteroidSeriesF ->
            "F"

        AsteroidSeriesG ->
            "G"

        AsteroidSeriesH ->
            "H"

        AsteroidSeriesI ->
            "I"

        AsteroidSeriesJ ->
            "J"

        AsteroidSeriesK ->
            "K"

        AsteroidSeriesL ->
            "L"

        AsteroidSeriesM ->
            "M"

        AsteroidSeriesN ->
            "N"

        AsteroidSeriesO ->
            "O"

        AsteroidSeriesP ->
            "P"

        AsteroidSeriesQ ->
            "Q"

        AsteroidSeriesR ->
            "R"

        AsteroidSeriesS ->
            "S"

        AsteroidSeriesT ->
            "T"

        AsteroidSeriesU ->
            "U"

        AsteroidSeriesV ->
            "V"

        AsteroidSeriesW ->
            "W"

        AsteroidSeriesX ->
            "X"

        AsteroidSeriesY ->
            "Y"

        AsteroidSeriesZ ->
            "Z"


type AsteroidClass
    = AsteroidClassC
    | AsteroidClassS
    | AsteroidClassM


asteroid_class_list : ( AsteroidClass, List AsteroidClass )
asteroid_class_list =
    ( AsteroidClassC
    , [ AsteroidClassS
      , AsteroidClassM
      ]
    )


stringFromAsteroidClass : AsteroidClass -> String
stringFromAsteroidClass asteroid_class =
    case asteroid_class of
        AsteroidClassC ->
            "C"

        AsteroidClassS ->
            "S"

        AsteroidClassM ->
            "M"


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


stringFromProsSpectreReputation : ProsSpectreReputation -> String
stringFromProsSpectreReputation reputation =
    case reputation of
        Bankrupt ->
            "Bankrupt"

        Novice ->
            "Novice"

        Experienced ->
            "Experienced"

        Expert ->
            "Expert"

        Master ->
            "Master"

        Legendary ->
            "Legendary"


type ProsSpectreEarlyBirdTitle
    = Wannabee
    | Bulwarker
    | Molerat
    | Digger
    | Hewer
    | Miner
    | Haulier
    | Diggity
    | PitStomper
    | Groover
    | Groundbreaker
    | Landbaster
    | MajorMiner


stringFromProsSpectreEarlyBirdTitle : ProsSpectreEarlyBirdTitle -> String
stringFromProsSpectreEarlyBirdTitle title =
    case title of
        Wannabee ->
            "Wannabee"

        Bulwarker ->
            "Bulwarker"

        Molerat ->
            "Molerat"

        Digger ->
            "Digger"

        Hewer ->
            "Hewer"

        Miner ->
            "Miner"

        Haulier ->
            "Haulier"

        Diggity ->
            "Diggity"

        PitStomper ->
            "Pit Stomper"

        Groover ->
            "Groover"

        Groundbreaker ->
            "Groundbreaker"

        Landbaster ->
            "Landbaster"

        MajorMiner ->
            "Major Miner"


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg String
    | MapClick Int Int -- col row
    | ToolClick Tool
    | HelpClose
    | StartGame Random.Seed


type alias BackendModel =
    { message : String
    }


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg String


type ToFrontend
    = NoOpToFrontend

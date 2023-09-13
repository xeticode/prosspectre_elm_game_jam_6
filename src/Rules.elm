module Rules exposing (..)

import Dict
import Hex
import List as L
import List.Extra as LE
import Types exposing (..)


{-| Asteroids are usually classified by 3 types:

  - C-type for "chondrite"
  - S-type for "stony"
  - M-type for "metallic"

Since there are over 1 million documented asteroids in the asteroid belt between Mars and Jupiter, in ProsSpectre, we assume that they are broken up into series of no more than 99,999 asteroids each, starting at A and going to Z, then AA to ZZ, etc.

Thus an asteroid with the designation FM01279 would be the the 1,279th asteroid in the F series, and would be metallic in nature.

Each asteroid is divided up into 1 or more mining sectors which are leased for 12 hours at a time to ProsPectres for mining.

-}
randomAsteroidDesignation : String
randomAsteroidDesignation =
    "FM01279 : Sector 1"



-- SECTION Columns and Rows


{-| The shape of our sectorMap is a hex made up hexes and not a square grid made up of hexes so we need to clamp the column and row values to make sure we cannot reference hexes that are not part of the sectorMap.
-}
min_col : Int
min_col =
    -4


min_col_for_row : Int -> Int
min_col_for_row row =
    -(clampCol (4 + row))


max_col : Int
max_col =
    4


max_col_for_row : Int -> Int
max_col_for_row row =
    clampCol (4 - row)


clampCol : Int -> Int
clampCol col =
    clamp min_col max_col col


min_row : Int
min_row =
    -4


min_row_for_col : Int -> Int
min_row_for_col col =
    -(clampRow (4 + col))


max_row : Int
max_row =
    4


max_row_for_col : Int -> Int
max_row_for_col col =
    clampRow (4 - col)


clampRow : Int -> Int
clampRow row =
    clamp min_row max_row row


axialHexWithColAndRow : Int -> Int -> Hex.Hex
axialHexWithColAndRow col row =
    Hex.AxialHex col row


isHexValid : Hex.Hex -> Bool
isHexValid hex =
    let
        col =
            Hex.getQ hex

        row =
            Hex.getR hex

        col_is_valid =
            col == clampCol col

        row_is_valid =
            row == clampRow row
    in
    col_is_valid
        && row_is_valid
        && (col >= min_col_for_row row)
        && (col <= max_col_for_row row)
        && (row >= min_row_for_col col)
        && (row <= max_row_for_col col)


neighborListFromHexInclusive : Hex.Hex -> List Hex.Hex
neighborListFromHexInclusive hex =
    Hex.createFlatTopNeighborList hex
        |> (::) hex
        |> L.filter isHexValid


neighborListFromHexInclusiveRadius2 : Hex.Hex -> List Hex.Hex
neighborListFromHexInclusiveRadius2 hex =
    -- neighborListFromHexInclusive hex
    --     |> L.concatMap neighborListFromHexInclusive
    --     |> LE.unique
    neighborListFromHexInclusiveWithRadius 2 hex


neighborListFromHexInclusiveWithRadius : Int -> Hex.Hex -> List Hex.Hex
neighborListFromHexInclusiveWithRadius radius hex =
    case max 0 radius of
        0 ->
            [ hex ]

        _ ->
            neighborListFromHexInclusive hex
                |> neighborListFromHexInclusiveWithRadiusHelper (radius - 1)
                |> LE.unique


neighborListFromHexInclusiveWithRadiusHelper : Int -> List Hex.Hex -> List Hex.Hex
neighborListFromHexInclusiveWithRadiusHelper radius hexes =
    case max 0 radius of
        0 ->
            hexes

        _ ->
            neighborListFromHexInclusiveWithRadiusHelper (radius - 1) (L.concatMap neighborListFromHexInclusive hexes)



-- !SECTION
-- SECTION Locations


actionFromToolAtMaybeLocation : Tool -> Maybe Location -> Action
actionFromToolAtMaybeLocation tool m_location =
    -- If the dig_status is Digged then return ActionDoNothing
    -- else If the tool is the DigTool then return ActionDig
    -- else If the tool is one of the flag tools then (If the location flag is the same as the tool then return ActionClearFlag else if the flag tool is the SpectreFlag then return ActionSetSpectreFlag else ActionSetRealFlag)
    -- else If the tool is the AreaGPRTool then if location gpr is not the same as the tool then return AreaGPRAction else return ActionDoNothing
    -- else If the tool is the PointGPRTool then if location gpr is not the same as the tool then return PointGPRAction else return ActionDoNothing
    case m_location of
        Nothing ->
            ActionDoNothing

        Just location ->
            let
                ( loc_flag, loc_gpr, _ ) =
                    location.state
            in
            if location.dig_status == Dug then
                ActionDoNothing

            else if tool == DigTool then
                ActionDig

            else if List.member tool [ SpectreFlagTool, RealFlagTool ] then
                case ( tool, loc_flag ) of
                    ( SpectreFlagTool, SpectreFlag ) ->
                        ActionClearFlag

                    ( RealFlagTool, RealFlag ) ->
                        ActionClearFlag

                    ( SpectreFlagTool, _ ) ->
                        ActionSetSpectreFlag

                    ( RealFlagTool, _ ) ->
                        ActionSetRealFlag

                    _ ->
                        ActionDoNothing

            else if tool == AreaGPRTool then
                case ( tool, loc_gpr ) of
                    ( AreaGPRTool, AreaGPR _ ) ->
                        ActionDoNothing

                    _ ->
                        AreaGPRAction

            else if tool == PointGPRTool then
                case ( tool, loc_gpr ) of
                    ( PointGPRTool, PointGPR _ ) ->
                        ActionDoNothing

                    _ ->
                        PointGPRAction

            else
                ActionDoNothing


hexHasMaterials : Hex.Hex -> AxialHexLocations -> Bool
hexHasMaterials hex locations =
    case Dict.get (axialHexIndexFromHex hex) locations of
        Nothing ->
            False

        Just location ->
            case location.materials of
                NoMaterials ->
                    False

                SpectriteMaterials ->
                    True


newGame : FrontendModel -> FrontendModel
newGame model =
    model



-- !SECTION

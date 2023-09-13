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


axialHexWithAxialHexIndex : AxialHexIndex -> Hex.Hex
axialHexWithAxialHexIndex ( col, row ) =
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


neighborListFromHexesInclusive : List Hex.Hex -> List Hex.Hex
neighborListFromHexesInclusive hexes =
    hexes
        |> L.concatMap neighborListFromHexInclusive
        |> LE.unique


neighborListFromHexInclusiveRadius2 : Hex.Hex -> List Hex.Hex
neighborListFromHexInclusiveRadius2 hex =
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


locationsFromHexes : AxialHexLocations -> List Hex.Hex -> List Location
locationsFromHexes locs hexes =
    hexes
        |> List.map (\hx -> Dict.get (axialHexIndexFromHex hx) locs)
        |> List.filterMap identity



-- !SECTION
-- SECTION Locations


actionFromToolAtLocation : Tool -> Location -> Action
actionFromToolAtLocation tool location =
    -- If the dig_status is Digged then return ActionDoNothing
    -- else If the tool is the DigTool then return ActionDig
    -- else If the tool is one of the flag tools then (If the location flag is the same as the tool then return ActionClearFlag else if the flag tool is the SpectreFlag then return ActionSetSpectreFlag else ActionSetRealFlag)
    -- else If the tool is the AreaGPRTool then if location gpr is not the same as the tool then return AreaGPRAction else return ActionDoNothing
    -- else If the tool is the PointGPRTool then if location gpr is not the same as the tool then return PointGPRAction else return ActionDoNothing
    let
        ( loc_flag, loc_gpr, _ ) =
            location.state
    in
    if location.dig_status == Dug then
        ActionDoNothing

    else if tool == DigTool then
        ActionDig location

    else if List.member tool [ SpectreFlagTool, RealFlagTool ] then
        case ( tool, loc_flag ) of
            ( SpectreFlagTool, SpectreFlag ) ->
                ActionClearFlag location

            ( RealFlagTool, RealFlag ) ->
                ActionClearFlag location

            ( SpectreFlagTool, _ ) ->
                ActionSetSpectreFlag location

            ( RealFlagTool, _ ) ->
                ActionSetRealFlag location

            _ ->
                ActionDoNothing

    else if tool == AreaGPRTool then
        case ( tool, loc_gpr ) of
            ( AreaGPRTool, AreaGPR _ ) ->
                ActionDoNothing

            _ ->
                AreaGPRAction location

    else if tool == PointGPRTool then
        case ( tool, loc_gpr ) of
            ( PointGPRTool, PointGPR _ ) ->
                ActionDoNothing

            _ ->
                PointGPRAction location

    else
        ActionDoNothing


performActionOnModel : Action -> FrontendModel -> FrontendModel
performActionOnModel action model =
    case action of
        ActionDoNothing ->
            model

        ActionDig location ->
            let
                updated_location =
                    { location | dig_status = Dug }

                updated_locations =
                    Dict.insert location.axial_hex_index updated_location model.locations

                model_ =
                    { model | locations = updated_locations }
            in
            payForDigging updated_location model_

        ActionClearFlag location ->
            let
                ( _, gpr_state, echo_state ) =
                    location.state

                updated_location =
                    { location | state = ( NoFlag, gpr_state, echo_state ) }

                updated_locations =
                    Dict.insert location.axial_hex_index updated_location model.locations
            in
            { model | locations = updated_locations }

        ActionSetSpectreFlag location ->
            let
                ( _, gpr_state, echo_state ) =
                    location.state

                updated_location =
                    { location | state = ( SpectreFlag, gpr_state, echo_state ) }

                updated_locations =
                    Dict.insert location.axial_hex_index updated_location model.locations
            in
            { model | locations = updated_locations }

        ActionSetRealFlag location ->
            let
                ( _, gpr_state, echo_state ) =
                    location.state

                updated_location =
                    { location | state = ( RealFlag, gpr_state, echo_state ) }

                updated_locations =
                    Dict.insert location.axial_hex_index updated_location model.locations
            in
            { model | locations = updated_locations }

        AreaGPRAction location ->
            let
                -- 1. gather all those locations with echos along with the reading
                -- 2. update echo state for returned locations
                -- 3. update reading for location
                -- 4. insert updated locations into model
                ( reading, echo_locations ) =
                    performAreaGPRAtLocation location model.locations

                updated_locations =
                    List.map
                        (\loc ->
                            let
                                ( flag_st, gpr_st, _ ) =
                                    loc.state
                            in
                            { loc | state = ( flag_st, gpr_st, SpectriteEcho ) }
                        )
                        echo_locations
                        |> List.foldl (\loc acc -> Dict.insert loc.axial_hex_index loc acc) model.locations

                updated_location =
                    case Dict.get location.axial_hex_index updated_locations of
                        Nothing ->
                            location

                        Just lctn ->
                            let
                                ( flag_state, _, echo_state ) =
                                    lctn.state
                            in
                            { lctn | state = ( flag_state, AreaGPR reading, echo_state ) }

                final_locations =
                    Dict.insert location.axial_hex_index updated_location updated_locations

                model_ =
                    { model | locations = final_locations }
            in
            payForAreaGPR model_

        PointGPRAction location ->
            let
                -- 1. identify distance to nearest spectrite
                -- 2. update reading for location
                -- 3. insert updated location into model
                reading =
                    performPointGPRAtLocation location model.locations

                ( flag_state, _, echo_state ) =
                    location.state

                updated_location =
                    { location | state = ( flag_state, PointGPR reading, echo_state ) }

                updated_locations =
                    Dict.insert location.axial_hex_index updated_location model.locations

                model_ =
                    { model | locations = updated_locations }
            in
            payForPointGPR model_


performAreaGPRAtLocation : Location -> AxialHexLocations -> ( AreaGPRReading, List Location )
performAreaGPRAtLocation loc locs =
    let
        hex =
            axialHexWithAxialHexIndex loc.axial_hex_index

        neighbors =
            locationsFromHexes locs (neighborListFromHexInclusiveRadius2 hex)

        -- neighborListFromHexInclusiveRadius2 hex
        --     |> List.map (\hx -> Dict.get (axialHexIndexFromHex hx) locs)
        --     |> List.filterMap identity
        echo_locs =
            List.filter (\neighbor -> locationHasMaterials neighbor) neighbors

        read =
            areaGPRReadingFromInt (List.length echo_locs)
    in
    ( read, echo_locs )


performPointGPRAtLocation : Location -> AxialHexLocations -> PointGPRReading
performPointGPRAtLocation loc locs =
    let
        ( _, reading ) =
            List.foldl
                (\radius (( hexes, rdng ) as acc) ->
                    if PointGPRReadingX /= rdng then
                        acc

                    else
                        hexes
                            |> locationsFromHexes locs
                            |> List.any (\neighbor -> locationHasMaterials neighbor)
                            |> (\has_materials ->
                                    if has_materials then
                                        radius

                                    else
                                        -1
                               )
                            |> (\i -> ( neighborListFromHexesInclusive hexes, pointGPRReadingFromInt i ))
                )
                ( [ axialHexWithAxialHexIndex loc.axial_hex_index ], PointGPRReadingX )
                (List.range 0 8)
    in
    reading


payForDigging : Location -> FrontendModel -> FrontendModel
payForDigging location model =
    let
        updated_model =
            { model
                | creds = model.creds - 1
                , hours =
                    if locationHasMaterials location then
                        model.hours + 5
                        -- 6 for finding spectrite, -1 for digging

                    else
                        model.hours - 1
            }
    in
    updated_model


payForAreaGPR : FrontendModel -> FrontendModel
payForAreaGPR model =
    let
        updated_model =
            { model
                | creds = model.creds - 1
                , hours = model.hours - 1
            }
    in
    updated_model


payForPointGPR : FrontendModel -> FrontendModel
payForPointGPR model =
    let
        updated_model =
            { model
                | creds = model.creds - 1
                , hours = model.hours - 1
            }
    in
    updated_model


locationHasMaterials : Location -> Bool
locationHasMaterials location =
    case location.materials of
        NoMaterials ->
            False

        SpectriteMaterials ->
            True


newGame : FrontendModel -> FrontendModel
newGame model =
    model



-- !SECTION

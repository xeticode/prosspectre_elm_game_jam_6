module Rules exposing (..)

import Hex


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
min_col : Int -> Int
min_col row =
    -4 - abs row


max_col : Int
max_col =
    4


clampColumn : Int -> Int -> Int
clampColumn col row =
    clamp (min_col row) max_col col


max_row : Int
max_row =
    4


min_row : Int -> Int
min_row col =
    -4 - abs col


clampRow : Int -> Int -> Int
clampRow row col =
    clamp (min_row col) max_row row


axialHexWithColAndRow : Int -> Int -> Hex.Hex
axialHexWithColAndRow col row =
    Hex.AxialHex col row



-- !SECTION

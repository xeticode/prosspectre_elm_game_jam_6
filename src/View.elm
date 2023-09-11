module View exposing (..)

import Css
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw


{-| Utility function to help visualize the layout of the page
-}
explainTw : List Css.Style
explainTw =
    [ Tw.outline_2
    , Tw.outline_color Tw.red_500
    , Tw.outline
    ]

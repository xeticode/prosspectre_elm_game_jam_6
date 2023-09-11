module Frontend.View exposing (..)

import Css
import Frontend.Icons as Icons
import Html.Styled as H
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


emptyHoleIcon : H.Html msg
emptyHoleIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.empty_hole


hillsIcon : H.Html msg
hillsIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.hills


possibleSpectireIcon : H.Html msg
possibleSpectireIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.possible_spectrite


confirmedSpectriteIcon : H.Html msg
confirmedSpectriteIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.confirmed_spectrite


spectreFlagIcon : H.Html msg
spectreFlagIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.spectre_flag


realFlagIcon : H.Html msg
realFlagIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.real_flag


spectreIcon : H.Html msg
spectreIcon =
    Icons.spectriteIcon 24 24 Icons.prosspectreColorPalette.spectre_icon

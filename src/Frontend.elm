module Frontend exposing (app)

import Browser
import Browser.Navigation as Nav
import Css.Global
import Frontend.Icons as Icons
import Frontend.View as V
import Html.Styled as H
import Html.Styled.Attributes as HA
import Lamdera
import Rules as R
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw
import Types exposing (..)
import Url


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    FrontendModel


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , url = url
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        UrlClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )

        NoOpFrontendMsg _ ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


subscriptions : Model -> Sub FrontendMsg
subscriptions _ =
    Sub.none


view : Model -> Browser.Document FrontendMsg
view model =
    { title = "ProsSpectre"
    , body =
        List.map H.toUnstyled
            [ Css.Global.global Tw.globalStyles
            , pageView model
            ]
    }


pageView : Model -> H.Html FrontendMsg
pageView _ =
    let
        _ =
            Debug.log "test color struct" (Icons.colorStructFromTwColor Tw.gray_900)
    in
    H.div
        [ HA.css
            [ Tw.max_w_sm
            , Tw.mx_auto
            , Tw.flex
            , Tw.flex_col
            , Tw.items_center
            , Tw.pt_5
            , Tw.gap_8
            ]
        ]
        [ prosspectreHeader
        , asteroidDesignation R.randomAsteroidDesignation
        , sectorMap
        , V.emptyHoleIcon
        , V.possibleSpectireIcon
        , V.confirmedSpectriteIcon
        , V.spectreFlagIcon
        , V.realFlagIcon
        , V.spectreIcon
        , V.numberedHillIcon 1
        , V.numberedHillIcon 2
        , V.numberedHillIcon 3
        , V.numberedHillIcon 4
        , V.numberedHillIcon 5
        , V.numberedHillIcon 6
        , V.numberedHillIcon 7
        , V.helpIcon
        , V.newGameIcon
        , V.areaGPRIcon
        , V.pointGPRIcon
        , V.digIcon
        , V.point0GPRIcon
        , V.point1GPRIcon
        , V.point2GPRIcon
        , V.point3GPRIcon
        , V.point4GPRIcon
        , V.point5GPRIcon
        , V.point6GPRIcon
        , V.point7GPRIcon
        , V.point8GPRIcon
        , V.area0GPRIcon
        , V.area1GPRIcon
        , V.area2GPRIcon
        , V.area3GPRIcon
        , V.area4GPRIcon
        , V.area5GPRIcon
        , V.area6GPRIcon
        , V.area7GPRIcon
        , V.area8GPRIcon
        , V.area9GPRIcon
        , V.area10GPRIcon
        , V.area11GPRIcon
        , V.area12GPRIcon
        , V.area13GPRIcon
        , V.area14GPRIcon
        , V.area15GPRIcon
        , V.area16GPRIcon
        , V.area17GPRIcon
        , V.area18GPRIcon
        , V.area19GPRIcon
        ]


prosspectreHeader : H.Html FrontendMsg
prosspectreHeader =
    H.div
        [ HA.css
            [ Tw.w_80
            , Tw.flex
            , Tw.flex_col
            , Tw.items_center
            , Tw.p_1
            ]
        ]
        [ H.div
            [ HA.css
                [ Tw.w_full
                , Tw.mb_1
                ]
            ]
            [ Icons.prosspectreLogo ]
        , H.div
            [ HA.css
                [ Tw.italic
                , Tw.text_sm
                ]
            ]
            [ H.text "a game by Crazy Cockatoo Games™"
            ]
        ]


asteroidDesignation : String -> H.Html FrontendMsg
asteroidDesignation designation =
    H.div
        [ HA.css
            [ Tw.w_64
            ]
        ]
        [ Icons.asteroidDesignation designation
        ]


sectorMap : H.Html FrontendMsg
sectorMap =
    H.div
        [ HA.css
            [ Tw.w_full
            ]
        ]
        [ Icons.sectorMap ]

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

        NoOpFrontendMsg message ->
            ( model, Cmd.none )

        MapClick col row ->
            let
                hex =
                    Debug.log "hex" (R.axialHexWithColAndRow col row)
            in
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
        [ V.prosspectreHeader
        , V.asteroidDesignation R.randomAsteroidDesignation
        , V.sectorMap MapClick
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

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
      , message = "Welcome to TESTING! You're looking at the auto-generated base implementation. Check out src/Frontend.elm to start coding!"
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
        , Icons.spectriteIcon 64 64
        ]


prosspectreHeader : H.Html FrontendMsg
prosspectreHeader =
    H.div
        [ HA.css
            [ Tw.w_96
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
                ]
            ]
            [ H.text "a game by Crazy Cockatoo Games™"
            ]
        ]


asteroidDesignation : String -> H.Html FrontendMsg
asteroidDesignation designation =
    H.div
        []
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

module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Css.Global
import Html.Styled as H
import Html.Styled.Attributes as HA
import Icons
import Rules as R
import Tailwind.Theme as Tw
import Tailwind.Utilities as Tw
import Url
import View as V


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }


type alias Flags =
    {}


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model =
            { key = key
            , url = url
            }

        cmd =
            Cmd.none
    in
    ( model, cmd )


type Msg
    = NoOp String
    | ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp _ ->
            ( model, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        ChangedUrl url ->
            ( { model | url = url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "ProsSpectre"
    , body =
        List.map H.toUnstyled
            [ Css.Global.global Tw.globalStyles
            , pageView model
            ]
    }


pageView : Model -> H.Html Msg
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
        ]


prosspectreHeader : H.Html Msg
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


asteroidDesignation : String -> H.Html Msg
asteroidDesignation designation =
    H.div
        []
        [ Icons.asteroidDesignation designation
        ]


sectorMap : H.Html Msg
sectorMap =
    H.div
        [ HA.css
            [ Tw.w_full
            ]
        ]
        [ Icons.sectorMap ]

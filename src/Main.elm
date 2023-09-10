module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Css.Global
import Html.Styled as H
import Html.Styled.Attributes as HA
import Icons
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
            [ Tw.p_6
            , Tw.w_full
            , Tw.flex
            , Tw.flex_col
            ]
        ]
        [ prosspectreHeader ]


prosspectreHeader : H.Html Msg
prosspectreHeader =
    H.div
        [ HA.css
            [ Tw.w_full
            , Tw.flex
            , Tw.flex_row
            , Tw.justify_center
            ]
        ]
        [ H.h1
            [ HA.css
                [ Tw.p_3
                , Tw.bg_color Tw.zinc_300
                , Tw.rounded_full
                , Tw.border_2
                , Tw.border_color Tw.violet_900
                , Tw.flex
                , Tw.flex_row
                , Tw.items_center
                ]
            ]
            [ H.span
                [ HA.css
                    [ Tw.inline_block
                    , Tw.text_4xl
                    , Tw.font_bold
                    , Tw.h_fit
                    ]
                ]
                [ H.text "ProsSpectre" ]
            , H.span
                [ HA.css
                    [ Tw.inline_block
                    ]
                ]
                [ Icons.spectreIcon 32 32 ]
            ]
        ]

module Frontend exposing (app)

import Browser
import Browser.Navigation as Nav
import Css
import Css.Global
import Dict
import Frontend.View as V
import Hex.Layout as HexL
import Html.Styled as H
import Html.Styled.Attributes as HA
import Html.Styled.Events as HE
import Lamdera
import Random
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
    ( R.newModel url key
    , Random.generate StartGame Random.independentSeed
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
                m_location =
                    Dict.get ( col, row ) model.locations

                action =
                    case m_location of
                        Nothing ->
                            ActionDoNothing

                        Just location ->
                            R.actionFromToolAtLocation model.selected_tool location

                model_ =
                    R.performActionOnModel action model
            in
            ( R.updateForEndOfGame model_
            , Cmd.none
            )

        ToolClick tool ->
            let
                model_ =
                    case tool of
                        HelpTool ->
                            { model | showing_help = True }

                        NewGameTool ->
                            R.newGameModel model

                        ClockOutTool ->
                            { model | selected_tool = NoTool }

                        _ ->
                            if model.selected_tool == NoTool then
                                -- If selected tool is NoTool then we have disabled the tools on the toolbar
                                model

                            else
                                { model | selected_tool = tool }
            in
            ( model_, Cmd.none )

        HelpClose ->
            ( { model | showing_help = False }, Cmd.none )

        StartGame seed ->
            let
                model_ =
                    R.newGameModel { model | seed = seed }
            in
            ( { model_ | showing_help = True }, Cmd.none )


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
            [ Css.Global.global
                (Tw.globalStyles
                    ++ [ Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.normal
                            , Css.fontStyle Css.normal
                            , Css.property "src" "url(\"https://prosspectre-elm-game-jam-6.lamdera.app/assets/css/Aspergit.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.lighter
                            , Css.fontStyle Css.normal
                            , Css.property "src" "url(\"https://prosspectre-elm-game-jam-6.lamdera.app/assets/css/Aspergit+Light.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.lighter
                            , Css.fontStyle Css.italic
                            , Css.property "src" "url(\"https://prosspectre-elm-game-jam-6.lamdera.app/assets/css/Aspergit+Light+Italic.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.normal
                            , Css.fontStyle Css.italic
                            , Css.property "src" "url(\"https://prosspectre-elm-game-jam-6.lamdera.app/assets/css/Aspergit+Italic.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.bold
                            , Css.fontStyle Css.normal
                            , Css.property "src" "url(\"https://prosspectre-elm-game-jam-6.lamdera.app/assets/css/Aspergit+Bold.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.bold
                            , Css.fontStyle Css.italic
                            , Css.property "src" "url(\"https://prosspectre-elm-game-jam-6.lamdera.app/assets/css/Aspergit+Bold+Italic.otf\") format(\"opentype\")"
                            ]
                       ]
                )
            , pageView model
            ]
    }


pageView : Model -> H.Html FrontendMsg
pageView model =
    H.div
        [ HA.css
            [ Tw.max_w_sm
            , Tw.mx_auto
            , Tw.flex
            , Tw.flex_col
            , Tw.items_center
            , Tw.pt_5
            , Tw.gap_8
            , Css.fontFamilies [ "aspergit" ]
            ]
        ]
        (V.prosspectreHeader
            :: (if model.showing_help then
                    V.helpView HelpClose

                else
                    V.gameView model.designation model.hours model.creds model.locations MapClick model.selected_tool ToolClick
               )
        )

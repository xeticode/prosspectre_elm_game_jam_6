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
    let
        -- TODO - we should make sure var is accurate
        var : Float
        var =
            49.1066

        locations =
            initLayoutContents
    in
    ( { key = key
      , url = url
      , layout =
            { orientation = HexL.unitFlatTopOrientation
            , size = ( var, var )
            , origin = ( 0, 0 )
            }
      , locations = locations
      , selected_tool = NoTool
      , showing_help = False
      , creds = 5
      , hours = 12
      }
    , Cmd.none
    )


initLayoutContents : AxialHexLocations
initLayoutContents =
    let
        zero_zero_top =
            203.0

        zero_zero_left =
            175.0

        vt =
            46.6

        hz =
            40.25
    in
    Dict.fromList <|
        List.map
            (\( index, point, materials ) ->
                ( index
                , { axial_hex_index = index
                  , sector_position = point
                  , state = ( NoFlag, NoGPR, NoEcho )
                  , dig_status = Undug
                  , materials = materials
                  , terrain = MountainPassages
                  }
                )
            )
            [ -- Col -4
              locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -4, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -4, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -4, 2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -4, 3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -4, 4 )

            -- Col -3
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -3, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -3, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -3, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -3, 2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -3, 3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -3, 4 )

            -- Col -2
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, 2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, 3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -2, 4 )

            -- Col -1
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, -3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, 2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, 3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( -1, 4 )

            -- Col 0
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, -4 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, -3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, 2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, 3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 0, 4 )

            -- Col 1
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, -4 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, -3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, 2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 1, 3 )

            -- Col 2
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, -4 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, -3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, 1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 2, 2 )

            -- Col 3
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 3, -4 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 3, -3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 3, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 3, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 3, 0 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 3, 1 )

            -- Col 4
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 4, -4 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 4, -3 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 4, -2 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 4, -1 )
            , locationDataFromIndex zero_zero_top zero_zero_left vt hz ( 4, 0 )
            ]


locationDataFromIndex : Float -> Float -> Float -> Float -> AxialHexIndex -> ( AxialHexIndex, HexL.Point, Materials )
locationDataFromIndex zz_top zz_left vert horiz ( col, row ) =
    let
        half_vert =
            vert / 2.0
    in
    ( ( col, row ), ( zz_top + (vert * toFloat row) + (half_vert * toFloat col), zz_left + (horiz * toFloat col) ), NoMaterials )


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
            in
            ( R.performActionOnModel action model
            , Cmd.none
            )

        ToolClick tool ->
            let
                model_ =
                    case tool of
                        HelpTool ->
                            { model | showing_help = True }

                        NewGameTool ->
                            R.newGame model

                        _ ->
                            { model | selected_tool = tool }
            in
            ( model_, Cmd.none )

        HelpClose ->
            ( { model | showing_help = False }, Cmd.none )


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
                            , Css.property "src" "url(\"assets/css/Aspergit.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.lighter
                            , Css.fontStyle Css.normal
                            , Css.property "src" "url(\"assets/css/Aspergit Light.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.lighter
                            , Css.fontStyle Css.italic
                            , Css.property "src" "url(\"assets/css/Aspergit Light Italic.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.normal
                            , Css.fontStyle Css.italic
                            , Css.property "src" "url(\"assets/css/Aspergit Italic.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.bold
                            , Css.fontStyle Css.normal
                            , Css.property "src" "url(\"assets/css/Aspergit Bold.otf\") format(\"opentype\")"
                            ]
                       , Css.Global.typeSelector "@font-face"
                            [ Css.property "font-faimly" "aspergit"
                            , Css.fontWeight Css.bold
                            , Css.fontStyle Css.italic
                            , Css.property "src" "url(\"assets/css/Aspergit Bold Italic.otf\") format(\"opentype\")"
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
            ([ Tw.max_w_sm
             , Tw.mx_auto
             , Tw.flex
             , Tw.flex_col
             , Tw.items_center
             , Tw.pt_5
             , Tw.gap_8
             , Css.fontFamilies [ "aspergit" ]
             ]
                ++ V.explainTw
            )
        ]
        (V.prosspectreHeader
            :: (if model.showing_help then
                    V.helpView HelpClose

                else
                    V.gameView model.locations MapClick model.selected_tool ToolClick
               )
        )



-- TODO - have a V.spectreIcon flit across the screen at random intervals
-- Random start loc and random end loc and random duration and use css animation to do it
-- non-clickable
-- PERHAPSE have it start at the spectre in the logo

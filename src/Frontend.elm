module Frontend exposing (app)

import Browser
import Browser.Navigation as Nav
import Css.Global
import Dict
import Frontend.Icons as Icons
import Frontend.View as V
import Hex.Layout as HexL
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
    let
        -- TODO - we should make sure var is accurate
        var : Float
        var =
            49.1066

        layout_contents =
            initLayoutContents
    in
    ( { key = key
      , url = url
      , layout =
            { orientation = HexL.unitFlatTopOrientation
            , size = ( var, var )
            , origin = ( 0, 0 )
            }
      , layout_contents = layout_contents
      , selected_tool = NoTool
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
                , { sector_position = point
                  , state = ( NoFlag, NoGPR, NoEcho )
                  , dig_status = Undug
                  , materials = materials
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
                hex =
                    Debug.log "hex" (R.axialHexWithColAndRow col row)

                _ =
                    Debug.log "hexToPoint" (HexL.hexToPoint model.layout hex)

                nlfh =
                    Debug.log "nlfh" (R.neighborListFromHexInclusive hex)

                nlfhr2 =
                    Debug.log "nlfhr2" (R.neighborListFromHexInclusiveRadius2 hex)

                _ =
                    Debug.log "nlfhr2 length" (List.length nlfhr2)

                m_location_nothing =
                    Debug.log "location_nothing"
                        (Just
                            { sector_position = ( 0.0, 0.0 )
                            , state = ( NoFlag, NoGPR, NoEcho )
                            , dig_status = Undug
                            , materials = NoMaterials
                            }
                        )

                m_location_digged =
                    Debug.log "location_nothing"
                        (Just
                            { sector_position = ( 0.0, 0.0 )
                            , state = ( NoFlag, NoGPR, NoEcho )
                            , dig_status = Dug
                            , materials = NoMaterials
                            }
                        )

                m_location_spectreflag =
                    Debug.log "location_nothing"
                        (Just
                            { sector_position = ( 0.0, 0.0 )
                            , state = ( SpectreFlag, NoGPR, NoEcho )
                            , dig_status = Undug
                            , materials = NoMaterials
                            }
                        )

                m_location_realflag_areagpr =
                    Debug.log "location_nothing"
                        (Just
                            { sector_position = ( 0.0, 0.0 )
                            , state = ( RealFlag, AreaGPR AreaGPRReading07, NoEcho )
                            , dig_status = Undug
                            , materials = NoMaterials
                            }
                        )

                _ =
                    Debug.log "action for Dig Tool at location_nothing" <| R.actionFromToolAtMaybeLocation DigTool m_location_nothing

                _ =
                    Debug.log "action for Dig Tool at location_digged" <| R.actionFromToolAtMaybeLocation DigTool m_location_digged

                _ =
                    Debug.log "action for Point GPR Tool at location_digged" <| R.actionFromToolAtMaybeLocation PointGPRTool m_location_digged

                _ =
                    Debug.log "action for Spectre Flag Tool at location_spectreflag" <| R.actionFromToolAtMaybeLocation SpectreFlagTool m_location_spectreflag

                _ =
                    Debug.log "action for Real Flag Tool at location_spectreflag" <| R.actionFromToolAtMaybeLocation RealFlagTool m_location_spectreflag

                _ =
                    Debug.log "action for Area GPR Tool at location_realflag_areagpr" <| R.actionFromToolAtMaybeLocation AreaGPRTool m_location_realflag_areagpr

                _ =
                    Debug.log "action for Point GPR Tool at location_realflag_areagpr" <| R.actionFromToolAtMaybeLocation PointGPRTool m_location_realflag_areagpr

                _ =
                    Debug.log "action for model selected tool at location_nothing" <| R.actionFromToolAtMaybeLocation model.selected_tool (Dict.get ( col, row ) model.layout_contents)
            in
            ( model, Cmd.none )

        SelectTool tool ->
            let
                tool_ =
                    if tool == model.selected_tool then
                        NoTool

                    else
                        tool
            in
            ( { model | selected_tool = tool_ }, Cmd.none )


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
             ]
                ++ V.explainTw
            )
        ]
        [ V.prosspectreHeader
        , V.asteroidDesignation R.randomAsteroidDesignation
        , V.sectorMap model.layout_contents MapClick
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

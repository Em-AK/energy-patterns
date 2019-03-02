module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, h3, p, img)
import Html.Attributes exposing (src)


---- MODEL ----


type alias Model =
    { peakHours : Int
    , offPeakHours : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { peakHours = 35215, offPeakHours = 17438 }, Cmd.none )


totalConsumption : Model -> Int
totalConsumption model =
    model.peakHours + model.offPeakHours



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


presentConsumption : Int -> String -> String
presentConsumption consumption title =
    title
        ++ " "
        ++ (String.fromInt consumption)
        ++ " kWh"


view : Model -> Html Msg
view model =
    let
        peakHours =
            presentConsumption model.peakHours "Peak"

        offPeakHours =
            presentConsumption model.offPeakHours "Off-peak"

        total =
            presentConsumption (totalConsumption model) "Total"
    in
        div []
            [ h1 [] [ text "Last meter record" ]
            , img [ src "/signal-vs-noise.png" ] []
            , p [] [ text peakHours ]
            , p [] [ text offPeakHours ]
            , h3 [] [ text total ]
            ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

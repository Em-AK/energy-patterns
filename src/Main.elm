module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, h3, p, img)
import Html.Attributes exposing (src)


---- MODEL ----


type alias Metering =
    { peakHoursConsumption : Int
    , offPeakHoursConsumption : Int
    }


init : ( Metering, Cmd Msg )
init =
    ( { peakHoursConsumption = 35215
      , offPeakHoursConsumption = 17438
      }
    , Cmd.none
    )


getConsumption : Metering -> Int
getConsumption m =
    m.peakHoursConsumption + m.offPeakHoursConsumption



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Metering -> ( Metering, Cmd Msg )
update msg metering =
    ( metering, Cmd.none )



---- VIEW ----


presentEnergy : String -> Int -> String
presentEnergy label amount =
    label
        ++ " "
        ++ (String.fromInt amount)
        ++ " kWh"


view : Metering -> Html Msg
view m =
    div []
        [ h1 [] [ text "Last meter record" ]
        , img [ src "/signal-vs-noise.png" ] []
        , p [] [ text (presentEnergy "Peak" m.peakHoursConsumption) ]
        , p [] [ text (presentEnergy "Off-peak" m.offPeakHoursConsumption) ]
        , h3 [] [ text (presentEnergy "Total" (getConsumption m)) ]
        ]



---- PROGRAM ----


main : Program () Metering Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }

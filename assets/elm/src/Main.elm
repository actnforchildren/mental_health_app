import Browser
import Calendar
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)
import Task
import Time
import Time.Extra
import Ports
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscription
    }

-- MODEL

type alias Model =
  {
    calendar : Calendar.Calendar
  }

init : Int -> ( Model, Cmd Msg )
init millis =
  let
    posix = Time.millisToPosix millis
    calendar = Calendar.setPosix posix Calendar.init
  in
  ( Model calendar
  , Cmd.batch [Task.perform CurrentTime Time.now, Task.perform CurrentZone Time.here])


-- UPDATE

type Msg
    = CurrentTime Time.Posix
    | CurrentZone Time.Zone
    | CalendarMsg Calendar.Msg
    | Swipe String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        CurrentTime posix ->
          let
            calendar = Calendar.setCurrentTime posix model.calendar
          in
          ({model | calendar = calendar}, Cmd.none)

        CurrentZone zone ->
          let
            calendar = Calendar.setZone zone model.calendar
          in
          ({model | calendar = calendar}, Cmd.none)

        CalendarMsg calendarMsg ->
          ({ model | calendar = Calendar.update calendarMsg model.calendar }, Cmd.none)

        Swipe direction ->
          case direction of
            "right" ->
              let
                calendar = Calendar.previousMonth model.calendar
              in
              ({model | calendar = calendar}, Cmd.none)

            "left" ->
              let
                calendar = Calendar.nextMonth model.calendar
              in
              ({model | calendar = calendar}, Cmd.none)

            _ -> (model, Cmd.none)

subscription : Model -> Sub Msg
subscription model =
  Sub.batch [ Ports.swipe Swipe ]

-- VIEW

view : Model -> Html Msg
view model =
    div []
      [
        Calendar.view model.calendar |> Html.map CalendarMsg
      ]

module Calendar exposing (..)

import Time
import Time.Extra
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type alias Model =
  { open : Bool
  , currentTime: Time.Posix
  , posix : Time.Posix
  , zone : Time.Zone
  , month : List ( List (Maybe Time.Posix))
  }

type Calendar = Calendar Model

init: Calendar
init =
  Calendar
    { open = False
    , currentTime = Time.millisToPosix 0
    , posix = Time.millisToPosix 0
    , zone = Time.utc
    , month = []
    }

type Msg =
    Toggle
  | NextMonth
  | PreviousMonth

update : Msg -> Calendar -> Calendar
update msg ((Calendar model) as calendar) =
    case msg of
      Toggle -> Calendar ({ model | open = not model.open })
      NextMonth ->
        let
          day = firstNextMonth calendar
          month = daysOfMonth model.zone day
        in
        Calendar {model | month = month }

      PreviousMonth ->
        let
          day = firstPreviousMonth calendar
          month = daysOfMonth model.zone day
        in
        Calendar {model | month = month }

setZone : Time.Zone -> Calendar -> Calendar
setZone zone (Calendar model) =
  let
    month = daysOfMonth zone model.posix
  in
  Calendar {model | zone = zone, month = month }


setPosix : Time.Posix -> Calendar -> Calendar
setPosix posix (Calendar model) =
    let
      month = daysOfMonth model.zone posix
    in
    Calendar {model | posix = posix, month = month }

setCurrentTime : Time.Posix -> Calendar -> Calendar
setCurrentTime posix (Calendar model) =
    Calendar {model | currentTime = posix }

{--
Get the first day of the month and the first day of the next month
e.g 1/01/2018 and 01/02/2018
--}
monthBoundary : Time.Zone -> Time.Posix -> (Time.Posix, Time.Posix)
monthBoundary zone posix =
  let
    year = Time.toYear zone posix
    month = Time.toMonth zone posix
    start = Time.Extra.partsToPosix zone <| Time.Extra.Parts year month 1 0 0 0 0
    end = Time.Extra.add Time.Extra.Month 1 zone start
  in
    (start, end)

firstDayOfMonth : Calendar -> Time.Posix
firstDayOfMonth (Calendar model) =
    let
      dates = List.map (\w -> List.filter (\d -> d /= Nothing) w) model.month
      firstWeek = List.head dates
    in
    case firstWeek of
      Nothing -> model.posix
      Just w -> case List.head w of
        Nothing -> model.posix
        Just d -> case d of
          Nothing -> model.posix
          Just p -> p


currentMonth : Calendar -> String
currentMonth (Calendar model as calendar) =
  let
    firstDay = firstDayOfMonth calendar
  in
    formatMonth <| Time.toMonth model.zone firstDay

currentYear : Calendar -> String
currentYear (Calendar model as calendar) =
  let
    firstDay = firstDayOfMonth calendar
  in
    String.fromInt <| Time.toYear model.zone firstDay

firstNextMonth : Calendar -> Time.Posix
firstNextMonth ((Calendar model) as calendar) =
  let
    current = firstDayOfMonth calendar
  in
  Time.Extra.add Time.Extra.Month 1 model.zone current

firstPreviousMonth : Calendar -> Time.Posix
firstPreviousMonth ((Calendar model) as calendar) =
    let
      current = firstDayOfMonth calendar
    in
    Time.Extra.add Time.Extra.Month -1 model.zone current

{--
Get the list of days in a month grouped by week
the days are represented by a Maybe Time.Posix
If the first of the month is not a monday the days are represeted with Nothing
and same with if the last day of the month is not a sunday
--}
daysOfMonth : Time.Zone -> Time.Posix -> List (List (Maybe Time.Posix))
daysOfMonth zone posix =
  let
    (start, end) = monthBoundary zone posix
    days = Time.Extra.range Time.Extra.Day 1 zone start end
    prepend = List.repeat (fromMonday zone start) Nothing
    dayEndMonth = case List.head <| List.reverse days of
                    Nothing -> end
                    Just d -> d
    append = List.repeat (toSunday zone dayEndMonth) Nothing
  in
   groupByWeek <| prepend ++ (List.map (\p -> Just p) days) ++ append

fromMonday : Time.Zone -> Time.Posix -> Int
fromMonday zone posix =
  weekday <| Time.toWeekday zone posix

toSunday : Time.Zone -> Time.Posix -> Int
toSunday zone posix =
  6 - (weekday <| Time.toWeekday zone posix)

weekday : Time.Weekday -> Int
weekday day =
  case day of
    Time.Mon -> 0
    Time.Tue -> 1
    Time.Wed -> 2
    Time.Thu -> 3
    Time.Fri -> 4
    Time.Sat -> 5
    Time.Sun -> 6

groupByWeek : List a -> List (List a)
groupByWeek l =
    let
        group res tail =
            case tail of
                [] ->
                    List.reverse res

                _ ->
                    group ((List.take 7 tail) :: res) (List.drop 7 tail)
    in
        group [] l

-- Display the calendar

view : Calendar -> Html Msg
view calendar =
  showCalendar calendar


showCalendar : Calendar -> Html Msg
showCalendar ((Calendar model) as calendar) =
  span []
  [ p [onClick Toggle, class "pa2 ba br2 dib mb2 pointer"] [ text <| formatPosix model.zone model.posix ]
  , div [class "relative"]
      [ div [ class "absolute top-0 left-0 bg-white pt3 w-100", classList [("dn", not model.open)]]
        [ div [class "b"]
          [ span [onClick PreviousMonth, class "dib w-25 tl pointer"] [text "<"]
          , span [class "dib w-50 tc"] [text <| currentMonth calendar ++ " " ++ currentYear calendar]
          , span [onClick NextMonth, class "dib w-25 tr pointer"] [text ">"]
          ]
        , table [ class "w-100 tc center"]
          [ thead []
            [ tr []
              [ td [class "pv3"] [text "Mon"]
              , td [class "pv3"] [text "Tue"]
              , td [class "pv3"] [text "Wed"]
              , td [class "pv3"] [text "Thu"]
              , td [class "pv3"] [text "Fri"]
              , td [class "pv3"] [text "Sat"]
              , td [class "pv3"] [text "Sun"]
              ]
            ]
          , tbody []
          (showMonth calendar)
        ]
        ]
      ]
    ]

showMonth : Calendar -> List (Html Msg)
showMonth (Calendar model) =
    List.map (showWeek model.currentTime model.zone) model.month


showWeek : Time.Posix -> Time.Zone -> List (Maybe Time.Posix) -> Html Msg
showWeek currentTime zone week =
    tr [] (List.map (showDate currentTime zone) week)

showDate : Time.Posix -> Time.Zone -> Maybe Time.Posix -> Html Msg
showDate currentTime zone date =
        case date of
            Just d ->
              if (Time.posixToMillis d) > (Time.posixToMillis currentTime) then
                  td [class "ph2 pv3 b relative"]
                    [ span [class "db gray"] [text <| String.fromInt <| Time.toDay zone d]]
              else
                  td [class "ph2 pv3 b relative pointer"]
                    [ a [href <| "/log?date=" ++ (queryStringDate zone d), class "no-underline black"]
                      [ span [class "db"] [text <| String.fromInt <| Time.toDay zone d]
                      -- , span [class "absolute bottom-0 right-0 left-0 w-25 h-25 br-100 bg-red center"] []
                      ]
                    ]

            Nothing ->
                td [class "ph2 pv3"] [ text "" ]

formatPosix : Time.Zone -> Time.Posix -> String
formatPosix zone time =
  let
    day = String.fromInt <| Time.toDay zone time
    month = formatMonth <| Time.toMonth zone time
    year = String.fromInt <| Time.toYear zone time
  in
  day ++ " " ++ month ++ " " ++ year

formatMonth : Time.Month -> String
formatMonth month =
    case month of
      Time.Jan -> "Jan"
      Time.Feb -> "Feb"
      Time.Mar -> "Mar"
      Time.Apr -> "Apr"
      Time.May -> "May"
      Time.Jun -> "Jun"
      Time.Jul -> "Jul"
      Time.Aug -> "Aug"
      Time.Sep -> "Sep"
      Time.Oct -> "Oct"
      Time.Nov -> "Nov"
      Time.Dec -> "Dec"

formatMonthNumber : Time.Month -> String
formatMonthNumber month =
    case month of
      Time.Jan -> "01"
      Time.Feb -> "02"
      Time.Mar -> "03"
      Time.Apr -> "04"
      Time.May -> "05"
      Time.Jun -> "06"
      Time.Jul -> "07"
      Time.Aug -> "08"
      Time.Sep -> "09"
      Time.Oct -> "10"
      Time.Nov -> "11"
      Time.Dec -> "12"

formatDayNumber : String -> String
formatDayNumber day =
    if String.length day == 1 then
      "0" ++ day
    else
      day

queryStringDate : Time.Zone -> Time.Posix -> String
queryStringDate zone posixTime =
    let
     year = String.fromInt <| Time.toYear zone posixTime
     month = formatMonthNumber <| Time.toMonth zone posixTime
     day = formatDayNumber <| String.fromInt <| Time.toDay zone posixTime
    in
     day ++ "-" ++ month ++ "-" ++ year

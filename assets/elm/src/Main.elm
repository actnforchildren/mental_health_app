import Browser
import Html exposing (Html, button, div, text, p)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }

-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = None


update : Msg -> Model -> Model
update msg model =
    case msg of
        None -> model



-- VIEW

view : Model -> Html Msg
view model =
    div []
      [
        p [] [text "generated elm code"]
      ]

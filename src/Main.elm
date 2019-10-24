-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--


module Main exposing (..)

import Browser
import Html exposing (Attribute, Html, div, input, li, text, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String
    , history : List String
    }


init : Model
init =
    { content = "", history = [] }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            if List.length model.history < 10 then
                { model | content = newContent, history = newContent :: model.history }

            else
                { model | content = newContent, history = newContent :: List.take 9 model.history }


renderList : List String -> Html msg
renderList list =
    ul []
        (List.map renderItem list)


renderItem : String -> Html msg
renderItem item =
    li [] [ text item ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        , div
            []
            [ renderList model.history ]
        ]

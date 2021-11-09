module Todo.Web.View (view) where

import Control.Lens ((<&>), (^.), (%~), _1, ix, itoList)
import Data.Bool
import Data.Map
import Miso (View, checked_, div_, h1_, img_, input_, onClick, p_, src_, style_, text, type_)
import Miso.String hiding (length)
import Todo.Web.State

view :: State -> View Action
view s = div_ [style_ containerStyle]
    [ h1_ [style_ titleStyle] ["Weekly Todo List (Simple Check)"]
    , div_ [style_ todosStyle]
        [ div_ [style_ todoStyle]
            [ input_ [checked_ True, type_ "checkbox"]
            , p_ [style_ $ todoDescriptionStyle True]
                ["Interview for an open position"]
            ]
        , div_ [style_ todoStyle]
            [ input_ [checked_ True, type_ "checkbox"]
            , p_ [style_ $ todoDescriptionStyle True]
                ["Join Polimorphic!"]
            ]
        , div_ [style_ todoStyle]
            [ input_ [type_ "checkbox"]
            , p_ [style_ $ todoDescriptionStyle False]
                ["Build the virtual townhall!"]
            ]
        , div_ [style_ todoStyle]
            [ input_ [type_ "checkbox"]
            , p_ [style_ $ todoDescriptionStyle False]
                ["Give local government it's biggest software update"]
            ]
        , div_ [style_ todoStyle]
            [ input_ [checked_ True, type_ "checkbox"]
            , p_ [style_ $ todoDescriptionStyle True]
                ["Start learning the codebase"]
            ]
        ]
    , h1_ [style_ titleStyle] ["Weekly Todo List (Custom Check)"]
    , p_ [] [text $ (ms . show . length $ s ^. sTodos) <> " entries"]
    , div_ [style_ todosStyle] $ itoList (s ^. sTodos) <&> \(i, (active, description)) -> div_
        [style_ todoStyle]
        [ div_ [style_ $ checkStyle active, onClick . Modify $ sTodos . ix i . _1 %~ not] . pure $
            img_ [src_ checkUrl, style_ checkWhiteStyle]
        , p_ [style_ $ todoDescriptionStyle active] [text description]
        ]
    ]
  where
    checkUrl = "/static/check.svg"
        

checkStyle :: Bool -> Map MisoString MisoString
checkStyle checked =
    [ ("background-color", bool "white" "#27AAE1" checked)
    , ("border", "1px solid")
    , ("border-color", bool "#DDDDDD" "#27AAE1" checked)
    , ("border-radius", "3px")
    , ("cursor", "pointer")
    , ("height", "16px")
    , ("justify-content", "center")
    , ("margin-right", "10px")
    , ("width", "16px")
    ] <> flexVAlignStyle

checkWhiteStyle :: Map MisoString MisoString
checkWhiteStyle =
    [ ("filter", "brightness(0) invert(1)")
    , ("height", "10px")
    , ("width", "10px")
    ]

containerStyle :: Map MisoString MisoString
containerStyle =
    [ ("font-family", "\'Work Sans\', sans-serif")
    , ("padding", "25px 15px")
    , ("margin", "0 auto")
    , ("max-width", "100%")
    , ("width", "600px")
    ]

flexVAlignStyle :: Map MisoString MisoString
flexVAlignStyle =
    [ ("align-items", "center")
    , ("display", "flex")
    ]

titleStyle :: Map MisoString MisoString
titleStyle = [("font-size", "32px")]

todoStyle :: Map MisoString MisoString
todoStyle = [("margin-bottom", "10px")] <> flexVAlignStyle

todoDescriptionStyle :: Bool -> Map MisoString MisoString
todoDescriptionStyle completed =
    [ ("color", bool "black" "#888888" completed)
    , ("margin-left", "10px")
    ] <> bool [] [("text-decoration", "line-through")] completed

todosStyle :: Map MisoString MisoString
todosStyle = [("margin", "20px auto")]

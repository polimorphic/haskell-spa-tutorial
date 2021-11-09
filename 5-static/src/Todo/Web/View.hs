module Todo.Web.View (view) where

import Miso (View, div_, button_, class_)

view :: View a
view = div_ [] 
    ["Todo"
    , div_ [][ button_ [] ["Click me!"]] 
    , div_ [class_ "red-text"] ["I am Clifford"] 
    ]

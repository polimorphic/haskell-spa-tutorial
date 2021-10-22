module Todo.Web.View (view) where

import Miso (View, div_)

view :: View a
view = div_ [] ["Todo"]

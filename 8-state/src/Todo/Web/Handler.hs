module Todo.Web.Handler (handler) where

import Miso (Effect)

import Todo.Web.State

handler :: Action -> State -> Effect Action State
handler a s = case a of
    Modify f -> pure $ f s

    NoOp -> pure s

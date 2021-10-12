module Todo.Web.Client (main) where

import Language.Javascript.JSaddle (JSM)
import Miso
    ( App(App), LogLevel(..), defaultEvents, events, initialAction
    , logLevel, miso, model, mountPoint, subs, update
    )
import qualified Miso

import Todo.Web.View

main :: JSM ()
main = miso $ \_ -> App
    { model = ()
    , update = \() () -> pure ()
    , Miso.view = \() -> view
    , initialAction = ()
    , events = defaultEvents
    , logLevel = Off
    , mountPoint = Nothing
    , subs = []
    }

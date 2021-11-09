module Todo.Web.Client (main) where

import Data.Aeson (fromJSON)
import Data.Foldable (for_, traverse_)
import GHCJS.Marshal (fromJSVal)
import GHCJS.Types (JSVal)
import Language.Javascript.JSaddle (JSM, jsg)
import Miso
    ( App(App), LogLevel(..), defaultEvents, events, initialAction
    , logLevel, miso, model, mountPoint, subs, update
    )
import qualified Miso
import Miso.String

import Todo.Web.Handler
import Todo.Web.State
import Todo.Web.View

main :: JSM ()
main = do
    rst <- fmap (fmap fromJSON) . fromJSVal =<< getState
    for_ rst . traverse_ $ \s -> miso $ \_ -> App
        { model = s
        , update = handler
        , Miso.view = view
        , initialAction = NoOp
        , events = defaultEvents
        , logLevel = Off
        , mountPoint = Nothing
        , subs = []
        }

getState :: JSM JSVal
getState = jsg @MisoString "state"
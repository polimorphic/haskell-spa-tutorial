module Todo.Web.Server (main) where

import Data.Proxy (Proxy(Proxy))
import Lucid (Html, body_, charset_, doctype_, head_, html_, lang_, meta_, p_, title_)
import Network.Wai.Handler.Warp (run)
import Servant (Get, serve)
import Servant.HTML.Lucid (HTML)

main :: IO ()
main = run 3438 . serve (Proxy @Urls) $ do
    pure . (doctype_ *>) . html_ [lang_ "en"] $ do
        head_ $ do
            meta_ [charset_ "utf-8"]
            title_ "Todo"
        body_ $ do
            p_ "Todo"

type Urls = Get '[HTML] (Html ())

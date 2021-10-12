module Todo.Web.Server (main) where

import Data.Proxy (Proxy(Proxy))
import Lucid (Html, body_, charset_, doctype_, head_, html_, lang_, meta_, script_, title_, toHtml)
import Language.Javascript.JSaddle.Warp (jsaddleJs, jsaddleOr)
import Network.Wai.Handler.Warp (run)
import Network.WebSockets (defaultConnectionOptions)
import Servant (Get, serve)
import Servant.HTML.Lucid (HTML)

import qualified Todo.Web.Client as C
import Todo.Web.View

main :: IO ()
main = do
    server <- jsaddleOr defaultConnectionOptions C.main . serve (Proxy @Urls) $ do
        pure . (doctype_ *>) . html_ [lang_ "en"] $ do
            head_ $ do
                meta_ [charset_ "utf-8"]
                title_ "Todo"
            body_ $ do
                toHtml view
                script_ [] $ jsaddleJs False
    run 3438 server

type Urls = Get '[HTML] (Html ())

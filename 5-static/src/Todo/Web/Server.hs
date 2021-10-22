module Todo.Web.Server (main) where

import Data.Hashable (hash)
import qualified Data.Text as T
import GHC.Generics (Generic)
import Lucid
    ( Html, body_, charset_, doctype_, head_, href_, html_
    , lang_, link_, meta_, rel_, script_, title_, toHtml
    )
import Language.Javascript.JSaddle.Warp (jsaddleJs, jsaddleOr)
import Network.Wai.Handler.Warp (run)
import Network.WebSockets (defaultConnectionOptions)
import Servant (Get, Raw, Server, serveDirectoryWebApp, (:>))
import Servant.API.Generic ((:-))
import Servant.HTML.Lucid (HTML)
import Servant.Server.Generic (genericServe)

import qualified Todo.Web.Client as C
import Todo.Web.View

main :: IO ()
main = do
    baseCssHash <- hash <$> readFile "static/base.css" 
    server <- jsaddleOr defaultConnectionOptions C.main . genericServe $ Api
        { aStatic = staticServer
        , aMain = mainServer baseCssHash
        }
    run 3438 server

mainServer :: Int -> Server Urls
mainServer baseCssHash = pure . (doctype_ *>) . html_ [lang_ "en"] $ do
    head_ $ do
        meta_ [charset_ "utf-8"]
        title_ "Todo"
        link_ [rel_ "stylesheet", href_ $ "/static/base.css?" <> T.pack (show baseCssHash)]
    body_ $ do
        toHtml view
        script_ [] $ jsaddleJs False

staticServer :: Server Raw
staticServer = serveDirectoryWebApp "static"

data Api r = Api
    { aStatic :: r :- "static" :> Raw
    , aMain :: r :- Urls
    } deriving (Generic)

type Urls = Get '[HTML] (Html ())

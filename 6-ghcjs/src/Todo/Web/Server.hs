module Todo.Web.Server (server) where

import Data.Hashable (hash)
import qualified Data.Text as T
import GHC.Generics (Generic)
import Lucid
    ( Html, body_, charset_, doctype_, head_, href_, html_
    , lang_, link_, meta_, rel_, title_, toHtml
    )
import Network.Wai (Application)
import Servant (Get, Raw, Server, serveDirectoryWebApp, (:>))
import Servant.API.Generic ((:-))
import Servant.Server.Generic (genericServe)
import Servant.HTML.Lucid (HTML)

import Todo.Web.View

server :: Html () -> IO Application
server extra = do
    baseCssHash <- hash <$> readFile "static/base.css" 
    pure . genericServe $ Api
        { aStatic = staticServer
        , aMain = mainServer baseCssHash extra
        }

mainServer :: Int -> Html () -> Server Urls
mainServer baseCssHash extra = pure . (doctype_ *>) . html_ [lang_ "en"] $ do
    head_ $ do
        meta_ [charset_ "utf-8"]
        title_ "Todo"
        link_ [rel_ "stylesheet", href_ $ "/static/base.css?" <> T.pack (show baseCssHash)]
    body_ $ do
        toHtml view
        extra

staticServer :: Server Raw
staticServer = serveDirectoryWebApp "static"

data Api r = Api
    { aStatic :: r :- "static" :> Raw
    , aMain :: r :- Urls
    } deriving (Generic)

type Urls = Get '[HTML] (Html ())

module Todo.Web.Server (server) where

import GHC.Generics (Generic)
import Lucid (Html, body_, charset_, doctype_, head_, html_, lang_, meta_, title_, toHtml)
import Network.Wai (Application)
import Servant (Get, Raw, Server, serveDirectoryWebApp, (:>))
import Servant.API.Generic ((:-))
import Servant.Server.Generic (genericServe)
import Servant.HTML.Lucid (HTML)

import Todo.Web.View

server :: Html () -> Application
server extra = genericServe $ Api
    { aStatic = staticServer
    , aMain = mainServer extra
    }

mainServer :: Html () -> Server Urls
mainServer extra = pure . (doctype_ *>) . html_ [lang_ "en"] $ do
    head_ $ do
        meta_ [charset_ "utf-8"]
        title_ "Todo"
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

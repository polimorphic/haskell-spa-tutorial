module Todo.Web.Server.JSaddle (main) where

import Language.Javascript.JSaddle.Warp (jsaddleJs, jsaddleOr)
import Lucid (script_)
import Network.Wai.Handler.Warp (run)
import Network.WebSockets (defaultConnectionOptions)

import qualified Todo.Web.Client as C
import Todo.Web.Server

main :: IO ()
main = do
    let extra = script_ [] $ jsaddleJs False
    run 3438 =<< jsaddleOr defaultConnectionOptions C.main =<< server extra

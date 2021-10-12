module Todo.Web.Server.GHCJS (main) where

import Data.Hashable (hash)
import qualified Data.Text as T
import Lucid (script_, src_)
import Network.Wai.Handler.Warp (run)

import Todo.Web.Server

main :: IO ()
main = do
    allJsHash <- hash <$> readFile "static/all.js"
    let extra = script_ [src_ $ "/static/all.js?" <> T.pack (show allJsHash)] ("" :: String)
    run 3438 $ server extra

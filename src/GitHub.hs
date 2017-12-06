module GitHub (getLatestJson) where

import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy as LB

get url = simpleHttp url

getLatestJson repo = do
    -- https://api.github.com/repos/wk-j/dotnet-filter/releases/latest
    let url = "https://api.github.com/repos/" ++ repo ++ "/release/latest"
    get url
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

import Text.RawString.QQ
import Lib
import GitHub
import Data.ByteString.Lazy.Char8

json = [r|
{
    "url": "url",
    "assets": {
        "browser_download_url": "browser_download_Url",
        "content_type": "content_type"
    }
}
|]

main :: IO ()
main =  do
    lastJson <- getLatestJson "wk-j/dotnet-filter"
    let obj = parseRelease $ lastJson
    print obj

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Main where

import Lib
import Text.RawString.QQ

json = [r|
{
    "url": "xx",
    "assets": {
        "browser_download_url": "xxx",
        "content_type": "xxx"
    }
}
|]

main :: IO ()
main = do
    let a = parseRelease json
    print a


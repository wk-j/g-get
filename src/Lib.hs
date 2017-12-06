{-# LANGUAGE OverloadedStrings #-}

module Lib  where

import Data.Text
import Data.Aeson
import Control.Monad

data Release = Release 
    { url       :: Text
    , assets    :: Asset 
    } deriving Show

data Asset = Asset 
    { webDownloadUrl    :: Text
    , contentType       :: Text 
    } deriving Show

instance FromJSON Asset where
    parseJSON (Object v) = 
        Asset <$> v .: "browser_download_url"
              <*> v .: "size"
    parseJSON _ = mzero

instance FromJSON Release where
    parseJSON (Object o) = 
        Release <$> o .: "url"
                <*> o .: "assets"
    parseJSON _ = mzero     


releasePath :: String -> String
releasePath repo = 
    "https://api.github.com/repos/{repo}/releases/latest"
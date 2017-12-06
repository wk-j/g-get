{-# LANGUAGE OverloadedStrings #-}

module Lib  (parseRelease) where

import Data.Text
import Data.Aeson
import Control.Monad
import Data.ByteString.Lazy.Internal

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
              <*> v .: "content_type"
    parseJSON _ = mzero

instance FromJSON Release where
    parseJSON (Object o) = 
        Release <$> o .: "url"
                <*> o .: "assets"
    parseJSON _ = mzero     


releasePath :: String -> String
releasePath repo = 
    "https://api.github.com/repos/{repo}/releases/latest"

parseRelease :: ByteString -> Either String Release
parseRelease text = 
   eitherDecode text :: Either String Release
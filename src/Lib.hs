module Lib  where

import Data.Aeson

data Release = 
    Release { url :: String
            , assets :: Asset }

data Asset =
    Asset { webDownloadUrl :: String
          , contentType :: String }

instance FromJson Release where
    parseJSON (Object v) = 
        Release <$> v .: "url"
                <*> v .: "assets"
    parseJSON _ = mzero

releasePath :: String -> String
releasePath repo = 
    "https://api.github.com/repos/{repo}/releases/latest"

{-#
stack ghci
:set -XOverloadedStrings
#-}

import Data.Aeson
import Data.Text

decode "[1,2,3]" :: Maybe [Integer]

decode "foo" :: Maybe [Integer]

eitherDecode "[]" :: Either String Integer

eitherDecode "[1,2, [3,4]]" :: Either String (Int,Int, (Int, Bool))

eitherDecode "[1,2,[3,true]]" :: Either String (Int,Int, (Int, Bool))

-- wk
decode "Hello" :: Maybe String 

:{
data Value
    = Object Object
    | Array Array
    | String Text
    | Number Scientific
    | Bool Bool
    | Null
:}


:{
data Asset = Asset
    { browserDownloadUrl :: Text 
    , size :: Int }

data Release = Release
    { url :: Text
    , assets :: [Asset] }
:}

:{
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
:}
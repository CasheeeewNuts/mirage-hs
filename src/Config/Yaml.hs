module Config.Yaml (Config(..), DirConfig(..), dirConfigToObject) where

import qualified Data.Text as T
import Data.Aeson as A
import Data.Aeson.Key as A
import qualified Data.Yaml as Y
import Data.Maybe

data DirConfig = DirConfig
  { always :: Maybe String,
    whenEmpty :: Maybe String
  }
  deriving (Show)

newtype Config = Config
  { dirs :: [(String, DirConfig)]
  } deriving (Show)

instance ToJSON Config where
  toJSON ds = object $ [(A.fromString "directories", Y.array cs)]
    where cs = map (\(k, v) -> object [(A.fromString k, dirConfigToObject v)]) $ dirs ds
    
--instance FromJSON Config where
--  parseJSON = withArray "directories" $ \ds -> 
    
  
dirConfigToObject :: DirConfig -> Value
dirConfigToObject c = object $ map pack_ $ filter onlyJust cs
  where
    cs = [(A.fromString "always", always c), (A.fromString "whenEmpty", whenEmpty c)]
    onlyJust (_, v) = isJust v
    pack_ (k, v) = (k, valueFromString $ fromJust v)

valueFromString :: String -> Value
valueFromString = A.String . T.pack
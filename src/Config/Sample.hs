{-# LANGUAGE QuasiQuotes #-}
module Config.Sample (sample) where
  
import Text.RawString.QQ

sample :: String
sample = [r|directories:
  - sample:
    - whenEmpty: generate command
|]


{-# LANGUAGE DeriveDataTypeable #-}

module Cmd.CmdLine
  ( getCmdLine,
    configFileName,
    Cmd (..),
  )
where

import System.Console.CmdArgs.Implicit
import qualified System.Environment as E
import System.FilePath.Posix
import Prelude hiding (init)

data Cmd
  = Sync
      { configFile :: FilePath
      }
  | Init
  | Prune
  deriving (Data, Typeable, Show)

configFileName :: String
configFileName = "mirage-config.yml"

sync :: Cmd
sync =
  Sync
    { configFile = "." </> configFileName &= name "config"
    }

init :: Cmd
init = Init &= help "generate configuration file"

prune :: Cmd
prune = Prune

cmdLineMode :: Cmd
cmdLineMode =
  modes
    [ sync &= auto,
      init,
      prune
    ]

getCmdLine :: [String] -> IO Cmd
getCmdLine = flip E.withArgs $ cmdArgs cmdLineMode

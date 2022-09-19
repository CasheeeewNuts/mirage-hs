{-# LANGUAGE DeriveDataTypeable #-}

module Cmd.CmdLine
  ( getCmdLine,
    configFileName,
    Cmd (..),
  )
where

import System.Console.CmdArgs.Implicit hiding (args)
import qualified System.Environment as E
import Prelude hiding (init)

data Cmd
  = Sync
      { configFile :: FilePath
      }
  | Init {}
  | Prune {}
  deriving (Data, Typeable, Show)

configFileName :: String
configFileName = "mirage-config.yml"

sync :: Cmd
sync =
  Sync
    { configFile = "./" ++ configFileName
    }

init :: Cmd
init = Init {}

prune :: Cmd
prune = Prune {}

cmdLineMode :: Mode (CmdArgs Cmd)
cmdLineMode = cmdArgsMode $ modes [sync &= auto, prune, init]

getCmdLine :: [String] -> IO Cmd
getCmdLine args = E.withArgs args $ cmdArgsRun cmdLineMode

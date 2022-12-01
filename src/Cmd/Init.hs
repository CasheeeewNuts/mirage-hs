module Cmd.Init (init) where

import Prelude hiding (init)
import Cmd.CmdLine (configFileName)
import Config.Sample
import System.Directory
import System.FilePath.Posix

init :: FilePath -> IO ()
init wd = do
  let filePath = wd </> configFileName
  fileExists <- doesFileExist filePath

  if fileExists
    then return ()
    else writeFile filePath sample >> createStore
  where
    createStore = createDirectory ".mirage"
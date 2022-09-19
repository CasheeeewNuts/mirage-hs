module Cmd.Init (init_) where

import Cmd.CmdLine (configFileName)
import Config.Sample
import System.Directory
import System.FilePath.Posix
import System.IO

init_ :: FilePath -> IO ()
init_ wd = do
  let filePath = wd </> configFileName
  fileExists <- doesFileExist filePath

  if fileExists
    then fail "config file already exists"
    else put filePath sample
  where
    put path content = do
      h <- openFile path WriteMode
      hPutStr h content
      hClose h

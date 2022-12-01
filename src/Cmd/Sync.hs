module Cmd.Sync(sync) where

import System.FilePath.Posix
import System.Process
import System.Directory
import Control.Monad

type Command = (FilePath, ())

sync :: [Command] -> IO () 
sync cmds = forM_ cmds execCommand
  
 
execCommand :: Command -> IO ()
execCommand (path, _) = do
  ref <- readRefName "HEAD"
  let storePath = ".mirage" </> ref </> path
  existsStore <- doesDirectoryExist storePath
  createDirectoryIfMissing (not existsStore) $ storePath
  
  where
    readRefName ref = liftM init $ readProcess "git" ["rev-parse", "--abbrev-ref", ref] []
module Cmd.Sync(sync) where

import System.FilePath.Posix
import Control.Monad

type Command = (FilePath, ())

sync :: [Command] -> IO () 
sync cmds = forM_ cmds execCommand
  
 
execCommand :: Command -> IO ()
execCommand (path, _) = do
  print path
  
module Main (main) where


import Cmd.CmdLine
import Cmd.Init
import qualified System.Environment as E
import qualified System.Posix.Directory as D

main :: IO ()
main = do
  cmd <- getCmdLine =<< E.getArgs
  case cmd of
    Init -> D.getWorkingDirectory >>= init_
    Prune -> return ()
    Sync _ -> pure ()

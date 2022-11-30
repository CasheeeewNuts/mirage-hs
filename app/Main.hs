module Main (main) where


import Cmd.CmdLine
import qualified Cmd.Init 
import qualified Cmd.Sync 
import qualified System.Environment as E
import qualified System.Posix.Directory as D

main :: IO ()
main = do
  cmd <- getCmdLine =<< E.getArgs
  case cmd of
    Init -> D.getWorkingDirectory >>= Cmd.Init.init
    Prune -> return ()
    Sync _ -> Cmd.Sync.sync [("./", ())]

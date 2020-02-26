module TextFilter
    ( fileProc
    ) where

import Control.Monad.Catch (SomeException, catch)
import System.IO (Handle, IOMode (..), stdin, stdout, stderr, withFile, hPrint)

fileProc :: FilePath -> FilePath -> (Handle -> Handle -> IO ()) -> IO ()
fileProc inpath outpath proc = case (inpath, outpath) of
  ("-", "-") -> catch (proc stdin stdout) errprint
  ("-", _  ) -> catch (withFile outpath WriteMode (proc stdin)) errprint
  (_  , "-") -> catch (withFile inpath  ReadMode  (flip proc stdout)) errprint
  _          -> catch (withFile inpath  ReadMode  (withFile outpath WriteMode . proc)) errprint

errprint :: SomeException -> IO ()
errprint = hPrint stderr

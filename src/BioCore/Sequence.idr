module BioCore.Sequence

import Data.List
import Data.Strings

%default total


--Qual--

public export
data Qual = ||| Quality data associate with sequence data.
            UnQual Int

public export
Show Qual where
  show (UnQual x) = show x

public export
Eq Qual where
  (==) (UnQual x) (UnQual y) = True
  (==) _          _          = False

public export
Ord Qual where
  compare (UnQual x) (UnQual y) = compare x y 

public export
Num Qual where
  fromInteger = UnQual . fromInteger

public export
extractUnQual : Qual -> Int
extractUnQual (UnQual unQual) = unQual

--------


--Offset--

public export
data Offset = ||| The offset in the sequence data.
              UnOff Int

public export
Show Offset where
  show (UnOff x) = show x

public export
Eq Offset where
  (==) (UnOff x) (UnOff y) = True
  (==) _          _        = False

public export
Ord Offset where
  compare (UnOff x) (UnOff y) = compare x y

public export
Num Offset where
  fromInteger = UnOff . fromInteger

public export
extractUnOff : Offset -> Int
extractUnOff (UnOff unOff) = unOff

----------


--SeqData--

public export 
data SeqData = ||| Sequence data are List String of ASCII characters.
               UnSD String

public export
Show SeqData where
  show (UnSD x) = show x

public export
Eq SeqData where
  (==) (UnSD x) (UnSD y) = True
  (==) _          _      = False

public export
Ord SeqData where
  compare (UnSD x) (UnSD y) = compare x y

public export
extractUnSD : SeqData -> String
extractUnSD (UnSD unSD) = unSD

-----------


--SeqLabel--

public export
data SeqLabel = ||| Sequence labels are List String of ASCII characters.
                UnSL String

public export
Show SeqLabel where
  show (UnSL x) = show x

public export
Eq SeqLabel where
  (==) (UnSL x) (UnSL y) = True
  (==) _          _      = False

public export
Ord SeqLabel where
  compare (UnSL x) (UnSL y) = compare x y

public export
extractUnSL : SeqLabel -> String
extractUnSL (UnSL unSL) = unSL

------------


--QualData--

public export
data QualData = ||| The quality data associated with the sequence data.
                UnQD String

public export
Show QualData where
  show (UnQD x) = show x

public export
Eq QualData where
  (==) (UnQD x) (UnQD y) = True
  (==) _          _      = False

public export
Ord QualData where
  compare (UnQD x) (UnQD y) = compare x y

public export
extractUnQD : QualData -> String
extractUnQD (UnQD unQD) = unQD

------------

public export
toFastaSeqData : SeqLabel -> SeqData -> String
toFastaSeqData (UnSL seqlabel) (UnSD seqdata) = ">"      ++ 
                                                seqlabel ++ 
                                                "\n"     ++ 
                                                (wrapSeqData seqdata (unpack seqdata))
  where wrapSeqData : String -> List Char -> String
        wrapSeqData _ []       = "" 
        wrapSeqData s (_::ss') = if isNil (unpack s)
                                   then ""
                                   else let (ln,rest) = splitAt 60 (unpack s)
                                          in (pack ln) ++ 
                                             "\n"      ++ 
                                             (wrapSeqData (pack rest) ss')

public export
toFastaQual : SeqLabel -> QualData -> String
toFastaQual (UnSL seqlabel) (UnQD qualdata) = ">"      ++ 
                                              seqlabel ++ 
                                              "\n"     ++ 
                                              (wrapqualdata qualdata (unpack qualdata))
  where wrapqualdata : String -> List Char -> String
        wrapqualdata _ []       = ""
        wrapqualdata s (_::ss') = if isNil (unpack s)
                                    then ""
                                    else let (ln,rest) = splitAt 20 (unpack s)
                                           in (pack ln) ++ 
                                              "\n"      ++
                                              (wrapqualdata (pack rest) ss')

" syn match hsBindingName "^[a-z_][a-zA-Z0-9_']*"
" hi link hsBindingName Identifier

" Group 1 (links to Statement): Top-level block makers
"   data/type/newtype
"   class/instance
" Group 2 (links to Conditional): Branching
"   case-of
"   if-then-else
" Group 3 (links to Keyword): Sub-block makers (Note `do` is semantically exceptional)
"   deriving
"   let-in
"   where
"   do

syn keyword hsStatement data type newtype class instance
syn keyword hsConditional case of if then else
syn keyword hsKeyword deriving let in where do

syn keyword hsImport import nextgroup=hsImportModuleName
syn keyword hsImportMod as qualified hiding

syn keyword hsBuiltinClass Applicative Bounded Enum Eq Floating Foldable Fractional Functor Integral Monad MonadFail Monoid Num Ord Read Real RealFloat RealFrac Semigroup Show Traversable
syn keyword hsBuiltinType FilePath IOError Rational ReadS ShowS String
syn keyword hsBuiltinData Bool Char Double Either Float Int Integer Maybe Ordering Word
syn keyword hsBuiltinNewtype IO

syn keyword hsBuiltinFunction all and any appendFile asTypeOf break concat concatMap const curry cycle drop dropWhile either even filter flip fromIntegral fst gcd getChar getContents getLine head id init interact iterate last lcm lex lines lookup map mapM_ maybe not notElem odd or otherwise print putChar putStr putStrLn read readFile readIO readLn readParen reads realToFrac repeat replicate reverse scanl scanl1 scanr scanr1 seq sequence_ showChar showParen showString shows snd span splitAt subtract tail take takeWhile uncurry unlines until unwords unzip unzip3 words writeFile zip zip3 zipWith zipWith3
hi link hsBuiltinFunction Builtin
syn keyword hsBuiltinMethod pure liftA2 minBound maxBound succ pred toEnum fromEnum enumFrom enumFromThen enumFromTo enumFromThenTo pi exp log sqrt logBase sin cos tan asin acos atan sinh cosh tanh asinh acosh atanh foldMap foldr foldl foldr1 foldl1 null length elem maximum minimum sum product recip fromRational fmap quot rem div mod quotRem divMod toInteger return fail mempty mappend mconcat negate abs signum fromInteger compare max min readsPrec readList toRational floatRadix floatDigits floatRange decodeFloat encodeFloat exponent significand scaleFloat isNaN isInfinite isDenormalized isNegativeZero isIEEE atan2 properFraction truncate round ceiling floor showsPrec show showList traverse sequenceA mapM sequence
hi link hsBuiltinMethod Builtin

syn keyword hsBulitinError error errorWithoutStackTrace ioError undefined userError
hi link hsBulitinError Builtin

hi def link hsStatement   Statement
hi def link hsConditional Conditional
hi def link hsKeyword     Keyword

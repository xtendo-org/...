syntax match pythonAssignmentOperator /=/
syntax match pythonBracket /(\|)\|\[\|\]\|{\|}/

syntax keyword pythonBuiltinConstant True False None Ellipsis NotImplemented

syntax keyword pythonBuiltinException BaseException Exception ArithmeticError BufferError LookupError AssertionError AttributeError EOFError FloatingPointError GeneratorExit ImportError ModuleNotFoundError IndexError KeyError KeyboardInterrupt MemoryError NameError NotImplementedError OSError OverflowError RecursionError ReferenceError RuntimeError StopIteration SyntaxError IndentationError TabError SystemError SystemExit TypeError UnboundLocalError UnicodeError UnicodeEncodeError UnicodeDecodeError UnicodeTranslateError ValueError ZeroDivisionError

syntax keyword pythonConditional if elif else try except finally

syntax keyword pythonCase match case

hi link pythonCase pythonConditional

syntax match pythonLocal /\<_[A-Za-z0-9_]*\>/

syntax keyword pythonBuiltinFunction abs all any ascii bin bool breakpoint bytearray bytes callable chr classmethod compile complex delattr dict dir divmod enumerate eval exec filter float format frozenset getattr globals hasattr hash help hex id input int isinstance issubclass iter len list locals map max memoryview min next object oct open ord pow print property range repr reversed round set setattr slice sorted staticmethod str sum super tuple type vars zip __import__

syntax match pythonSpecialOperator /\*\*\|\/\/\|==\|<=\|>=\|!=\|<\|>\|+\|-\|\*\|\/\|%\|&\||\|\^/

hi link pythonSpecialOperator SymbolSpecial
hi link pythonAssignmentOperator SymbolAssignment

syntax keyword pythonKeyword assert await break continue return yield
hi link pythonKeyword Keyword

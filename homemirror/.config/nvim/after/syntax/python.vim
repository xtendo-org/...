syntax keyword pythonBuiltinConstant True False None Ellipsis NotImplemented

syntax keyword pythonBuiltinFunction abs all any ascii bin bool breakpoint bytearray bytes callable chr classmethod compile complex delattr dict dir divmod enumerate eval exec filter float format frozenset getattr globals hasattr hash help hex id input int isinstance issubclass iter len list locals map max memoryview min next object oct open ord pow print property range repr reversed round set setattr slice sorted staticmethod str sum super tuple type vars zip __import__

syntax keyword pythonBuiltinException BaseException Exception ArithmeticError BufferError LookupError AssertionError AttributeError EOFError FloatingPointError GeneratorExit ImportError ModuleNotFoundError IndexError KeyError KeyboardInterrupt MemoryError NameError NotImplementedError OSError OverflowError RecursionError ReferenceError RuntimeError StopIteration SyntaxError IndentationError TabError SystemError SystemExit TypeError UnboundLocalError UnicodeError UnicodeEncodeError UnicodeDecodeError UnicodeTranslateError ValueError ZeroDivisionError

syntax keyword pythonCase match case

hi link pythonCase pythonConditional

syntax match pythonCapital /\<[A-Z][A-Za-z0-9_]*\>/

" lua << EOF
" function HighlightConventionalParameter()
"   local bufnr = vim.api.nvim_get_current_buf()
"   local specific_methods = { "i", "self", "cls" }
"   for _, method in ipairs(specific_methods) do
"     vim.fn.matchadd('pythonConventional', '\\<' .. method .. '\\>', 100, -1, {buffer = bufnr})
"   end
" end
" EOF

" augroup HaskellSpecificMethodHighlight
"   autocmd!
"   autocmd LspTokenUpdate * lua HighlightConventionalParameter()
" augroup END

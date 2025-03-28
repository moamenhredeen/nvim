" Vim syntax file
" Language: Jlox
" Maintainer: Moamen Hredeen
" Latest Revision: 2025-03-19

if exists("b:current_syntax")
  finish
endif

" Keywords
syntax keyword yourlangKeyword if else while for return fun let const type struct this void interface not or and xor

syntax keyword yourlangbooleans true false

syntax keyword yourlangtypes boolean string int float

" Operators
syntax match yourlangOperator "\v\+|\-|\*|\/|\=|\=\=|\->|\!\="

" Strings
syntax region yourlangString start=/"/ skip=/\\"/ end=/"/
syntax region multilinestring start=/"""/ skip=/\\"/ end=/"""/

" Numbers
syntax match yourlangNumber "\v<\d+>"

" Comments
syntax match yourlangComment "//.*$"

" Set highlighting
highlight default link yourlangKeyword Keyword
highlight default link yourlangtypes Type
highlight default link yourlangbooleans Boolean
highlight default link yourlangOperator Operator
highlight default link yourlangString String
highlight default link yourlangNumber Number
highlight default link yourlangComment Comment

let b:current_syntax = "jlox"

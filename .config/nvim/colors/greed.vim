set bg=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name="greed"

" #99cc99
" #f2777a
" #6699cc
" #ffcc66
" #2d2d2d
" #cc99cc
" #66cccc
" #d3d0c8
" #f2f0ec


hi Normal      guifg=#d3d0c8  guibg=none
hi ErrorMsg    guifg=#f2777a  guibg=none
hi Visual      guifg=#2d2d2d  guibg=#f2f0ec  gui=undercurl  guisp=#f2f0ec
hi Todo        guifg=#6699cc  guibg=none     gui=bold
hi Search      guifg=#2d2d2d  guibg=#99cc99
hi IncSearch   guifg=#2d2d2d  guibg=#99cc99

" hi SpecialKey guifg=#99cc99
" hi Directory  guifg=#99cc99
hi Title      guifg=#d3d0c8   gui=bold
" hi WarningMsg guifg=#99cc99   guibg=none  gui=undercurl   guisp=#f2777a
" hi ModeMsg    guifg=#99cc99
" hi MoreMsg    guifg=#99cc99
" hi Question   guifg=#99cc99   gui=none
" hi NonText    guifg=#99cc99

" hi Menu       guifg=#99cc99
" hi WildMenu   guifg=#99cc99    guibg=#1dad11     gui=none
hi Pmenu      guifg=#99cc99   guibg=#2d2d2d
hi PmenuSel   guifg=#2d2d2d   guibg=#99cc99 gui=bold
" hi PmenuSbar  guifg=#99cc99   guibg=#66cccc
" hi PmenuThumb guifg=#99cc99   guibg=#99cc99

hi StatusLine   guifg=#2d2d2d   guibg=#d3d0c8   gui=bold
hi StatusLineNC guifg=#2d2d2d   guibg=#99cc99   gui=none
" hi VertSplit    guifg=#99cc99  guibg=none gui=none

" hi Folded     guifg=#99cc99 guibg=none gui=bold
" hi FoldColumn guifg=#99cc99 guibg=none gui=bold
" hi SignColumn guibg=none

hi LineNr       guifg=#99cc99 gui=none
hi CursorLineNr guifg=#99cc99 gui=bold
" hi CursorLine   guibg=#99cc99 gui=none
" hi CursorColumn guibg=#99cc99 gui=none
" hi CursorIM     guibg=#99cc99 gui=none
" hi MatchParen   guibg=#99cc99

" hi DiffAdd    guifg=#99cc99 guibg=none gui=none
" hi DiffDelete guifg=#99cc99 guibg=none gui=none
" hi DiffChange guifg=#99cc99 guibg=none gui=none
" hi DiffText   guifg=#99cc99 guibg=none gui=bold

"" Style
hi Bold       gui=bold
hi Underlined gui=underline
hi Italic     gui=italic
hi Ignore     gui=none
hi Error      guifg=none guibg=none gui=undercurl guisp=#f2777a

"" Comment
hi Comment         guifg=#6699cc
hi SpecialComment  guifg=#6699cc

"" Type
" hi Constant        guifg=#99cc99
" hi String          guifg=#99cc99
" hi Character       guifg=#99cc99
" hi Number          guifg=#99cc99
" hi Boolean         guifg=#99cc99
" hi Float           guifg=#99cc99

" hi Special         guifg=#99cc99
" hi SpecialChar     guifg=#99cc99
" hi Tag             guifg=#99cc99
" hi Debug           guifg=#99cc99
" hi Delimiter       guifg=#99cc99

"" Identifier     
hi Identifier      guifg=#99cc99
hi Function        guifg=#99cc99
hi Operator        guifg=#99cc99

"" Keyword
hi Statement       guifg=#ffcc66 gui=bold
" hi Conditional     guifg=#99cc99
" hi Repeat          guifg=#99cc99
" hi Label           guifg=#99cc99
" hi Keyword         guifg=#99cc99
" hi Exception       guifg=#99cc99

" hi Type            guifg=#99cc99
" hi StorageClass    guifg=#99cc99
" hi Structure       guifg=#99cc99
" hi Typedef         guifg=#99cc99

"" C/C++ Stuff
" hi PreProc   guifg=#99cc99
" hi PreCondit guifg=#99cc99
" hi Include   guifg=#99cc99
" hi Define    guifg=#99cc99
" hi Macro     guifg=#99cc99

"" Spell Check
hi SpellBad    guifg=#f2777a guibg=none gui=undercurl guisp=#f2777a
hi SpellCap    guifg=#ffcc66 guibg=none gui=undercurl guisp=#ffcc66
hi SpellLocal  guifg=#66cccc guibg=none gui=undercurl guisp=#66cccc

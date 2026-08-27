" Cangjie filetype detection.
"
" Covers plain sources (*.cj) and the standardized macro-expansion debug
" dumps (*.cj.macrocall — same language, emitted by the compiler when
" debugging macro expansions). tree-sitter.json declares both file types;
" this file makes Neovim agree so queries/cangjie/ engages for both.
autocmd BufRead,BufNewFile *.cj,*.cj.macrocall set filetype=cangjie

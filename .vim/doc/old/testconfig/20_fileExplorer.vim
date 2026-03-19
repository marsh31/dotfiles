" 20-fe.vim
"
" File explorer
"   NERDTree
"   nerdtree-git-plugin

" MARK: - NERDTree variable setting {{{1
" ===========================================
let g:NERDTreeShowBookmarks   = 1
let g:NERDTreeShowHidden      = 1
let g:NERDTreeQuitOnOpen      = 1


" MARK: - NERDTree keymapping setting {{{1
" ===========================================
let g:NERDTreeMapChangeRoot = "CR"



" MARK: - nerdtree-git-plugin {{{1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "Mod",
    \ "Staged"    : "Sta",
    \ "Untracked" : "Unt",
    \ "Renamed"   : "Ren",
    \ "Unmerged"  : "Unm",
    \ "Deleted"   : "Del",
    \ "Dirty"     : "Dirty",
    \ "Clean"     : "Clean",
    \ "Unknown"   : "Unk"
    \ }

augroup markdown-quick
	autocmd!
	autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
	autocmd Filetype markdown inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
	autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
	autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
	autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
	autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
	autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
	autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
	autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
	autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
	autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
	autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
	autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
	autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
augroup END

" 设立一个组,如果没有autocmd!这个命令,那vim将不会因为名字相同而有所区分,意思是,即使命令相同,也会为你重载一遍.他会把重名的组合成一个组,而不会替换
" 如果你加了autocmd!则会把同名的覆盖掉,而不是原来的组合在一起
" 当然不同名字的可以保留

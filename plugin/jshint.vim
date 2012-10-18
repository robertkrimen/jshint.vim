if !exists("g:jshintprg")
	let g:jshintprg="jshint"
endif

function! s:JSHint(cmd, args)

    " If no file is provided, use current file 
    if empty(a:args)
        let l:fileargs = expand("%")
    else
        let l:fileargs = a:args
    end

    let grepprg1=&grepprg
    let grepformat1=&grepformat
    try
        let &grepprg=g:jshintprg
        let &grepformat="%f: line %l\\,\ col %c\\, %m,%-G,%-G%s error,%-G%s errors,%-GLint Free!"
        silent execute a:cmd . " \"" . l:fileargs . "\""
    finally
        let &grepprg=grepprg1
        let &grepformat=grepformat1
    endtry

    redraw!

endfunction

command! -bang -nargs=* -complete=file JSHint call s:JSHint('grep<bang>',<q-args>)

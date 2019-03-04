set shiftwidth=4 tabstop=4
set backspace=indent,eol,start
set nu et
syntax on

let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif


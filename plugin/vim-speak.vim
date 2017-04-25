" Speak text out loud

if exists("g:loaded_vimspeak") || &cp || v:version < 700
  finish
endif
let g:loaded_vimspeak = 1

if !exists("g:speech_speed")
  let g:speech_speed = 300
endif

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][:col2 - 1]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! s:speak_text()
  let fifo = $HOME . '/.vim/mpv.fifo'
  let text = strtrans(s:get_visual_selection())
  let text = substitute(text, '!', '\\!', 'g')
  let text = substitute(text, '%', '\\%', 'g')
  let text = substitute(text, '#', '\\#', 'g')
  let text = substitute(text, '\^@', ' ', 'g')
  let text = substitute(text, "'", "'\"'\"'", 'g')
  if &spelllang == 'pt'
    let language = 'pt'
  else
    let language = 'en'
  endif
  silent exe '! mkfifo ' . fifo
  silent exe '! espeak -v ' . language . 
           \ ' -s ' . g:speech_speed . 
           \ ' --punct' .
           \ ' -k1' .
           \ " '" . text . "' --stdout " . 
           \ "| mpv --quiet --cache=1024 --input=file=" . fifo . 
           \ " - &> /dev/null && rm " . fifo . ' &'
  redraw!
endfunction

function! s:command_mplayer(command)
  let fifo = $HOME . '/.vim/mpv.fifo'
  if !empty(glob(fifo))
    silent exe '! echo "' . a:command '" > ' . fifo
    redraw!
  endif
endfunction

function! s:speak_line_number()
  let text = line('.')
  if &spelllang == "pt"
    let language = 'pt'
  else
    let language = 'en'
  endif
  let command = '! espeak -v ' . language . 
              \ ' -s ' . g:speech_speed . 
              \ " '" . text . "' &> /dev/null &"
  silent execute command
  redraw!
endfunction

vnoremap <silent> <c-s>     :<C-U>call <SID>speak_text()<CR>
nnoremap <silent> yp        :call <SID>command_mplayer('pause')<CR>
nnoremap <silent> yq        :call <SID>command_mplayer('quit')<CR>
nnoremap <silent> yg        :call <SID>command_mplayer('seek 10')<CR>
nnoremap <silent> yr        :call <SID>command_mplayer('seek -10')<CR>
nnoremap <silent> <leader>n :call <SID>speak_line_number()<CR>

# Vimspeak

This is a series of mappings I use to make vim speak text to me. Don't expect
much from it. You should read the plugin's code if you intend to use it, lest
it break your environment. Maybe one day I'll learn enough vimscript to turn
this into a proper plugin.

You can change the mappings in the last section of `plugin/vim-speak.vim`. You
can change the default speed of 300 words per minute by defining the variable
`g:speech_speed` in your `.vimrc`.

## Mappings

### Visual mode mappings

Mapping | Effect
--------|-----------------------------
`s`     | reads visually selected text

### Normal mode mappings

Mapping     | Effect
------------|-----------------------------------
`yp`        | pause text being read
`yq`        | stop reading
`yg`        | goes 10 seconds ahead
`yr`        | rewinds 10 seconds
`<leader>n` | speaks out the number of the line

# Vimspeak

This is a series of mappings I use to make vim speak text to me. Don't expect
much from it. You should read the plugin's code if you intend to use it, lest
it break your environment. Maybe one day when I learn vimscript I'll turn this
into a proper plugin. Or maybe you can do that for me and submit a pull
request.

You can change the mappings in the last section of the plugin file
`vim-speak.vim`

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

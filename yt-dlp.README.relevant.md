
#### Almost redundant options
While these options are almost the same as their new counterparts, there are some differences that prevents them being redundant

    -j, --dump-json                  --print "%()j"
    -F, --list-formats               --print formats_table
    --list-thumbnails                --print thumbnails_table --print playlist:thumbnails_table
    --list-subs                      --print automatic_captions_table --print subtitles_table


## Verbosity and Simulation Options:
    -j, --dump-json                 Quiet, but print JSON information for each
                                    video. Simulate unless --no-simulate is
                                    used. See "OUTPUT TEMPLATE" for a
                                    description of available keys
    -J, --dump-single-json          Quiet, but print JSON information for each
                                    url or infojson passed. Simulate unless
                                    --no-simulate is used. If the URL refers to
                                    a playlist, the whole playlist information
                                    is dumped in a single line

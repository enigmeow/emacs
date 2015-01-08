#set cdpath=$STORMBIRDS/src
setenv DISPLAY booger:0.0
setenv HOSTNAME `hostname`

set nonomatch 

#foreach i ( /usr/local/lib /usr/lib /lib)
#    setenv LD_LIBRARY_PATH "${i}:${LD_LIBRARY_PATH}"
#end

setenv PATH "."
foreach i ( /usr/bin /usr/sbin /bin /sbin /usr/local/bin /home/jsiegel/bin )
    setenv PATH "${i}:${PATH}"
end

setenv MANPATH /usr/man
foreach i ( /usr/share/man /usr/X11R6/man /usr/local/man  )
    setenv MANPATH "${i}:${MANPATH}"
end

setenv EDITOR /usr/bin/vim
setenv JoshSiegel 1
setenv BUILDTAG devel

# endif

limit core 0

set history=100 notify showdots filec symlinks=ignore
set autolist=beepnever listmax=50 correct=cmd autoexpand
set fignore = ( .o .dvi .bbl .aux .log .blg .dlog .ps \~ .orig .elc .mak .vcp )
set time = ( 2 "user=%U secs  system=%S secs  elapsed=%E secs  memory=%K Kb" )

if ( ${?prompt} ) then
  set prompt = "[%n@%m %c2] "
endif

if ( ${?term} ) then
  if ( $term == "xterm" ) then
    alias postcmd echo -n "]2\;${HOSTNAME}:${user}"
  endif
endif

if ( ${?DISPLAY} ) then
  alias start 'xterm -title "$shell:t @ $shorthost" -e /bin/tcsh &'
  foreach i ( chi-spdl1 chi-spdl2 chi-spdl3 chi-spdl4 chi-spdl5 chi-spdl6 chi-spdl7 njw-spd1 njw-spd2 njw-spdl4 njw-spdl5 njw-spdl6 njw-spdl7 njw-spdl8 njw-spdl9 njw-spdl10 njw-spdl11 njw-spdl12 njw-spdl13 njw-spdl14 njw-spdl15 njw-spdl16 njw-spdl17 njw-spdl18 njw-spdl19 njw-spdl20 njw-spdl21 njw-spdl22 njw-spdl24 njw-spdl25 njw-spdl26 njw-spdl27 njw-spdl28 njw-spdl29 njw-spdl30 njw-spdl31  njc-spd1 cer-spdl1 cer-spdl2 cer-spdl3 cer-spdl4 cer-spdl5 jumpdev3 jumpdev7 )
    alias ${i} ssh -x -f ${i} xterm -display ${DISPLAY} -e /bin/tcsh
    alias s${i} ssh -x -f speed@${i} xterm -display ${DISPLAY} -e /bin/tcsh
  end
endif

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

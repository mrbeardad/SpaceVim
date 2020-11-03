let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_type')
  syntax keyword cPosixType cc_t
  syntax keyword cPosixType speed_t
  syntax keyword cPosixType tcflag_t
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct termios
endif

if !exists('c_no_posix_constant')
  syntax keyword cPosixConstant NCCS
  syntax keyword cPosixConstant VEOF
  syntax keyword cPosixConstant VEOL
  syntax keyword cPosixConstant VERASE
  syntax keyword cPosixConstant VINTR
  syntax keyword cPosixConstant VKILL
  syntax keyword cPosixConstant VMIN
  syntax keyword cPosixConstant VQUIT
  syntax keyword cPosixConstant VSTART
  syntax keyword cPosixConstant VSTOP
  syntax keyword cPosixConstant VSUSP
  syntax keyword cPosixConstant VTIME
  syntax keyword cPosixConstant BRKINT
  syntax keyword cPosixConstant ICRNL
  syntax keyword cPosixConstant IGNBRK
  syntax keyword cPosixConstant IGNCR
  syntax keyword cPosixConstant IGNPAR
  syntax keyword cPosixConstant INLCR
  syntax keyword cPosixConstant INPCK
  syntax keyword cPosixConstant ISTRIP
  syntax keyword cPosixConstant IXANY
  syntax keyword cPosixConstant IXOFF
  syntax keyword cPosixConstant IXON
  syntax keyword cPosixConstant PARMRK
  syntax keyword cPosixConstant OPOST
  syntax keyword cPosixConstant ONLCR
  syntax keyword cPosixConstant OCRNL
  syntax keyword cPosixConstant ONOCR
  syntax keyword cPosixConstant ONLRET
  syntax keyword cPosixConstant OFDEL
  syntax keyword cPosixConstant OFILL
  syntax keyword cPosixConstant NLDLY
  syntax keyword cPosixConstant NL0
  syntax keyword cPosixConstant NL1
  syntax keyword cPosixConstant CRDLY
  syntax keyword cPosixConstant CR0
  syntax keyword cPosixConstant CR1
  syntax keyword cPosixConstant CR2
  syntax keyword cPosixConstant CR3
  syntax keyword cPosixConstant TABDLY
  syntax keyword cPosixConstant TAB0
  syntax keyword cPosixConstant TAB1
  syntax keyword cPosixConstant TAB2
  syntax keyword cPosixConstant TAB3
  syntax keyword cPosixConstant BSDLY
  syntax keyword cPosixConstant BS0
  syntax keyword cPosixConstant BS1
  syntax keyword cPosixConstant VTDLY
  syntax keyword cPosixConstant VT0
  syntax keyword cPosixConstant VT1
  syntax keyword cPosixConstant FFDLY
  syntax keyword cPosixConstant FF0
  syntax keyword cPosixConstant FF1
  syntax keyword cPosixConstant B0
  syntax keyword cPosixConstant B50
  syntax keyword cPosixConstant B75
  syntax keyword cPosixConstant B110
  syntax keyword cPosixConstant B134
  syntax keyword cPosixConstant B150
  syntax keyword cPosixConstant B200
  syntax keyword cPosixConstant B300
  syntax keyword cPosixConstant B600
  syntax keyword cPosixConstant B1200
  syntax keyword cPosixConstant B1800
  syntax keyword cPosixConstant B2400
  syntax keyword cPosixConstant B4800
  syntax keyword cPosixConstant B9600
  syntax keyword cPosixConstant B19200
  syntax keyword cPosixConstant B38400
  syntax keyword cPosixConstant CSIZE
  syntax keyword cPosixConstant CS5
  syntax keyword cPosixConstant CS6
  syntax keyword cPosixConstant CS7
  syntax keyword cPosixConstant CS8
  syntax keyword cPosixConstant CSTOPB
  syntax keyword cPosixConstant CREAD
  syntax keyword cPosixConstant PARENB
  syntax keyword cPosixConstant PARODD
  syntax keyword cPosixConstant HUPCL
  syntax keyword cPosixConstant CLOCAL
  syntax keyword cPosixConstant ECHO
  syntax keyword cPosixConstant ECHOE
  syntax keyword cPosixConstant ECHOK
  syntax keyword cPosixConstant ECHONL
  syntax keyword cPosixConstant ICANON
  syntax keyword cPosixConstant IEXTEN
  syntax keyword cPosixConstant ISIG
  syntax keyword cPosixConstant NOFLSH
  syntax keyword cPosixConstant TOSTOP
  syntax keyword cPosixConstant TCSANOW
  syntax keyword cPosixConstant TCSADRAIN
  syntax keyword cPosixConstant TCSAFLUSH
  syntax keyword cPosixConstant TCIFLUSH
  syntax keyword cPosixConstant TCIOFLUSH
  syntax keyword cPosixConstant TCOFLUSH
  syntax keyword cPosixConstant TCIOFF
  syntax keyword cPosixConstant TCION
  syntax keyword cPosixConstant TCOOFF
  syntax keyword cPosixConstant TCOON
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction cfgetispeed
  syntax keyword cPosixFunction cfgetospeed
  syntax keyword cPosixFunction cfsetispeed
  syntax keyword cPosixFunction cfsetospeed
  syntax keyword cPosixFunction tcdrain
  syntax keyword cPosixFunction tcflow
  syntax keyword cPosixFunction tcflush
  syntax keyword cPosixFunction tcgetattr
  syntax keyword cPosixFunction tcgetsid
  syntax keyword cPosixFunction tcsendbreak
  syntax keyword cPosixFunction tcsetattr
endif

let &cpo = s:save_cpo
unlet s:save_cpo


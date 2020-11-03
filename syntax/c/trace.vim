let s:save_cpo = &cpo
set cpo&vim

if !exists('c_no_posix_struct')
  syntax keyword cPosixStruct posix_trace_event_info
  syntax keyword cPosixStruct posix_trace_status_info
endif

if !exists('c_no_posix_struct')
  syntax keyword cPosixConstant POSIX_TRACE_ALL_EVENTS
  syntax keyword cPosixConstant POSIX_TRACE_APPEND
  syntax keyword cPosixConstant POSIX_TRACE_CLOSE_FOR_CHILD
  syntax keyword cPosixConstant POSIX_TRACE_FILTER
  syntax keyword cPosixConstant POSIX_TRACE_FLUSH
  syntax keyword cPosixConstant POSIX_TRACE_FLUSH_START
  syntax keyword cPosixConstant POSIX_TRACE_FLUSH_STOP
  syntax keyword cPosixConstant POSIX_TRACE_FLUSHING
  syntax keyword cPosixConstant POSIX_TRACE_FULL
  syntax keyword cPosixConstant POSIX_TRACE_LOOP
  syntax keyword cPosixConstant POSIX_TRACE_NO_OVERRUN
  syntax keyword cPosixConstant POSIX_TRACE_NOT_FLUSHING
  syntax keyword cPosixConstant POSIX_TRACE_NOT_FULL
  syntax keyword cPosixConstant POSIX_TRACE_INHERITED
  syntax keyword cPosixConstant POSIX_TRACE_NOT_TRUNCATED
  syntax keyword cPosixConstant POSIX_TRACE_OVERFLOW
  syntax keyword cPosixConstant POSIX_TRACE_OVERRUN
  syntax keyword cPosixConstant POSIX_TRACE_RESUME
  syntax keyword cPosixConstant POSIX_TRACE_RUNNING
  syntax keyword cPosixConstant POSIX_TRACE_START
  syntax keyword cPosixConstant POSIX_TRACE_STOP
  syntax keyword cPosixConstant POSIX_TRACE_SUSPENDED
  syntax keyword cPosixConstant POSIX_TRACE_SYSTEM_EVENTS
  syntax keyword cPosixConstant POSIX_TRACE_TRUNCATED_READ
  syntax keyword cPosixConstant POSIX_TRACE_TRUNCATED_RECORD
  syntax keyword cPosixConstant POSIX_TRACE_UNNAMED_USER_EVENT
  syntax keyword cPosixConstant POSIX_TRACE_UNTIL_FULL
  syntax keyword cPosixConstant POSIX_TRACE_WOPID_EVENTS
endif

if !exists('c_no_posix_function')
  syntax keyword cPosixFunction posix_trace_attr_destroy
  syntax keyword cPosixFunction posix_trace_attr_getclockres
  syntax keyword cPosixFunction posix_trace_attr_getcreatetime
  syntax keyword cPosixFunction posix_trace_attr_getgenversion
  syntax keyword cPosixFunction posix_trace_attr_getinherited
  syntax keyword cPosixFunction posix_trace_attr_getlogfullpolicy
  syntax keyword cPosixFunction posix_trace_attr_getlogsize
  syntax keyword cPosixFunction posix_trace_attr_getmaxdatasize
  syntax keyword cPosixFunction posix_trace_attr_getmaxsystemeventsize
  syntax keyword cPosixFunction posix_trace_attr_getmaxusereventsize
  syntax keyword cPosixFunction posix_trace_attr_getname
  syntax keyword cPosixFunction posix_trace_attr_getstreamfullpolicy
  syntax keyword cPosixFunction posix_trace_attr_getstreamsize
  syntax keyword cPosixFunction posix_trace_attr_init
  syntax keyword cPosixFunction posix_trace_attr_setinherited
  syntax keyword cPosixFunction posix_trace_attr_setlogfullpolicy
  syntax keyword cPosixFunction posix_trace_attr_setlogsize
  syntax keyword cPosixFunction posix_trace_attr_setmaxdatasize
  syntax keyword cPosixFunction posix_trace_attr_setname
  syntax keyword cPosixFunction posix_trace_attr_setstreamfullpolicy
  syntax keyword cPosixFunction posix_trace_attr_setstreamsize
  syntax keyword cPosixFunction posix_trace_clear
  syntax keyword cPosixFunction posix_trace_close
  syntax keyword cPosixFunction posix_trace_create
  syntax keyword cPosixFunction posix_trace_create_withlog
  syntax keyword cPosixFunction posix_trace_event
  syntax keyword cPosixFunction posix_trace_eventid_equal
  syntax keyword cPosixFunction posix_trace_eventid_get_name
  syntax keyword cPosixFunction posix_trace_eventid_open
  syntax keyword cPosixFunction posix_trace_eventset_add
  syntax keyword cPosixFunction posix_trace_eventset_del
  syntax keyword cPosixFunction posix_trace_eventset_empty
  syntax keyword cPosixFunction posix_trace_eventset_fill
  syntax keyword cPosixFunction posix_trace_eventset_ismember
  syntax keyword cPosixFunction posix_trace_eventtypelist_getnext_id
  syntax keyword cPosixFunction posix_trace_eventtypelist_rewind
  syntax keyword cPosixFunction posix_trace_flush
  syntax keyword cPosixFunction posix_trace_get_attr
  syntax keyword cPosixFunction posix_trace_get_filter
  syntax keyword cPosixFunction posix_trace_get_status
  syntax keyword cPosixFunction posix_trace_getnext_event
  syntax keyword cPosixFunction posix_trace_open
  syntax keyword cPosixFunction posix_trace_rewind
  syntax keyword cPosixFunction posix_trace_set_filter
  syntax keyword cPosixFunction posix_trace_shutdown
  syntax keyword cPosixFunction posix_trace_start
  syntax keyword cPosixFunction posix_trace_stop
  syntax keyword cPosixFunction posix_trace_timedgetnext_event
  syntax keyword cPosixFunction posix_trace_trid_eventid_open
  syntax keyword cPosixFunction posix_trace_trygetnext_event
endif

let &cpo = s:save_cpo
unlet s:save_cpo


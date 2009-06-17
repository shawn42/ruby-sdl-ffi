#--
#
# This file is one part of:
#
# Ruby-SDL-FFI - Ruby-FFI bindings to SDL
#
# Copyright (c) 2009 John Croisant
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#++


module SDL

  CD_ERROR     = -1
  CD_TRAYEMPTY = 0
  CD_STOPPED   = 1
  CD_PLAYING   = 2
  CD_PAUSED    = 3

  AUDIO_TRACK  = 0x00
  DATA_TRACK   = 0x04
  MAX_TRACKS   = 99

  class CDtrack < FFI::Struct
    layout(
           :id,     :uint8,
           :type,   :uint8,
           :unused, :uint16,
           :length, :uint32,
           :offset, :uint32
           )
  end

  class CD < FFI::Struct
    layout(
           :id,        :int,
           :status,    SDL::ENUM,
           :numtracks, :int,
           :cur_track, :int,
           :cur_frame, :int,
           :track,     [CDtrack, SDL::MAX_TRACKS+1]
           )
  end

  CD_FPS = 75

  attach_sdl_function :CDNumDrives, [  ], :int
  attach_sdl_function :CDName, [ :int ], :string
  attach_sdl_function :CDOpen, [ :int ], :pointer
  attach_sdl_function :CDStatus, [ :pointer ], SDL::ENUM
  attach_sdl_function :CDPlayTracks, [ :pointer, :int, :int, :int, :int ], :int
  attach_sdl_function :CDPlay, [ :pointer, :int, :int ], :int
  attach_sdl_function :CDPause, [ :pointer ], :int
  attach_sdl_function :CDResume, [ :pointer ], :int
  attach_sdl_function :CDStop, [ :pointer ], :int
  attach_sdl_function :CDEject, [ :pointer ], :int
  attach_sdl_function :CDClose, [ :pointer ], :void

end
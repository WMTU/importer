module Scot
  class ScottChunk < BinData::Record
    endian  :little

    string  :id,                  value:          'scot'
    int32   :chunk_size,          value:          424
    int8    :alter,               value:          0        # "scratchpad" area used by program.  Should be ZERO

    # The following byte is interpreted as eight flag bits
    bit1    :attrib_7,            value:          1        # 1 = attrib2 field is valid and contains additional flags
    bit1    :attrib_6,            initial_value:  0        # 1 = this file has segments and a segment order to play it back
    bit1    :attrib_5,            value:          0        # reserved for future use
    bit1    :attrib_4,            value:          0        # 1 if file is a rotation look-up table for a new rotation scheme (obsolete)
    bit1    :attrib_3,            initial_value:  0        # 1 if file is a VOICE TRACK
    bit1    :attrib_2,            initial_value:  0        # format of ascii_length field:
                                                              #   0 = "MM:SS"
                                                              #   1 = "HMMSS" (for if length exceeds 99 minutes 59 seconds)
    bit1    :attrib_1,            value:          1        # interpretation of ascii_length field:
                                                              #   0 = time until the end of the audio file (obsolete)
                                                              #   1 = time until EOM
    bit1    :attrib_0,            value:          0        # 1 indicates file is not audio but parent of (obsolete) rotation set

    int16   :art_num,             value:          0        # "scratch pad" area to track position of artist. Store: ZERO
    string  :title,               length:         43,
                                  pad_byte:       ' '      # name of spot or title of song (padded with spaces)
    string  :copy,                length:         4,
                                  initial_value:  '????'   # ASCII copy number
    string  :padd,                value:          ' '      # future expansion of copy number, Store: SPACE
    string  :ascii_length,        length:         5,
                                  pad_front:      true,
                                  pad_byte:       ' '      # length expressed in ASCII, subject to the attributes in attrib above,
                                                              #   FRONT-padded with a SPACE so that colon is always in the same location

    # offset from beginning of file to beginning of usable audio (cue-in point)
    int16   :start_seconds,       initial_value:  0        # seconds portion of offset
    int16   :start_hundredths,    initial_value:  0        # hundredths portion of offset
    # offset from beginning of usable audio (cue-in point) to end of file
    int16   :end_seconds                                      # seconds portion of offset
    int16   :end_hundredths                                   # hundredths portion of offset

    # DATES
    string  :start_date,          length:         6,
                                  initial_value:  '000000' # starting air date in mmddyy form
    string  :end_date,            length:         6,
                                  initial_value:  '999999' # ending air date in mmddyy form

    # HOURS
    uint8   :start_hour,          initial_value:  128      # starting hour on start_date, stored as: (hour, 0-23) + 128
    uint8   :end_hour,            initial_value:  0        # ending hour on end_date, stored as: (hour, 0-23) + 128

    string  :digital,             length:         1,
                                  initial_value:  'A'      # "D" = direct digital recording, "A" = analog
    int16   :sample_rate                                      # sample rate in Hz / 100
    string  :stereo,              length:         1,
                                  initial_value:  'S'      # "M" = mono, "S" = stereo
    uint8   :compression,         initial_value:  10       # indicates compression type:
                                                              #   For ANTEX card:
                                                              #   ----------------------------------------------------
                                                              #     0 = PCM16
                                                              #     1 = PCM8
                                                              #     2 = PCMU8
                                                              #     3 = ADPCM1
                                                              #     4 = ADPCME
                                                              #     5 = CDIB
                                                              #     6 = CDIC
                                                              #     7 = DOLBYAC2
                                                              #     8 = MPEG (further defined by info in format chunk)
                                                              #     9 = APTX
                                                              #    10 = WAVE
                                                              #   For APT card:
                                                              #   ----------------------------------------------------
                                                              #   237 = not compressed
                                                              #   251 = compressed (aptx)
    int32   :eom_start                                        # length in tenths of a second from beginning of file to start of EOM
    uint16  :eom_length,          initial_value:  0        # length of the EOM in hundredths of a second (length from start of EOM to end of file)

    # Extended attributes
    bit1    :attrib2_31,          value:          0        # reserved for future use
    bit1    :attrib2_30,          value:          0        # reserved for future use
    bit1    :attrib2_29,          value:          0        # reserved for future use
    bit1    :attrib2_28,          value:          0        # reserved for future use
    bit1    :attrib2_27,          value:          0        # reserved for future use
    bit1    :attrib2_26,          value:          0        # reserved for future use
    bit1    :attrib2_25,          value:          0        # reserved for future use
    bit1    :attrib2_24,          value:          0        # reserved for future use
    bit1    :attrib2_23,          value:          0        # reserved for future use
    bit1    :attrib2_22,          value:          0        # reserved for future use
    bit1    :attrib2_21,          value:          0        # reserved for future use
    bit1    :attrib2_20,          value:          0        # reserved for future use
    bit1    :attrib2_19,          value:          0        # reserved for future use
    bit1    :attrib2_18,          value:          0        # reserved for future use
    bit1    :attrib2_17,          value:          0        # reserved for future use
    bit1    :attrib2_16,          value:          0        # reserved for future use
    bit1    :attrib2_15,          value:          0        # reserved for future use
    bit1    :attrib2_14,          value:          0        # reserved for future use
    bit1    :attrib2_13,          value:          0        # reserved for future use
    bit1    :attrib2_12,          value:          0        # reserved for future use
    bit1    :attrib2_11,          value:          0        # reserved for future use
    bit1    :attrib2_10,          value:          0        # reserved for future use
    bit1    :attrib2_9,           value:          0        # reserved for future use
    bit1    :attrib2_8,           initial_value:  0        # 1 = the dayparting bit-array is valid
    bit1    :attrib2_7,           initial_value:  0        # 1 = this file originated as a netcatch/dtmf recording
    bit1    :attrib2_6,           initial_value:  0        # 1 = archive this file after one play
    bit1    :attrib2_5,           initial_value:  0        # 1 = delete this file after one play
    bit1    :attrib2_4,           initial_value:  0        # 1 = this file contains valid hook-mode values
    bit1    :attrib2_3,           initial_value:  0        # 1 = the 4 triggerX fields contain valid values
    bit1    :attrib2_2,           initial_value:  0        # 1 = use desired_length field (stretch & squeeze)
    bit1    :attrib2_1,           initial_value:  0        # 1 = the vt_eom_ovr field is valid
    bit1    :attrib2_0,           initial_value:  0        # 1 = do not play this file on the internet

    # HOOKS (for playing short song hooks out of song files)
    uint32  :hook_start_ms,       initial_value:  0        # number of milliseconds from start of file to start of hook
    uint32  :hook_eom_ms,         initial_value:  0        # number of milliseconds from start of hook to EOM of hook
    uint32  :hook_end_ms,         initial_value:  0        # number of milliseconds from start of hook to end of hook
    uint32  :cat_font_color,      value:          0        # category font color, future use
    uint32  :cat_color,           value:          0        # category background color, highest bit is valid bit:
                                                              #   lower 31 bits are raw 4-byte color
    int32   :seg_eom_pos,         value:          0        # location of EOM when dealing with a file containing internal segments. Store: ZERO

    # VOICE TRACK support
    #   These two values represent the EOM override point:
    #         0 = normal EOM of source before VT is used
    #     not 0 = these values, representing distance into previous source, are used
    int16   :vt_start_seconds,    initial_value:  0        # seconds portion of new EOM
    int16   :vt_start_hundredths, initial_value:  0        # hundredths portion of new EOM
    #   Category and copy number of previous source, used to verify linkage to the VT
    #     spaces = no check is made and VT is allowed to follow any event
    string  :before_cat,          length:         3,
                                  initial_value:  '   '    # category of source
    string  :before_copy,         length:         4,
                                  initial_value:  '    '   # copy number of source
    string  :before_padd,         value:          ' '      # future expansion of copy number of source
    #   Category and copy number of upcoming source, used to verify linkage to the VT
    #     spaces = no check is made and VT is allowed to be followed by any event
    string  :after_cat,           length:         3,
                                  initial_value:  '   '    # category of source
    string  :after_copy,          length:         4,
                                  initial_value:  '    '   # copy number of source
    string  :after_padd,          value:          ' '      # future expansion of copy number of source

    array   :dayparting,          initial_length: 168 do
      bit1  initial_value: 0
    end                                                       # one bit per hour, per day (1 bit/hour * 24 hours/day * 7 days = 168 bit fields)

    skip                          length:         108      # reserved for future use

    # EVENT INFORMATION, fill with spaces if not used
    string  :artist,              length:         34,
                                  pad_byte:       ' '      # author of spot or artist of song (padded with spaces)
    string  :trivia,              length:         34,
                                  pad_byte:       ' '      # typically album of song (padded with spaces)
    string  :intro,               length:         2,
                                  pad_front:      true,
                                  pad_byte:       '0'      # ASCII length of talk-up time (intro) in seconds
    string  :end_type,            length:         1,
                                  initial_value:  ' '      # ASCII character indicating nature of song ending; examples:
                                                              #   "F" = fade out
                                                              #   "C" = cut out
    string  :year,                length:         4        # four digit ASCII year

    int8    :obsolete2,           value:          0        # reserved for future use, Store: ZERO
    uint8   :hour_recorded,       initial_value:  128      # hour of recording, stored as: (hour, 0-23) + 128
    string  :date_recorded,       length:         6,
                                  initial_value:  '000000' # date of recording, in mmddyy form
    int16   :mpeg_bit_rate,       initial_value:  0        # for an MPEG file -> bit rate / 1000
    uint16  :pitch,               initial_value:  33768    # playback speed as percentage of original speed, multiplied by ten
                                                              #   highest bit 1 = data is valid
                                                              #   second highest bit reserved for possible override flag, store 0
    uint16  :play_level,          initial_value:  21845    # lower 15 bits range from 0 (loudest) to 32767 (OFF)
                                                              #   highest bit 1 = data is valid
                                                              #   NOTE: this scheme will soon be considered the "old style":
                                                              #     If special value 21,845 (with highest bit NOT set) appears here,
                                                              #       new_play_level should be used to set the play level by percent
    uint8   :len_valid,           initial_value:  128      # if high bit set, next four bytes are valid, plus remaining seven bits are valid as flags
                                                              # the next highest bit will probably control the interpretation of the highest bit in playlevel
                                                              #   if valid but off, it is a validation bit
                                                              #   if valid and on, the high playlevel can indicate %100+
    uint32  :file_length                                      # absolute total size of the file in bytes
    uint16  :new_play_level,      initial_value:  33768    # playback level as percentage of "standard" level, multiplied by ten
                                                              #   highest bit 1 = value is valid
    uint32  :chop_size,           initial_value:  0        # hundredths of seconds removed from audio middle
                                                              #   highest bit 1 = data is valid
    uint32  :vt_eom_ovr,          initial_value:  0        # milliseconds to subtract from pre-cut EOM
    uint32  :desired_length,      initial_value:  0        # override length in hundredths of seconds within which this event should be forced to play back
                                                              #   (from beginning of audio to EOM point)
                                                              #   0 = no "squeezing" is called for
    # Trigger points within the audio:
    #   Highest byte:
    #     1-255 = ID number referring to the source of the trigger
    #   Three lower bytes:
    #     length in tenths of seconds from beginning of audio to trigger point
    #   If not used, must contain 0
    uint32  :trigger1,            initial_value:  0
    uint32  :trigger2,            initial_value:  0
    uint32  :trigger3,            initial_value:  0
    uint32  :trigger4,            initial_value:  0
    skip                          length:         33       # fill out the rest of the chunk
  end
end

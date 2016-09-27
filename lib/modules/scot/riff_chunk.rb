module Scot
  class RiffChunk < BinData::Record
    endian        :little

    string        :id,            value: 'RIFF'
    int32         :chunk_size,    value: lambda {
                                              4 + format_chunk.num_bytes + scott_chunk.num_bytes +
                                              fact_chunk.num_bytes + data_chunk.num_bytes
                                            }
    string        :format,        value: 'WAVE'
    format_chunk  :format_chunk
    scott_chunk   :scott_chunk
    fact_chunk    :fact_chunk
    data_chunk    :data_chunk
  end
end

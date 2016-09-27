module Scot
  class DataChunk < BinData::Record
    endian  :little

    string  :id,          value: 'data'
    int32   :chunk_size,	value: lambda { data.length }
    string  :data,        read_length: :chunk_size
  end
end

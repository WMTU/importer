module Scot
  class File
		attr_accessor :file
		attr_accessor :data

    def initialize(file)
      @file = file
			@data = RiffChunk.new
    end

		def read
      raise ArgumentError, 'Given file does not exist' unless File.exist? file

			File.open(file, "rb") do |i|
				@data.read(i)
			end
		end

		def write
			File.open(file, "wb") do |o|
				@data.write(o)
			end
  end
end

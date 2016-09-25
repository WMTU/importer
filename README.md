# importer

Intended to eventually be a web-based application for uploading audio files, converting them to the Scott Studios custom WAVE file format, and sending them to a folder on a different machine for import into the WideOrbit Automation for Radio system.

Right now, scot.rb defines the structure of the Scott Studios format using the Record class from the BinData gem; once an instance of RiffChunk is fully populated, a Scott Studios WAVE file can be written using the write(file) method inherited from BinData::Record.

The test.rb script fills out fields in the chunks which comprise the Scott Format with values from the audio file "inputfile" and saves it out to "inputfile.wav"

## Dependencies
 - Ruby and bundler
 - bindata gem
 - ffmpeg
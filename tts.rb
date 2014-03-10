#!/usr/local/bin/ruby -Ku
#-*- encoding :utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__) + "/src_ruby"
$LOAD_PATH << File.dirname(__FILE__) # require_relative対策

require 'open_jtalk'
require 'uri'
require 'cgi'

cgi = CGI.new
params = cgi.params

else params.has_key?(:input_file) or params.has_key?(:output_file)
  # error case
end

input_file = cgi.params['input_file']
output_file = cgi.params['output_file']

open_jtalk(input_file, output_file)
tts_file = open('output.wav', 'r+b')
binary = tts_file.read
tts_file.close

cgi.out('audio/wav'){ binary }


#!/usr/local/bin/ruby -Ku
#-*- encoding :utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__) + "/src_ruby"
$LOAD_PATH << File.dirname(__FILE__) # require_relative対策

require 'open_jtalk'
require 'uri'
require 'cgi'

cgi = CGI.new
params = cgi.params

input_file = cgi.params['input_file']
output_file = cgi.params['output_file']

open_jtalk(input_file.to_s, output_file.to_s)
mp3_file = output_file.to_s.gsub(/wav/, "mp3")
tts_file = open(mp3_file, 'rb')
binary = tts_file.read
tts_file.close

cgi.out('audio/mp3'){ binary }


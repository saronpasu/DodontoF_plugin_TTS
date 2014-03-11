#!/usr/local/bin/ruby -Ku
#-*- encoding :utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__) + "/src_ruby"
$LOAD_PATH << File.dirname(__FILE__) # require_relative対策

=begin
Google TTSさんの代理です。
talkerProxy さんから呼び出されて、TTS したものを TextTalker.as さんへ返します。
=end

require 'open_jtalk'
require 'fileutils'
require 'uri'
require 'cgi'

# 音声ファイルを配置するディレクトリ。
VOICE_PATH = "sound/tts/"

cgi = CGI.new
params = cgi.params

input_file = VOICE_PATH + cgi.params['input_file'].to_s
output_file = VOICE_PATH + cgi.params['output_file'].to_s

open_jtalk(input_file, output_file)

FileUtils.remove_file(input_file, true) if FileTest.exist?(input_file)
FileUtils.remove_file(output_file, true) if FileTest.exist?(input_file)

mp3_file = output_file.to_s.gsub(/wav/, "mp3")
tts_file = open(mp3_file, 'rb')
binary = tts_file.read
tts_file.close

cgi.out('audio/mp3'){ binary }


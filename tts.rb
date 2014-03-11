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

# CGI インスタンス生成
cgi = CGI.new

# クエリからファイル名を取得する
input_file = VOICE_PATH + cgi.params['uid'].to_s + '.txt'
output_file = VOICE_PATH + cgi.params['uid'].to_s + '.wav'

# Open JTalk でテキストから音声ファイルを生成
open_jtalk(input_file, output_file)

# 一時ファイルを削除する
FileUtils.remove_file(input_file, true) if FileTest.exist?(input_file)
FileUtils.remove_file(output_file, true) if FileTest.exist?(output_file)

# MP3ファイルを読み込む
mp3_file = output_file.gsub(/wav$/, "mp3")
tts_file = open(mp3_file, 'rb')
binary = tts_file.read
tts_file.close

# MP3 をレスポンスとして返す
cgi.out('audio/mpeg'){ binary }


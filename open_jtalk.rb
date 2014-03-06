#-*- encoding :utf-8 -*-

# 名前空間の重複防止のため、モジュール化しています。
module OPEN_JTalk
  # HTS_Engine_API のパスを記入して下さい。
  HTS_ENGINE_PATH = 'hts_engine'
  # Open JTalk のパスを記入して下さい。
  OPEN_JTALK_PATH = 'open_jtalk'
  # Open JTalk の UTF-8 用辞書ディレクトリを指定して下さい。
  DICT_PATH = OPEN_JTALK_PATH+'/dic'
  # Open JTalk の 音声話者ファイルを指定して下さい。
  VOICE_PATH = OPEN_JTALK_PATH+'/share/voices/mei_normal.htsvoice'
  # デフォルト（無指定）時の出力ファイル名です。
  DEFAULT_OUTPUT_FILE = 'output.wav'
end

=begin rdoc
  Open JTalk を呼び出すラッパメソッドです。
  OPEN_JTalkモジュールにより、いくつかの引数は初期設定されています。
  使い方は、このメソッドを呼び出すことで、指定されたテキストファイルを読み込み。
  指定されたファイル名で音声バイナリファイルを出力します。

  引数
    input_file[必須]    入力するテキストファイルを指定して下さい。(UTF-8のみ)
    output_file[省略可] 出力する音声ファイル名を指定して下さい。
                        無指定の場合は、デフォルトのファイル名で出力されます。
    voice[省略可]       音声話者ファイルを指定して下さい。
                        無指定の場合は、MMD_Agent-1.4の話者「mei」が指定されます。

   返り値
     true               正常終了時。
     false              異常終了時。

=end
def open_jtalk(input_file, output_file = nil, voice = nil)
  output_file ||= OPEN_JTalk::DEFAULT_OUTPUT_FILE
  voice ||= OPEN_JTalk::VOICE_PATH
  command = OPEN_JTalk::OPEN_JTALK_PATH+'/bin/open_jtalk'+
    ' -m ' +voice+
    ' -x ' +OPEN_JTalk::DICT_PATH+
    ' -ow '+output_file+
    ' '    +input_file
  return system(command)
end



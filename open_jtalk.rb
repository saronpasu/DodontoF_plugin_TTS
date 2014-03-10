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
  VOICE = 'mei_normal'
  # Open JTalk の 音声話者パス
  VOICE_PATH = OPEN_JTALK_PATH+'/share/voices/'
  # デフォルト（無指定）時の出力ファイル名です。
  DEFAULT_OUTPUT_FILE = 'output.wav'
  # Lame のパス
  LAME_PATH = 'lame'
end

=begin rdoc
  Open JTalk を呼び出すラッパメソッドです。
  OPEN_JTalkモジュールにより、いくつかの引数は初期設定されています。
  使い方は、このメソッドを呼び出すことで、指定されたテキストファイルを読み込み。
  指定されたファイル名で音声バイナリファイルを出力します。

  FreeBSD9.1 では、旧バージョンの Open Jtalk しか動作しませんでした。
  なので、 FreeBSD9.1 環境では異なる引数指定をするようにしています。

  引数
    input_file[必須]    入力するテキストファイルを指定して下さい。(UTF-8のみ)
    output_file[省略可] 出力する音声ファイル名を指定して下さい。
                        無指定の場合は、デフォルトのファイル名で出力されます。
    voice[省略可]       音声話者ファイルを指定して下さい。
                        無指定の場合は、MMD_Agentの話者「mei_normal」が指定されます。

   返り値
     true               正常終了時。
     false              異常終了時。

=end
def open_jtalk(input_file, output_file = nil, voice = nil)
  output_file ||= OPEN_JTalk::DEFAULT_OUTPUT_FILE
  voice ||= 'mei_normal'
  command = Array.allocate
  command<< OPEN_JTalk::OPEN_JTALK_PATH+'/bin/open_jtalk'
  unless `uname`.match(/FreeBSD/) then
    command<< ' -m '+OPEN_JTalk::VOICE_PATH+voice+'.htsvoice'
  else
    command<< ' -td '+OPEN_JTalk::VOICE_PATH+voice+'/tree-dur.inf'
    command<< ' -tm '+OPEN_JTalk::VOICE_PATH+voice+'/tree-mgc.inf'
    command<< ' -tf '+OPEN_JTalk::VOICE_PATH+voice+'/tree-lf0.inf'
    command<< ' -tl '+OPEN_JTalk::VOICE_PATH+voice+'/tree-lpf.inf'
    command<< ' -md '+OPEN_JTalk::VOICE_PATH+voice+'/dur.pdf'
    command<< ' -mm '+OPEN_JTalk::VOICE_PATH+voice+'/mgc.pdf'
    command<< ' -mf '+OPEN_JTalk::VOICE_PATH+voice+'/lf0.pdf'
    command<< ' -ml '+OPEN_JTalk::VOICE_PATH+voice+'/lpf.pdf'
    command<< ' -dm '+OPEN_JTalk::VOICE_PATH+voice+'/mgc.win1'
    command<< ' -dm '+OPEN_JTalk::VOICE_PATH+voice+'/mgc.win2'
    command<< ' -dm '+OPEN_JTalk::VOICE_PATH+voice+'/mgc.win3'
    command<< ' -df '+OPEN_JTalk::VOICE_PATH+voice+'/lf0.win1'
    command<< ' -df '+OPEN_JTalk::VOICE_PATH+voice+'/lf0.win2'
    command<< ' -df '+OPEN_JTalk::VOICE_PATH+voice+'/lf0.win3'
    command<< ' -a 0.07'
    command<< ' -u 0.0'
    command<< ' -em '+OPEN_JTalk::VOICE_PATH+voice+'/tree-gv-mgc.inf'
    command<< ' -ef '+OPEN_JTalk::VOICE_PATH+voice+'/tree-gv-lf0.inf'
    command<< ' -cm '+OPEN_JTalk::VOICE_PATH+voice+'/gv-mgc.pdf'
    command<< ' -cf '+OPEN_JTalk::VOICE_PATH+voice+'/gv-lf0.pdf'
    command<< ' -jm 0.5'
    command<< ' -jf 1.2'
    command<< ' -k '+OPEN_JTalk::VOICE_PATH+voice+'/gv-switch.inf'
    command<< ' -jl 1.0'
  end
  command<< ' -x '+OPEN_JTalk::DICT_PATH
  command<< ' -ow '+output_file
  command<< ' '+input_file
  result = system(command.join)
  if result then
    lame_command = Array.allocate
    lame_command<< OPEN_JTalk::LAME_PATH+'/bin/lame'
    lame_command<< ' '+output_file
    lame_command<< ' '+output_file.gsub(/wav/, 'mp3')
    system(lame_command)
  end
  return result
end



#!/usr/bin/ruby -Ku
#-*- encoding: utf-8 -*-

require 'open_jtalk'

#=begin 本番環境ではコメントアウトして使って下さい。
  require 'fileutils'
#=end

=begin rdoc
  このクラスを DodontoFServer さんに include するか。
  DodontoFServer さんのインスタンスに extend して使って下さい。
  DodontoFServer さんが既に読み込まれている前提なので。

  src_ruby/config.rb に新しいフラグを用意してもいいですか？
  $canTalk を使おうか迷いましたが。名前空間被るのは良くないと思ったので新設しようかと。

  src_ruby/config.rb のグローバル変数
  $useTTS = true の場合にのみ、このクラスを呼び出して使って下さい。
  試験機能なので、デフォルトでは false 推奨です。

=end
class DodontoFServerTTS
  
  # WEBIFのコマンドパーサ(case 文) から呼ばれるメソッド
  # createTTS 辺りの名前で case 文判定していただけると良いかと思います。
  # DodontoFServer#analizeCommand メソッドへ
  # commands ハッシュ へ追加で ['createTTS', hasReturn] というのが望ましいかと。
  def sendWebIfCreateTTS
    logging("sendWebIfCreateTTS begin")
    saveData = {}
    
    input_file = getRequestData("input_file")
    output_file = getRequestData("output_file")
    # 追加ボイスは未実装です。
    # voice_type = getRequestData('voice_type')
    
    # create TTS voice file.
    logging("create TTS voice file: "+input_file)
    saveData["result"] = open_jtalk(input_file, output_file)
    logging("sendWebIfCreateTTS end")

    return saveData
  end
  
  # WEBIFのコマンドパーサ(case 文) から呼ばれるメソッド
  # deleteTTS 辺りの名前で case 文判定していただけると良いかと思います。
  # DodontoFServer#analizeCommand メソッドへ
  # commands ハッシュ へ追加で ['deleteTTS', hasReturn] というのが望ましいかと。
  def sendWebIfDeleteTTS
    logging("sendWebIfDeleteTTS begin")
    saveData = {}
    
    target_file = getRequestData('target_file')
    logging("delete TTS voice file.")
    FileUtils.remove_file(target_file) if FileTest.exists?(target_file)
    saveData['result'] = !FileTest.exists?(target_file)
    logging("sendWebIfDeleteTTS end")

    return saveData
  end
end


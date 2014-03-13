## 開発者向け情報
* こちらは開発者向けの情報です。

## 依存しているミドルウェア
* Open JTalk [URL](http://open-jtalk.sourceforge.net/)
* HTS engine API [URL](http://hts-engine.sourceforge.net/)
* MMDAgent Example [URL](http://www.mmdagent.jp/)
* LAME [URL](http://lame.sourceforge.net/)


## 導入に必要な環境
* Unix
    * サーバ利用を前提としているため、OSXやWindowsOSは対象外です。
    * FreeBSD9.1 には、旧バージョンの Open JTalkで対応しています。
* wget
* tar
* unzip
    * これらのコマンドが導入されていない場合は、 apt または yum で導入して下さい。
* ruby
    * 現在(2014-03-06)の時点で安定版とされているバージョン 2.0 系を対象としています。
    * しかし、どどんとふの推奨環境が。まだ、バージョン 1.8 系のため、互換動作を前提としています。


## 導入手順
1. 当プロジェクトサイトより、ソースコードまたはパッケージを取得する。
2. README をざっと目を通す。(*推奨*)
3. Open JTalk インストールスクリプトに実行権限を付与する。
    * インストールスクリプトは *open_jtalk_install.sh* というファイル名です。
    * $ chmod +x open_jtalk_install.sh
3. Open JTalk インストールスクリプトを実行する。(root 権限でなくても良い)
    * $ ./open_jtalk_install.sh
        * 実行すると、 open_jtalk というディレクトリと hts_engine というディレクトリができます。
        * どどんとふの実行環境に合わせて、これらのディレクトリをまるごと移動して下さい。
        * [*注意事項*] open_jtalk と hts_engine は同じディレクトリで動作するようにしています。
4. サンプルスクリプトで動作確認をしてみる。
    * $ chmod +x sample.rb
    * $ ruby sample.rb
    * これでエラーがでる場合は、次の内容を実行してみて下さい。
    * $ chmod +x sample.sh
    * $ ./sample.sh
        * この結果、 sample.txt の内容が、 sample.wav 音声ファイルとして出力されれば
        * Open JTalk 環境は正常に動作しています。
5. ここから先はまだ開発途中です。しばらくお待ちください。


    * [*最終更新: 2014-03-10*]

## 内部処理の概要
[*概要*]

1. このプラグインは、どどんとふ本体ファイルと差し替えて使用する形態をとります。
2. open_jtalk_install.sh を実行すると、必要なミドルウェア(lame以外)が揃います。
3. 既存のTTS(Google 非公式 TTS WEB API)を、Open JTalk へ差し替えた内容になっています。
4. 処理内容を説明します。

[*前提条件*]

1. $canTalk = true であること。
2. ミドルウェアが導入され、ファイルの差し替えが行われていること。

[*処理内容*]

1. TextTalker.as(ActionScript)が、 talkerProxy.php へチャット内容をリクエストします。
2. talkerProxy.php で、チャット内容の正規表現置換が行われます(くまかばさんありがとう！)
3. talkerProxy.php が、チャット内容をテキストファイルに保存します。(一時ファイルです)
4. talkerProxy.php が、tts.rbというCGIへユニークIDをクエリとしてリクエストします。
5. tts.rb が、受け取ったユニークIDを元にテキストファイルを特定します。
6. tts.rb が、 Open JTalk を実行し、チャット内容をWAVE音声ファイルへ変換します。
7. tts.rb が、 LAME を実行し、WAVE音声ファイルをMP3音声ファイルへ変換します。
8. tts.rb が、talkerProxy.php へMP3音声バイナリをレスポンスとして返します。
9. tts.rb が、不要になった一時ファイル(テキスト、WAVE音声ファイル）を削除します。
10. TextTalker.as が、 talkerProxy.php から MP3音声バイナリのレスポンスを受け取ります。
11. TextTalker.as が、受け取ったMP3音声バイナリを再生します。
12. 残ったMP3音声ファイルは適宜、削除されます。



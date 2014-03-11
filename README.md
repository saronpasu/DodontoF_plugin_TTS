DodontoF_plugin_TTS
===================

TTS plugin for DodontoF

## これは何？
* どどんとふ(DodontoF)にTTS(Text to Speech)機能を追加することを目的としたプロジェクトです。
* どどんとふって何？ → [こちら](http://www.dodontof.com/) をご覧ください。
* TTS って何？ → [こちら](http://ja.wikipedia.org/wiki/%E9%9F%B3%E5%A3%B0%E5%90%88%E6%88%90) をご覧ください。


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

## さくらレンタルサーバ ライトプラン向け
* [リリースページ](https://github.com/saronpasu/DodontoF_plugin_TTS/releases) から
* Support for Sakura rental Server という内容のものをダウンロードして下さい。
* 実行ファイルを含むパッケージですので。ビルドする必要はありません。


    * [*最終更新: 2014-03-10*]

## パッケージに含まれるもの
* README.md
* COPYING
* AUTHOR
* TODO.md
* HISTORY.md
* open_jtalk_install.sh
    * Open JTalk 環境をインストールするためのスクリプトです。
    * [*注意事項*]
        * さくらレンタルサーバは、FreeBSD9.1を採用しています。
        * FreeBSD9.1 環境では、 HTS_EngineAPI は、 v0.6 以下でしか動作しません。
        * また、 Open JTalk は v0.5 以下でしか動作しません。
        * それ以外の環境では、最新バージョン(HTS_engineAPI v0.8/OpenJTalk v0.7)で動作します。
        * インストールスクリプトでは、環境に合わせたバージョンが導入されます。
    * この問題は[*未解決*]です。
* open_jtalk.rb
    * Open JTalk の ruby ラッパーです。
* sample.txt
    * サンプル入力用のテキストファイルです。
* sample.rb
    * サンプル出力用のスクリプトです。
* sample.sh
    * サンプル出力用のシェルスクリプトです。前述の sample.rb を実行します。
* DodontoFServerTTS.rb
    * どどんとふ用のTTSプラグインです。 DodontoFServer.rb を見様見真似でそれっぽく記述してみました。
    * 詳しくはコメント参照。
* DodontoFServer.rb
    * どどんとふ最新版(2014-03-11時点、v1.43.13)へ、TTS機能を追加したものです。
        * [*自己責任*]において。DodontoFServe.rb と差し替えてお使い下さい。
        * [*注意事項*]ファイルを差し替えたあとは、実行権限を付与することをお忘れなく。
* talkerProxy.php
    * どどんとふ最新版(2014-03-11時点、v1.43.13)へ、TTS機能を追加したものです。
        * [*自己責任*]において。talerProxy.php と差し替えてお使い下さい。
        * [*注意事項*]ファイルを差し替えたあとは、実行権限を付与することをお忘れなく。
* config.rb
    * どどんとふ最新版(2014-03-11時点、v1.43.13)へ、TTS機能を追加したものです。
        * [*自己責任*]において。src_ruby/config.rb と差し替えてお使い下さい。
        * [*注意事項*]ファイルを差し替えたあとは、実行権限を付与することをお忘れなく。
* tts.rb
    * talkerProxy.php 経由で呼び出される CGI です。
    * ユニークIDを受け取ると、チャット内容を保存したテキストファイルからMP3音声ファイルを生成します。
    * [*注意事項*]実行権限が必要なファイルです。実行権限を付与して下さい。
    * [*開発者向け*]
       * 動作確認以外の目的では直接呼び出さないで下さい。
       * そういう用途のためには作っていません。
* diff
    * [*開発者向け*]どどんとふ最新版(前述)と、TTS実装を行ったものとの差分です。

## パッケージに含まれない
* lame
    * [*注意事項*]
        * リリースパッケージにはビルド済みの実行ファイルを含めていますが。
        * インストールスクリプト( open_jtalk_install.sh )では導入できません。
        * LAME パッケージに関しては、[*必ず*]リリース版パッケージから
        * サーバ環境にあったものを導入して下さい。

## 開発者向けコメント
[*概要*]
1. このプラグインは、どどんとふ本体ファイルと差し替えて使用する形態をとります。
2. diff や patch が分かる人は、 diff ディレクトリのものを使って下さい。
3. open_jtalk_install.sh を実行すると、必要なミドルウェア(lame以外)が揃います。
4. 既存のTTS(Google 非公式 TTS WEB API)を、Open JTalk へ差し替えた内容になっています。
5. 処理内容を説明します。

[*前提条件*]
1. $canTalk = true であること。
2. $useTTS = true であること。
3. ミドルウェアが導入され、ファイルの差し替えまたはパッチの適用が行われていること。

[*処理内容*]
1. TextTalker.as(ActionScript)が、 talkerProxy.php へチャット内容をリクエストします。
2. talkerProxy.php で、チャット内容の正規表現置換が行われます(くまかばさんありがとう！)
3. talkerProxy.php が、チャット内容をテキストファイルに保存します。(一時ファイルです)
4. talkerProxy.php が、tts.rbというCGIへユニークIDをクエリとしてリクエストします。
5. tts.rb が、受け取ったユニークIDを元にテキストファイルを特定します。
6. tts.rb が、 Open JTalk を実行し、チャット内容をWAVE音声ファイルへ変換します。
7. tts.rb が、 LAME を実行し、WAVE音声ファイルをMP3音声ファイルへ変換します。
8. tts.rb が、talkerProxy.php へMP3音声バイナリをレスポンスとして返します。
9. tts.rb が、不要になった一時ファイル(テキスト、WAVE音声ファイル）を削除します。[*ここまで完成*]
10. TextTalker.as が、 talkerProxy.php から MP3音声バイナリのレスポンスを受け取ります。[*調整中*]
11. TextTalker.as が、受け取ったMP3音声バイナリを再生します。[*調整中*]
12. 残ったMP3音声ファイルは適宜、削除されます。[*未実装*]

## TODO
長いので、別ファイルにまとめておきます。

## COPYING
### Open JTalk
> "The Japanese TTS System 'Open JTalk'
developed by HTS Working Group
http://open-jtalk.sourceforge.net/"


> "Copyright (c) 2008-2013  Nagoya Institute of Technology
                         Department of Computer Science
All rights reserved."


### HTS engine API
> "The HMM-Based Speech Synthesis Engine 'hts_engine API'
developed by HTS Working Group
http://hts-engine.sourceforge.net/"


> "Copyright (c) 2001-2013  Nagoya Institute of Technology
                         Department of Computer Science
              2001-2008  Tokyo Institute of Technology
                         Interdisciplinary Graduate School of
                         Science and Engineering
All rights reserved."




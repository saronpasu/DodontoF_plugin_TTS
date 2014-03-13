DodontoF_plugin_TTS
===================

TTS plugin for DodontoF

## お知らせ

# 正常系の動作を確認。メジャーバージョン 1.0.0 リリース！！

## これは何？
* どどんとふ(DodontoF)にTTS(Text to Speech)機能を追加することを目的としたプロジェクトです。
* どどんとふって何？ → [こちら](http://www.dodontof.com/) をご覧ください。
* TTS って何？ → [こちら](http://ja.wikipedia.org/wiki/%E9%9F%B3%E5%A3%B0%E5%90%88%E6%88%90) をご覧ください。

## このサイトへはじめて来た方へ
* このプロジェクトはまだ、[*開発段階*]です。
* 正常系の動作のみ確認していますが、未確認の不具合が予測されます。
* 導入をされる場合は、[*自己責任*]でお願いします。
* 質問や、要望、不具合報告などは [@saronpasu](https://twitter.com/saronpasu) へ下さい。

[*最終更新 2014-03-11*]

## どんな感じなの？？
* デモンストレーション用のお試しどどんとふを用意しました。
* 詳しい使い方や、URLなどは [デモンストレーション用どどんとふへのご案内](https://github.com/saronpasu/DodontoF_plugin_TTS/wiki/%E3%83%87%E3%83%A2%E3%83%B3%E3%82%B9%E3%83%88%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%94%A8%E3%81%A9%E3%81%A9%E3%82%93%E3%81%A8%E3%81%B5%E3%81%B8%E3%81%AE%E3%81%94%E6%A1%88%E5%86%85) ページをご覧ください。

## さくらレンタルサーバ ライトプラン向け
* [リリースページ](https://github.com/saronpasu/DodontoF_plugin_TTS/releases) から
* Support for Sakura rental Server という内容のものをダウンロードして下さい。
* 実行ファイルを含むパッケージですので。ビルドする必要はありません。


    * [*最終更新: 2014-03-10*]

## 導入方法
* 長いので INSTALL へまとめておきました。

## 開発者向け情報
* 長いので DEVELOPMENT へまとめました。


## パッケージに含まれるもの
* README.md
* COPYING
* AUTHOR
* TODO.md
* HISTORY.md
* open_jtalk_install.sh
    * [*開発者向け*]Open JTalk を実行するのに必要なミドルウェアをインストールするためのスクリプトです。
    * [*注意事項*]
        * さくらレンタルサーバは、FreeBSD9.1を採用しています。
        * FreeBSD9.1 環境では、 HTS_EngineAPI は、 v0.6 以下でしか動作しません。
        * また、 Open JTalk は v0.5 以下でしか動作しません。
        * それ以外の環境では、最新バージョン(HTS_engineAPI v0.8/OpenJTalk v0.7)で動作します。
        * インストールスクリプトでは、環境に合わせたバージョンが導入されます。
* open_jtalk.rb
    * Open JTalk の ruby ラッパーです。
* sample.txt
    * サンプル入力用のテキストファイルです。
* sample.rb
    * サンプル出力用のスクリプトです。
* sample.sh
    * サンプル出力用のシェルスクリプトです。前述の sample.rb を実行します。
* talkerProxy.php
    * どどんとふ最新版(2014-03-11時点、v1.43.13)へ、TTS機能を追加したものです。
        * [*自己責任*]において。talerProxy.php と差し替えてお使い下さい。
* tts.rb
    * talkerProxy.php 経由で呼び出される CGI です。
    * ユニークIDを受け取ると、チャット内容を保存したテキストファイルからMP3音声ファイルを生成します。
    * [*注意事項*]実行権限が必要なファイルです。実行権限を付与して下さい。
    * [*開発者向け*]
       * 動作確認以外の目的では直接呼び出さないで下さい。
       * そういう用途のためには作っていません。

## パッケージに含まれない
* lame
    * [*注意事項*]
        * リリースパッケージにはビルド済みの実行ファイルを含めていますが。
        * インストールスクリプト( open_jtalk_install.sh )では導入できません。
        * LAME パッケージに関しては、[*必ず*]リリース版パッケージから
        * サーバ環境にあったものを導入して下さい。


## TODO
長いので、 TODO.md にまとめておきます。

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




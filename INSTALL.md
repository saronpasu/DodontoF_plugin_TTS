## どどんとふTTSプラグイン(音声読み上げ拡張)の導入方法解説
* このページは、導入方法の解説を行っています。


## さくらレンタルサーバ 導入する場合
* [リリースページ](https://github.com/saronpasu/DodontoF_plugin_TTS/releases) から
* タイトルか説明文に 「 Support for Sakura rental Server 」と書いてあるものをダウンロードします。
* 共通までスキップ。


## それ以外の場合
* [リリースページ](https://github.com/saronpasu/DodontoF_plugin_TTS/releases) から
* 32bit 環境へ導入する場合は、タイトルか説明文に 「 i386 」と書いてあるものをダウンロードします。
* 64bit 環境へ導入する場合は、タイトルか説明文に 「 x86_64 」と書いてあるものをダウンロードします。


## 開発者向け(*わからない人は読まなくていいです*)
* git を使って 最新のリポジトリから ソースコードを取得します。
    * github にアカウント登録してない人は
    * $ git clone https://github.com/saronpasu/DodontoF_plugin_TTS.git
    * github にアカウント登録している人は
    * $ git clone git@github.com:saronpasu/DodontoF_plugin_TTS.git
* DodontoF_plugin_TTS というディレクトリができます。そこに最新のソースが入っています。
* open_jtalk_install.sh というファイルに実行権限を与えます。
    * $ chmod +x open_jtalk_install.sh
* open_jtalk_Install.sh を実行すると LAME 以外の必要なミドルウェアが導入されます。
    * $ ./open_jtalk_install.sh
* LAME のソースを取得します。
    * $ wget http://jaist.dl.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
* LAME を展開し、ビルドします。
* configure を実行する際に、[*{pwd}/lame*]へフルパスで指定するのを忘れないで下さい。
    * $ tar zxf lame-3.99.5.tar.gz
    * $ mv lame-3.99.5 lame
    * $ cd lame
    * $ ./configure --prefix=[*{pwd}/lame*] --exec-prefix=[*{pwd}/lame*]
    * $ make
    * $ sudo make install
        * [*注意事項*] make install だけは root 権限が必要です。
    * $ cd ..
    * $ rm lame-3.99.5.tar.gz


## 共通
* これで必要なものはすべて揃いました。
* あとは、どどんとふへファイルを差し替えるだけです。


* どどんとふのディレクトリはこのようになっています。


* DodontoF_WebSet
    * public_html
        * DodontoF
        * imageUploadSpace
    * saveData


* 変更が必要なのは public_html の配下にある DodontoF ディレクトリです。
    * [*注意事項*]
        * もし、DodontoF ディレクトリの配置を変更している場合は
        * 変更後の DodontoF ディレクトリに以下の内容を行って下さい。

### ミドルウェアの導入
* ミドルウェアをディレクトリごと、 DodontoF ディレクトリへコピーして下さい。
* コピーさせるもの。
    * lame
    * open_jtalk
    * hts_engine


[*変更前*]
* DodontoF

[*変更後*]
* DodontoF
    * lame
    * open_jtalk
    * hts_engine

### talkerProxy.php の差し替え
* DodontoF ディレクトリにある talkerProxy.php というファイルを上書きコピーして下さい。
* DodontoF ディレクトリに tts.rb をコピーして下さい。


[*変更前*]
* DodontoF
    * talkerProxy.php

[*変更後*]
* DodontoF
    * talkerProxy.php
    * tts.rb

### open_jtalk.rb の導入
* DodontoF ディレクトリ配下にある src_ruby ディレクトリへ open_jtalk.rb をコピーして下さい。


[*変更前*]
* DodontoF
    * src_ruby

[*変更後*]
* DodontoF
    * src_ruby
        * open_jtalk.rb

### 実行権限の変更
* talkerProxy.php と tts.rb に実行権限を与えて下さい。
    * 705(実行権限あり) のことです。

### お疲れ様でした。
* 以上で、導入手順はすべて終了です。お疲れ様でした。
* 動作確認、ならびに使い方については[デモンストレーション用ページ](https://github.com/saronpasu/DodontoF_plugin_TTS/wiki/%E3%83%87%E3%83%A2%E3%83%B3%E3%82%B9%E3%83%88%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E7%94%A8%E3%81%A9%E3%81%A9%E3%82%93%E3%81%A8%E3%81%B5%E3%81%B8%E3%81%AE%E3%81%94%E6%A1%88%E5%86%85) と同じです。そちらを参照下さい。


#!/usr/bin/ruby -Ku
#-*- encoding :utf-8 -*-
$LOAD_PATH << File.dirname(__FILE__) # require_relative対策

=begin
このスクリプトは、 Open JTalk 環境が正しく導入されているかどうか。
また、ruby ラッパーである open_jtalk.rb が正しく動作するかどうか。
確認するためのサンプルスクリプトです。

実行すると、 sample.txt に書かれた内容が
sample.wav 音声ファイルとして出力されます。

もし、何らかのエラーが出た場合。
Open JTalk 環境が正しくセットアップできていない。
または、 ruby 環境が正しくセットアップできていない可能性があります。

自己調査を行い、対処し、製作者へ連絡を取るか。
自己対処が困難な場合は、直接、製作者へご連絡下さい。

くれぐれも、 Open JTalk 作者へは連絡しないようご注意下さい。

=end

require 'open_jtalk'
open_jtalk('sample.txt', 'sample.wav')

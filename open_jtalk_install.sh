#!/bin/sh

echo "setup Open JTalk packages."
WORK_DIR=`pwd`

#: << '#_comment_out'
echo "download hts_engine ... "
wget http://jaist.dl.sourceforge.net/project/hts-engine/hts_engine%20API/hts_engine_API-1.08/hts_engine_API-1.08.tar.gz
echo "done."
echo "download Open JTalk ..."
wget http://jaist.dl.sourceforge.net/project/open-jtalk/Open%20JTalk/open_jtalk-1.07/open_jtalk-1.07.tar.gz
echo "done."
echo "download Open JTalk UTF-8 dict."
wget http://jaist.dl.sourceforge.net/project/open-jtalk/Dictionary/open_jtalk_dic-1.07/open_jtalk_dic_utf_8-1.07.tar.gz
echo "done."
echo "download MMDAgent_Example ..."
wget http://jaist.dl.sourceforge.net/project/mmdagent/MMDAgent_Example/MMDAgent_Example-1.4/MMDAgent_Example-1.4.zip

#_comment_out

echo "uncompress packages."
echo "uncompress hts_engine ... "
tar zxf hts_engine_API-1.08.tar.gz
echo "done."
echo "uncompress open_jtalk ... "
tar zxf open_jtalk-1.07.tar.gz
echo "done."
echo "uncompress open_jtalk_dic_utf_8."
tar zxf open_jtalk_dic_utf_8-1.07.tar.gz
echo "done."
echo "uncompress MMDAgent-Example ... "
unzip -o MMDAgent_Example-1.4.zip
echo "done."

echo "build to packages."
mv hts_engine_API-1.08 hts_engine
HTS_ENGINE_PATH=$PWD/hts_engine
cd hts_engine/
echo "configuration hts_engine ... "
./configure --prefix=$HTS_ENGINE_PATH --exec-prefix=$HTS_ENGINE_PATH
echo "done."
echo "build hts_engine ... "

if "FreeBSD" != `uname`; then
  make
else
  gmake
fi

echo "done."
cd $WORK_DIR
mv open_jtalk-1.07 open_jtalk
mkdir -p $WORK_DIR/open_jtalk/data
mkdir -p $WORK_DIR/open_jtalk/doc
OPEN_JTALK_PATH=$PWD/open_jtalk
cd open_jtalk
echo "configuration open_jtalk ... "
./configure --prefix=$OPEN_JTALK_PATH --exec-prefix=$OPEN_JTALK_PATH --with-hts-engine-header=$HTS_ENGINE_PATH/include --with-hts-engine-library-path=$HTS_ENGINE_PATH/lib --with-charset=UTF-8
echo "build open_jtalk build ... "

if "FreeBSD" != `uname`; then
  make
else
  gmake
fi

cd $WORK_DIR
mv open_jtalk_dic_utf_8-1.07 $OPEN_JTALK_PATH/dic
mkdir -p $OPEN_JTALK_PATH/share/voices
echo "hts_voice file move from MMDAgent-Example."
cd MMDAgent_Example-1.4/Voice/mei
cp mei_normal.htsvoice $OPEN_JTALK_PATH/share/voices
echo "done."
cd $WORK_DIR

#: << '#_comment_out'
echo "remove archives ..."
rm -rf hts_engine_API-1.08
rm -r hts_engine_API-1.08.tar.gz
rm -rf open_jtalk-1.07
rm -r open_jtalk-1.07.tar.gz
rm -r open_jtalk_dic_utf_8-1.07.tar.gz
rm -rf MMDAgent_Example-1.4
rm -r MMDAgent_Example-1.4.zip
echo "done."

echo "Open JTalk setup finish."
#_comment_out

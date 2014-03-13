#!/bin/sh

echo "setup Open JTalk packages."
WORK_DIR=`pwd`
UNAME=`uname`

#: << '#_comment_out'
echo "download hts_engine ... "

####################################################
#### FreeBSD 9.1 only hts_engine_API v0.6 older ####
####################################################
if [ "$UNAME" = "FreeBSD" ]; then
  wget wget http://jaist.dl.sourceforge.net/project/hts-engine/hts_engine%20API/hts_engine_API-1.06/hts_engine_API-1.06.tar.gz
else
  wget http://jaist.dl.sourceforge.net/project/hts-engine/hts_engine%20API/hts_engine_API-1.08/hts_engine_API-1.08.tar.gz
fi

echo "done."
echo "download Open JTalk ..."

######################################################
#### FreeBSD 9.1 only open_jtalk v0.5 older       ####
######################################################

if [ "$UNAME" = "FreeBSD" ]; then
  wget http://jaist.dl.sourceforge.net/project/open-jtalk/Open%20JTalk/open_jtalk-1.05/open_jtalk-1.05.tar.gz
else
  wget http://jaist.dl.sourceforge.net/project/open-jtalk/Open%20JTalk/open_jtalk-1.07/open_jtalk-1.07.tar.gz
fi

echo "done."
echo "download Open JTalk UTF-8 dict."

######################################################
#### FreeBSD 9.1 only open_jtalk v0.5 older       ####
######################################################

if [ "$UNAME" = "FreeBSD" ]; then
  wget http://jaist.dl.sourceforge.net/project/open-jtalk/Dictionary/open_jtalk_dic-1.05/open_jtalk_dic_utf_8-1.05.tar.gz
else
  wget http://jaist.dl.sourceforge.net/project/open-jtalk/Dictionary/open_jtalk_dic-1.07/open_jtalk_dic_utf_8-1.07.tar.gz
fi

echo "done."
echo "download MMDAgent_Example ..."

######################################################
#### FreeBSD 9.1 only MMDAgent-Example v1.3 older ####
######################################################

if [ "$UNAME" = "FreeBSD" ]; then
  wget http://ftp.jaist.ac.jp/pub/sourceforge/m/mm/mmdagent/MMDAgent_Example/MMDAgent_Example-1.3/MMDAgent_Example-1.3.zip
else
  wget http://jaist.dl.sourceforge.net/project/mmdagent/MMDAgent_Example/MMDAgent_Example-1.4/MMDAgent_Example-1.4.zip
fi
#_comment_out



echo "uncompress packages."
echo "uncompress hts_engine ... "

#: << '#_comment_out'


if [ "$UNAME" = "FreeBSD" ]; then
  tar zxf hts_engine_API-1.06.tar.gz
else
  tar zxf hts_engine_API-1.08.tar.gz
fi

echo "done."
echo "uncompress open_jtalk ... "

if [ "$UNAME" = "FreeBSD" ]; then
  tar zxf open_jtalk-1.05.tar.gz
else
  tar zxf open_jtalk-1.07.tar.gz
fi

echo "done."
echo "uncompress open_jtalk_dic_utf_8."

if [ "$UNAME" = "FreeBSD" ]; then
  tar zxf open_jtalk_dic_utf_8-1.05.tar.gz
else
  tar zxf open_jtalk_dic_utf_8-1.07.tar.gz
fi

echo "done."
echo "uncompress MMDAgent-Example ... "

if [ "$UNAME" = "FreeBSD" ]; then
  unzip -o MMDAgent_Example-1.3.zip
else
  unzip -o MMDAgent_Example-1.4.zip
fi

echo "done."

#_comment_out

#: << '#_comment_out'

echo "build to packages."

#: << '#_comment_out'

if [ "$UNAME" = "FreeBSD" ]; then
  mv hts_engine_API-1.06 hts_engine
else
  mv hts_engine_API-1.08 hts_engine
fi

HTS_ENGINE_PATH=$PWD/hts_engine
cd hts_engine/
echo "configuration hts_engine ... "

: << '#_comment_out'
#################################################
#### cross compile for other linux server    ####
#################################################
#./configure --prefix=$HTS_ENGINE_PATH --exec-prefix=$HTS_ENGINE_PATH --target=x86_64-pc-linux-gnu

#################################################
#### cross compile for sakura rental server  ####
#################################################
./configure --prefix=$HTS_ENGINE_PATH --exec-prefix=$HTS_ENGINE_PATH --host=x86_64-pc-freebsd9.1 --target=x86_64-pc-freebsd9.1
#_comment_out


#: << '#_comment_out'
# native build.
if [ "$UNAME" = "FreeBSD" ]; then
  ./configure --prefix=$HTS_ENGINE_PATH --exec-prefix=$HTS_ENGINE_PATH
else
# x86_64
  ./configure --prefix=$HTS_ENGINE_PATH --exec-prefix=$HTS_ENGINE_PATH

# i386
#  ./configure --prefix=$HTS_ENGINE_PATH --exec-prefix=$HTS_ENGINE_PATH

fi
##_comment_out


echo "done."
echo "build hts_engine ... "

if [ "$UNAME" = "FreeBSD" ]; then
  gmake
else
  make
fi

echo "done."
cd $WORK_DIR

if [ "$UNAME" = "FreeBSD" ]; then
  mv open_jtalk-1.05 open_jtalk
else
  mv open_jtalk-1.07 open_jtalk
fi

mkdir -p $WORK_DIR/open_jtalk/data
mkdir -p $WORK_DIR/open_jtalk/doc
OPEN_JTALK_PATH=$PWD/open_jtalk
cd open_jtalk
echo "configuration open_jtalk ... "

: << '#_comment_out'
#################################################
#### cross compile for other linux server    ####
#################################################
#./configure --prefix=$OPEN_JTALK_PATH --exec-prefix=$OPEN_JTALK_PATH --with-hts-engine-header-path=$HTS_ENGINE_PATH/include --with-hts-engine-library-path=$HTS_ENGINE_PATH/lib --with-charset=UTF-8 --target=x86_64-pc-linux-gnu

#################################################
#### cross compile for sakura rental server  ####
#################################################
./configure --prefix=$OPEN_JTALK_PATH --exec-prefix=$OPEN_JTALK_PATH --with-hts-engine-header-path=$HTS_ENGINE_PATH/include --with-hts-engine-library-path=$HTS_ENGINE_PATH/lib --with-charset=UTF-8  --host=x86_64-pc-freebsd9.1 --target=x86_64-pc-freebsd9.1
#_comment_out


#: << '#_comment_out'
# native build.
if [ "$UNAME" = "FreeBSD" ]; then
  ./configure --prefix=$OPEN_JTALK_PATH --exec-prefix=$OPEN_JTALK_PATH --with-hts-engine-header-path=$HTS_ENGINE_PATH/include --with-charset=UTF-8 --with-hts-engine-library-path=$HTS_ENGINE_PATH/lib
else
# x86_64
  ./configure --prefix=$OPEN_JTALK_PATH --exec-prefix=$OPEN_JTALK_PATH --with-hts-engine-header-path=$HTS_ENGINE_PATH/include --with-charset=UTF-8 --with-hts-engine-library-path=$HTS_ENGINE_PATH/lib

# i386
#  ./configure --prefix=$OPEN_JTALK_PATH --exec-prefix=$OPEN_JTALK_PATH --with-hts-engine-header-path=$HTS_ENGINE_PATH/include --with-charset=UTF-8 --with-hts-engine-library-path=$HTS_ENGINE_PATH/lib --target=i386-unknown-ubuntu

fi
##_comment_out

echo "build open_jtalk build ... "

if [ "$UNAME" = "FreeBSD" ]; then
  gmake
else
  make
fi

cd $WORK_DIR

if [ "$UNAME" = "FreeBSD" ]; then
  mv open_jtalk_dic_utf_8-1.05 $OPEN_JTALK_PATH/dic
else
  mv open_jtalk_dic_utf_8-1.07 $OPEN_JTALK_PATH/dic
fi

mkdir -p $OPEN_JTALK_PATH/share/voices
echo "hts_voice file move from MMDAgent-Example."

if [ "$UNAME" = "FreeBSD" ]; then
  mv MMDAgent_Example-1.3/Voice/mei_normal $OPEN_JTALK_PATH/share/voices/mei_normal

else
  cd MMDAgent_Example-1.4/Voice/mei
  cp mei_normal.htsvoice $OPEN_JTALK_PATH/share/voices
fi

echo "done."

#_comment_out

echo "done."
cd $WORK_DIR

#: << '#_comment_out'
echo "remove archives ..."

if [ "$UNAME" = "FreeBSD" ]; then
  rm -r hts_engine_API-1.06.tar.gz
  rm -rf hts_engine_API-1.06
  rm -r open_jtalk-1.05.tar.gz
  rm -rf open_jtalk-1.05
  rm -r open_jtalk_dic_utf_8-1.05.tar.gz
  rm -rf open_jtalk_dic_utf_8-1.05
  rm -r MMDAgent_Example-1.3.zip
  rm -rf MMDAgent_Example-1.3
else
  rm -r hts_engine_API-1.08.tar.gz
  rm -rf hts_engine_API-1.08
  rm -r open_jtalk-1.07.tar.gz
  rm -rf open_jtalk-1.07
  rm -r open_jtalk_dic_utf_8-1.07.tar.gz
  rm -rf open_jtalk_dic_utf_8-1.07
  rm -r MMDAgent_Example-1.4.zip
  rm -rf MMDAgent_Example-1.4
fi

echo "done."

echo "Open JTalk setup finish."
#_comment_out

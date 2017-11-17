#!/bin/sh

date=`date '+%Y-%m-%d-%T'`
PROJECT_NAME="./*.xcodeproj"
#需要编译的 targetname
TARGET_NAME="TBTophome"
SCHEME_NAME="TBTophome"
CONFIGURATION_TARGET="Debug"
#组件路径
BUILDPATH="./${date}"
#archivePath
ARCHIVEPATH=${BUILDPATH}/${TARGET_NAME}.xcarchive
#输入的ipad目录
IPAPATH=${BUILDPATH}

#到处ipad 所需plist
ADHOCExportOptionsPlist=./ADHOCExportOptionsPlist.plist
AppStoreExportOptionsPlist=./AppStoreExportOptionsPlist.plist
DevelopmentExportOptionsPlist=./DevelopmentExportOptionsPlist.plist

ExportOptionsPlist=${DevelopmentExportOptionsPlist}

#读取用户变量
#read parameter
method=$1

#判断用户是否有输入
if [ -n "$method" ]
then
	echo $method
	if [ "$method" = "1" ]
	then
	ExportOptionsPlist=${DevelopmentExportOptionsPlist}
	elif [ "$method" = "2" ]
	then
	ExportOptionsPlist=${ADHOCExportOptionsPlist}
	elif [ "$method" = "3" ]
	then
	ExportOptionsPlist=${AppStoreExportOptionsPlist}
	else
	echo "参数无效..."
	echo "请选择打包方式，usage: ./auto_build 1|2|3"
	echo "1 development (默认)"
	echo "2 ad-hoc"
	echo "3 appstore"
	exit 1
	fi
else
	ExportOptionsPlist=${DevelopmentExportOptionsPlist}
fi

echo "~~~~~~~~~~~~~~~~~~~~~~开始编译~~~~~~~~~~~~~~~~~~~~~~"
echo "~~~~~~~~~~~~~~~~~~~~~~开始清理~~~~~~~~~~~~~~~~~~~~~~"

#清理 避免出现一些莫名的错误
xcodebuild clean -project ${PROJECT_NAME} \
-configuration ${CONFIGURATION_TARGET} \
-alltargets

echo "~~~~~~~~~~~~~~~~~~~~~开始构建~~~~~~~~~~~~~~~~~~~~~~~"
#开始构建
#开始时间
beginTime=`date +%s`
xcodebuild archive -project ${PROJECT_NAME} -scheme ${SCHEME_NAME} -configuration ${CONFIGURATION_TARGET} -archivePath ${ARCHIVEPATH}
endTime=`date +%s`
echo "构建时间$[ endTime - beginTime ]秒"
echo "~~~~~~~~~~~~~~~~~~~~~检查是否构建成功~~~~~~~~~~~~~~~~~~~~~~"
if [ -d "${ARCHIVEPATH}" ]
then
echo "构建成功..."
else
echo "构建失败..."
rm -rf $BUILDPATH
exit 1
fi

echo "~~~~~~~~~~~~~~~~~~~导出ipa~~~~~~~~~~~~~~~~~~~~~"
beginTime=`date +%s`
xcodebuild -exportArchive -archivePath ${ARCHIVEPATH} -exportPath $IPAPATH -exportOptionsPlist $ExportOptionsPlist
endTime=`date +%s`
echo "导出ipa时间$[ endTime - beginTime ]秒"
echo "~~~~~~~~~~~~~~~~~检查是否成功导出ipa~~~~~~~~~~~~~~~~~"
IPAPATH=${IPAPATH}/${TARGET_NAME}.ipa
if [ -f "${IPAPATH}" ]
then
echo "ipa路径${IPAPATH}"
echo "导出ipa成功....."
echo "配合Jenkins将ipa移动到根目录"
mv ${IPAPATH} ./
else
echo "导出ipa失败....."
exit 1
fi

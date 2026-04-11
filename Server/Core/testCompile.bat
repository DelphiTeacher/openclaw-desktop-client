@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM 设置Delphi编译器路径
set DCC32="d:\rad studio 13\bin\dcc32.exe"

REM 编译器开关
set SWITCHES=-$O- -$W+ -$R+ -$Q+ --no-config -B -Q -TX.exe

REM 单元别名
set ALIASES=-AGenerics.Collections=System.Generics.Collections;Generics.Defaults=System.Generics.Defaults;WinTypes=Winapi.Windows;WinProcs=Winapi.Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE

REM 条件定义
set CONDITIONAL=-DDEBUG

REM 输出目录
set OUTPUT_DIR=-E..\Win32\Debug

REM 包含文件路径
set INCLUDE_PATH=-I"d:\rad studio 13\lib\Win32\debug";"D:\三方控件\PDFium Component Suite\Source";"d:\rad studio 13\lib\Win32\release";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports\Win32";"d:\rad studio 13\Imports";"C:\Users\Public\Documents\Embarcadero\Studio\37.0\Dcp";"d:\rad studio 13\includee";"d:\myfilesnew\orangeui\orangeuidesign\dcu\fmx\d13\win32\debug";"D:\三方控件\TMS Sparkle\source";"D:\三方控件\TMS Sparkle\source\core";"D:\三方控件\kbmMemTablePro_77510\Source";"D:\三方控件\kbmMW5_02_10\Source";"D:\三方控件\kbmMW5_02_10\Source\Ciphers";"D:\三方控件\kbmMW5_02_10\Source\Compression";"D:\三方控件\kbmMW5_02_10\Source\Hashes";"D:\三方控件\kbmhttpsys5_02_10"

REM 运行时包输出目录
set BPL_OUTPUT=-LEC:\Users\Public\Documents\Embarcadero\Studio\37.0\Bpl

REM DCU输出目录（包文件）
set DCP_OUTPUT=-LNC:\Users\Public\Documents\Embarcadero\Studio\37.0\Dcp

REM 单元输出目录
set UNIT_OUTPUT=-NU..\Win32\Debug

REM 命名空间
set NAMESPACES=-NSWinapi;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;System;Xml;Data;Datasnap;Web;Soap;VCL;

REM 目标文件路径
set OBJECT_PATH=-O"D:\三方控件\PDFium Component Suite\Source";"d:\rad studio 13\lib\Win32\release";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports\Win32";"d:\rad studio 13\Imports";"C:\Users\Public\Documents\Embarcadero\Studio\37.0\Dcp";"d:\rad studio 13\includee";"d:\myfilesnew\orangeui\orangeuidesign\dcu\fmx\d13\win32\debug"

REM 资源文件路径
set RESOURCE_PATH=-R"D:\三方控件\PDFium Component Suite\Source";"d:\rad studio 13\lib\Win32\release";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports\Win32";"d:\rad studio 13\Imports";"C:\Users\Public\Documents\Embarcadero\Studio\37.0\Dcp";"d:\rad studio 13\includee";"d:\myfilesnew\orangeui\orangeuidesign\dcu\fmx\d13\win32\debug"

REM 单元路径
set UNIT_PATH=-U"d:\rad studio 13\lib\Win32\debug";"D:\三方控件\PDFium Component Suite\Source";"d:\rad studio 13\lib\Win32\release";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports";"C:\Users\Administrator\Documents\Embarcadero\Studio\37.0\Imports\Win32";"d:\rad studio 13\Imports";"C:\Users\Public\Documents\Embarcadero\Studio\37.0\Dcp";"d:\rad studio 13\includee";"d:\myfilesnew\orangeui\orangeuidesign\dcu\fmx\d13\win32\debug";"D:\三方控件\TMS Sparkle\source";"D:\三方控件\TMS Sparkle\source\core";"D:\三方控件\kbmMemTablePro_77510\Source";"D:\三方控件\kbmMW5_02_10\Source";"D:\三方控件\kbmMW5_02_10\Source\Ciphers";"D:\三方控件\kbmMW5_02_10\Source\Compression";"D:\三方控件\kbmMW5_02_10\Source\Hashes";"D:\三方控件\kbmhttpsys5_02_10"

REM 其他编译器选项
set OTHER_OPTIONS=-CC -V -VN

REM C++生成选项
set CPP_OPTIONS=-NBC:\Users\Public\Documents\Embarcadero\Studio\37.0\Dcp -NHC:\Users\Public\Documents\Embarcadero\Studio\37.0\hpp\Win32 -NO..\Win32\Debug

REM 项目文件
set PROJECT_FILE=testConsole.dpr

REM 构建完整命令
set COMMAND=%DCC32% %SWITCHES% %ALIASES% %CONDITIONAL% %OUTPUT_DIR% %INCLUDE_PATH% %BPL_OUTPUT% %DCP_OUTPUT% %UNIT_OUTPUT% %NAMESPACES% %OBJECT_PATH% %RESOURCE_PATH% %UNIT_PATH% %OTHER_OPTIONS% %CPP_OPTIONS% %PROJECT_FILE%

REM 显示将要执行的命令
echo 正在执行编译命令：
echo %COMMAND%
echo.

REM 执行编译命令
%COMMAND%

REM 检查编译结果
if errorlevel 1 (
    echo 编译失败，错误代码：%errorlevel%
) else (
    echo 编译成功！
)

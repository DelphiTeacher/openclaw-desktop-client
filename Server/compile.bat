@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ========================================
REM Delphi 编译命令批处理文件
REM 编译项目: DelphiRagServer.dpr
REM ========================================

REM 设置基础路径
set DCC32_PATH="d:\rad studio 12.2.5\bin\dcc32.exe"
set RAD_STUDIO_PATH=d:\rad studio 12.2.5
set PUBLIC_DOCS=C:\Users\Administrator\Documents\Embarcadero\Studio\23.0
set PUBLIC_DOCS_COMMON=C:\Users\Public\Documents\Embarcadero\Studio\23.0

REM 第三方控件路径
set TEE_CHART_PATH=D:\DelphiThirdPartyComponent\Steema TeeChart Pro VCL FMX Source Code 2023.38
set TMS_SPARKLE_PATH=D:\三方控件\TMS Sparkle
set KBM_MEMTABLE_PATH=D:\三方控件\kbmMemTablePro_77510
set KBM_MW_PATH=D:\三方控件\kbmMW5_02_10
set KBM_HTTPSYS_PATH=D:\三方控件\kbmhttpsys5_02_10
set ORANGE_UI_PATH=D:\MyFilesNew\OrangeUI
set UNIDAC_PATH=D:\三方控件\Devart\UniDAC for RAD Studio 12
set MXSCOMM_PATH=D:\三方控件\mxscomm
set PDFIUM_PATH=D:\三方控件\PDFium Component Suite\Delphi12
set PYTHON4DELPHI_PATH=D:\三方控件\python4delphi-master
set XLSREADWRITE_PATH=D:\三方控件\XLSReadWrite_v6.00.47_for_D6-D10.3_Rio_Full_Source
set DEVEXPRESS_PATH=D:\三方控件\DevExpressVCL_v19.1.2_src(for 12)

REM ========================================
REM 编译选项
REM ========================================

set COMPILE_OPTS=-$O- -$W+ --no-config -B -Q

REM 输出文件扩展名
set OUTPUT_EXT=-TX.exe

REM 单元别名
set UNIT_ALIASES=-AGenerics.Collections=System.Generics.Collections;Generics.Defaults=System.Generics.Defaults;WinTypes=Winapi.Windows;WinProcs=Winapi.Windows;DbiTypes=BDE;DbiProcs=BDE;DbiErrs=BDE

REM 定义条件
set DEFINES=-DDEBUG;OPEN_PLATFORM_SERVER;;FRAMEWORK_VCL

REM 输出目录
set OUTPUT_DIR=-E.\Win32\Debug

REM ========================================
REM 包含路径
REM ========================================

set INCLUDE_PATHS=-I^
"%RAD_STUDIO_PATH%\lib\Win32\debug";^
"%TEE_CHART_PATH%\TeeTree\Compiled\Delphi29.win32\Lib";^
"%TEE_CHART_PATH%\Compiled\Delphi29.win32\Lib";^
"%TMS_SPARKLE_PATH%\source";^
"%TMS_SPARKLE_PATH%\source\core";^
"%KBM_MEMTABLE_PATH%\Source";^
"%KBM_MW_PATH%\Source";^
"%KBM_MW_PATH%\Source\Ciphers";^
"%KBM_MW_PATH%\Source\Compression";^
"%KBM_MW_PATH%\Source\Hashes";^
"%KBM_HTTPSYS_PATH%";^
"%ORANGE_UI_PATH%\OrangeProjectCommon";^
"%ORANGE_UI_PATH%\OrangeProjectCommon\OrangeUI";^
"%UNIDAC_PATH%\Lib\Win32";^
"%MXSCOMM_PATH%\comps\mORMot";^
"%PDFIUM_PATH%";^
"%RAD_STUDIO_PATH%\lib\Win32\release";^
"%PUBLIC_DOCS%\Imports";^
"%PUBLIC_DOCS%\Imports\Win32";^
"%RAD_STUDIO_PATH%\Imports";^
"%PUBLIC_DOCS_COMMON%\Dcp";^
"%RAD_STUDIO_PATH%\includee";^
"%UNIDAC_PATH%\Lib\Win32";^
"%UNIDAC_PATH%\Bin\Win32";^
"%UNIDAC_PATH%\Source\NexusDBProviderrrrr";^
d:\myfiles\orangeuidesign\dcu\fmx\d12\win32\debug;^
"%TEE_CHART_PATH%\TeeTree\Compiled\Delphi29.win32\Lib";^
"%TEE_CHART_PATH%\Compiled\Delphi29.win32\Lib";^
"%PYTHON4DELPHI_PATH%\Source";^
"%PYTHON4DELPHI_PATH%\Source\vcl";^
"%XLSREADWRITE_PATH%\SrcXLS";^
"%DEVEXPRESS_PATH%\ExpressCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressGDI+ Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressCommon Library\Sources";^
"%DEVEXPRESS_PATH%\XP Theme Manager\Sources";^
"%DEVEXPRESS_PATH%\ExpressLibrary\Sources";^
"%DEVEXPRESS_PATH%\ExpressExport Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressLayout Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressDataController\Sources";^
"%DEVEXPRESS_PATH%\ExpressEditors Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressMemData\Sources";^
"%DEVEXPRESS_PATH%\ExpressPageControl\Sources";^
"%DEVEXPRESS_PATH%\ExpressBars\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet Core\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumTreeList\Sources";^
"%DEVEXPRESS_PATH%\ExpressDocking Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressWizard Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressSkins Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressOfficeCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressRichEdit Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPDFViewer\Sources";^
"%DEVEXPRESS_PATH%\ExpressFlowChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressOrgChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressGauge Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressMap Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPivotGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressVerticalGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressDBTree Suite\Sources";^
"%DEVEXPRESS_PATH%\ExpressTile Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpellChecker\Sources";^
"%DEVEXPRESS_PATH%\ExpressNavBar\Sources";^
"%DEVEXPRESS_PATH%\ExpressScheduler\Sources";^
"%DEVEXPRESS_PATH%\ExpressPrinting System\Sources";^
"%DEVEXPRESS_PATH%\ExpressEntityMapping Framework\Sources"

REM ========================================
REM 包输出路径
REM ========================================

set BPL_OUTPUT=-LEC:\Users\Public\Documents\Embarcadero\Studio\23.0\Bpl
set DCP_OUTPUT=-LNC:\Users\Public\Documents\Embarcadero\Studio\23.0\Dcp

REM 单元输出目录
set UNIT_OUTPUT=-NU.\Win32\Debug\DCU

REM 命名空间
set NAMESPACES=-NSWinapi;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;System;Xml;Data;Datasnap;Web;Soap;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;

REM ========================================
REM 目标路径
REM ========================================

set OBJ_PATHS=-O^
"%TMS_SPARKLE_PATH%\source";^
"%TMS_SPARKLE_PATH%\source\core";^
"%KBM_MEMTABLE_PATH%\Source";^
"%KBM_MW_PATH%\Source";^
"%KBM_MW_PATH%\Source\Ciphers";^
"%KBM_MW_PATH%\Source\Compression";^
"%KBM_MW_PATH%\Source\Hashes";^
"%KBM_HTTPSYS_PATH%";^
"%ORANGE_UI_PATH%\OrangeProjectCommon";^
"%ORANGE_UI_PATH%\OrangeProjectCommon\OrangeUI";^
"%UNIDAC_PATH%\Lib\Win32";^
"%MXSCOMM_PATH%\comps\mORMot";^
"%PDFIUM_PATH%";^
"%RAD_STUDIO_PATH%\lib\Win32\release";^
"%PUBLIC_DOCS%\Imports";^
"%PUBLIC_DOCS%\Imports\Win32";^
"%RAD_STUDIO_PATH%\Imports";^
"%PUBLIC_DOCS_COMMON%\Dcp";^
"%RAD_STUDIO_PATH%\includee";^
"%UNIDAC_PATH%\Lib\Win32";^
"%UNIDAC_PATH%\Bin\Win32";^
"%UNIDAC_PATH%\Source\NexusDBProviderrrrr";^
d:\myfiles\orangeuidesign\dcu\fmx\d12\win32\debug;^
"%TEE_CHART_PATH%\TeeTree\Compiled\Delphi29.win32\Lib";^
"%TEE_CHART_PATH%\Compiled\Delphi29.win32\Lib";^
"%PYTHON4DELPHI_PATH%\Source";^
"%PYTHON4DELPHI_PATH%\Source\vcl";^
"%XLSREADWRITE_PATH%\SrcXLS";^
"%DEVEXPRESS_PATH%\ExpressCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressGDI+ Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressCommon Library\Sources";^
"%DEVEXPRESS_PATH%\XP Theme Manager\Sources";^
"%DEVEXPRESS_PATH%\ExpressLibrary\Sources";^
"%DEVEXPRESS_PATH%\ExpressExport Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressLayout Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressDataController\Sources";^
"%DEVEXPRESS_PATH%\ExpressEditors Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressMemData\Sources";^
"%DEVEXPRESS_PATH%\ExpressPageControl\Sources";^
"%DEVEXPRESS_PATH%\ExpressBars\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet Core\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumTreeList\Sources";^
"%DEVEXPRESS_PATH%\ExpressDocking Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressWizard Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressSkins Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressOfficeCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressRichEdit Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPDFViewer\Sources";^
"%DEVEXPRESS_PATH%\ExpressFlowChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressOrgChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressGauge Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressMap Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPivotGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressVerticalGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressDBTree Suite\Sources";^
"%DEVEXPRESS_PATH%\ExpressTile Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpellChecker\Sources";^
"%DEVEXPRESS_PATH%\ExpressNavBar\Sources";^
"%DEVEXPRESS_PATH%\ExpressScheduler\Sources";^
"%DEVEXPRESS_PATH%\ExpressPrinting System\Sources";^
"%DEVEXPRESS_PATH%\ExpressEntityMapping Framework\Sources"

set RESOURCE_PATHS=-R^
"%TMS_SPARKLE_PATH%\source";^
"%TMS_SPARKLE_PATH%\source\core";^
"%KBM_MEMTABLE_PATH%\Source";^
"%KBM_MW_PATH%\Source";^
"%KBM_MW_PATH%\Source\Ciphers";^
"%KBM_MW_PATH%\Source\Compression";^
"%KBM_MW_PATH%\Source\Hashes";^
"%KBM_HTTPSYS_PATH%";^
"%ORANGE_UI_PATH%\OrangeProjectCommon";^
"%ORANGE_UI_PATH%\OrangeProjectCommon\OrangeUI";^
"%UNIDAC_PATH%\Lib\Win32";^
"%MXSCOMM_PATH%\comps\mORMot";^
"%PDFIUM_PATH%";^
"%RAD_STUDIO_PATH%\lib\Win32\release";^
"%PUBLIC_DOCS%\Imports";^
"%PUBLIC_DOCS%\Imports\Win32";^
"%RAD_STUDIO_PATH%\Imports";^
"%PUBLIC_DOCS_COMMON%\Dcp";^
"%RAD_STUDIO_PATH%\includee";^
"%UNIDAC_PATH%\Lib\Win32";^
"%UNIDAC_PATH%\Bin\Win32";^
"%UNIDAC_PATH%\Source\NexusDBProviderrrrr";^
d:\myfiles\orangeuidesign\dcu\fmx\d12\win32\debug;^
"%TEE_CHART_PATH%\TeeTree\Compiled\Delphi29.win32\Lib";^
"%TEE_CHART_PATH%\Compiled\Delphi29.win32\Lib";^
"%PYTHON4DELPHI_PATH%\Source";^
"%PYTHON4DELPHI_PATH%\Source\vcl";^
"%XLSREADWRITE_PATH%\SrcXLS";^
"%DEVEXPRESS_PATH%\ExpressCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressGDI+ Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressCommon Library\Sources";^
"%DEVEXPRESS_PATH%\XP Theme Manager\Sources";^
"%DEVEXPRESS_PATH%\ExpressLibrary\Sources";^
"%DEVEXPRESS_PATH%\ExpressExport Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressLayout Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressDataController\Sources";^
"%DEVEXPRESS_PATH%\ExpressEditors Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressMemData\Sources";^
"%DEVEXPRESS_PATH%\ExpressPageControl\Sources";^
"%DEVEXPRESS_PATH%\ExpressBars\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet Core\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumTreeList\Sources";^
"%DEVEXPRESS_PATH%\ExpressDocking Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressWizard Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressSkins Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressOfficeCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressRichEdit Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPDFViewer\Sources";^
"%DEVEXPRESS_PATH%\ExpressFlowChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressOrgChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressGauge Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressMap Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPivotGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressVerticalGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressDBTree Suite\Sources";^
"%DEVEXPRESS_PATH%\ExpressTile Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpellChecker\Sources";^
"%DEVEXPRESS_PATH%\ExpressNavBar\Sources";^
"%DEVEXPRESS_PATH%\ExpressScheduler\Sources";^
"%DEVEXPRESS_PATH%\ExpressPrinting System\Sources";^
"%DEVEXPRESS_PATH%\ExpressEntityMapping Framework\Sources"

set UNIT_PATHS=-U^
"%RAD_STUDIO_PATH%\lib\Win32\debug";^
"%TEE_CHART_PATH%\TeeTree\Compiled\Delphi29.win32\Lib";^
"%TEE_CHART_PATH%\Compiled\Delphi29.win32\Lib";^
"%TMS_SPARKLE_PATH%\source";^
"%TMS_SPARKLE_PATH%\source\core";^
"%KBM_MEMTABLE_PATH%\Source";^
"%KBM_MW_PATH%\Source";^
"%KBM_MW_PATH%\Source\Ciphers";^
"%KBM_MW_PATH%\Source\Compression";^
"%KBM_MW_PATH%\Source\Hashes";^
"%KBM_HTTPSYS_PATH%";^
"%ORANGE_UI_PATH%\OrangeProjectCommon";^
"%ORANGE_UI_PATH%\OrangeProjectCommon\OrangeUI";^
"%UNIDAC_PATH%\Lib\Win32";^
"%MXSCOMM_PATH%\comps\mORMot";^
"%PDFIUM_PATH%";^
"%RAD_STUDIO_PATH%\lib\Win32\release";^
"%PUBLIC_DOCS%\Imports";^
"%PUBLIC_DOCS%\Imports\Win32";^
"%RAD_STUDIO_PATH%\Imports";^
"%PUBLIC_DOCS_COMMON%\Dcp";^
"%RAD_STUDIO_PATH%\includee";^
"%UNIDAC_PATH%\Lib\Win32";^
"%UNIDAC_PATH%\Bin\Win32";^
"%UNIDAC_PATH%\Source\NexusDBProviderrrrr";^
d:\myfiles\orangeuidesign\dcu\fmx\d12\win32\debug;^
"%TEE_CHART_PATH%\TeeTree\Compiled\Delphi29.win32\Lib";^
"%TEE_CHART_PATH%\Compiled\Delphi29.win32\Lib";^
"%PYTHON4DELPHI_PATH%\Source";^
"%PYTHON4DELPHI_PATH%\Source\vcl";^
"%XLSREADWRITE_PATH%\SrcXLS";^
"%DEVEXPRESS_PATH%\ExpressCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressGDI+ Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressCommon Library\Sources";^
"%DEVEXPRESS_PATH%\XP Theme Manager\Sources";^
"%DEVEXPRESS_PATH%\ExpressLibrary\Sources";^
"%DEVEXPRESS_PATH%\ExpressExport Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressLayout Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressDataController\Sources";^
"%DEVEXPRESS_PATH%\ExpressEditors Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressMemData\Sources";^
"%DEVEXPRESS_PATH%\ExpressPageControl\Sources";^
"%DEVEXPRESS_PATH%\ExpressBars\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet Core\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpreadSheet\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumTreeList\Sources";^
"%DEVEXPRESS_PATH%\ExpressDocking Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressWizard Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressQuantumGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressSkins Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressOfficeCore Library\Sources";^
"%DEVEXPRESS_PATH%\ExpressRichEdit Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPDFViewer\Sources";^
"%DEVEXPRESS_PATH%\ExpressFlowChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressOrgChart\Sources";^
"%DEVEXPRESS_PATH%\ExpressGauge Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressMap Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressPivotGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressVerticalGrid\Sources";^
"%DEVEXPRESS_PATH%\ExpressDBTree Suite\Sources";^
"%DEVEXPRESS_PATH%\ExpressTile Control\Sources";^
"%DEVEXPRESS_PATH%\ExpressSpellChecker\Sources";^
"%DEVEXPRESS_PATH%\ExpressNavBar\Sources";^
"%DEVEXPRESS_PATH%\ExpressScheduler\Sources";^
"%DEVEXPRESS_PATH%\ExpressPrinting System\Sources";^
"%DEVEXPRESS_PATH%\ExpressEntityMapping Framework\Sources"

REM 其他选项
set OTHER_OPTS=-V -VN -NBC:\Users\Public\Documents\Embarcadero\Studio\23.0\Dcp -NHC:\Users\Public\Documents\Embarcadero\Studio\23.0\hpp\Win32 -NO.\Win32\Debug\DCU

REM ========================================
REM 项目文件
REM ========================================
set PROJECT_FILE=DelphiRagServer.dpr

REM ========================================
REM 构建最终命令
REM ========================================
set FINAL_COMMAND=%DCC32_PATH% %COMPILE_OPTS% %UNIT_ALIASES% %DEFINES% %OUTPUT_DIR% %INCLUDE_PATHS% %BPL_OUTPUT% %DCP_OUTPUT% %UNIT_OUTPUT% %NAMESPACES% %OBJ_PATHS% %RESOURCE_PATHS% %UNIT_PATHS% %OTHER_OPTS% %PROJECT_FILE%

REM ========================================
REM 显示命令并执行
REM ========================================
echo.
echo ========================================
echo 编译命令:
echo ========================================
echo %FINAL_COMMAND%
echo.
echo ========================================
echo 开始编译...
echo ========================================
echo.

%FINAL_COMMAND%

if %errorlevel% equ 0 (
    echo.
    echo 编译成功！
) else (
    echo.
    echo 编译失败，错误代码: %errorlevel%
)

pause
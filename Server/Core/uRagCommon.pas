//convert pas to utf8 by ¥
unit uRagCommon;

interface


uses
  Classes,
  SysUtils;


const
  ChunkSettingModes:Array [0..4] of string = ('auto','size','custom','dict','chapter');
  ChunkSettingCaptions:Array [0..4] of string = ('自动','根据大小分块','自定义分块','根据目录分块','根据章节分块');
  ChunkSettingDescriptions:Array [0..4] of string = ('自动','根据大小分块','自定义分块','根据目录分块','根据章节分块');

type
  // 文档切片类型
  // 根据token的大小
  // 根据文档目录
  // 根据章节
  // 根据自定义分隔符
  TChunkSettingMode=(tstAuto,tstSize,tstCustom,tstDirectory,tstChapter);





implementation

end.

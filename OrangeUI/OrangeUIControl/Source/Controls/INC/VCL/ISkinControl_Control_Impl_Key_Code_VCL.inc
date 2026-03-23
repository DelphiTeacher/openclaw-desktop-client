//convert pas to utf8 by ￥
//控件键盘消息实现


procedure {$I Source\Controls\INC\Common\ISkinComponent_Skin_Impl_ClassName.inc}.CNKeyDown(var Message:TWMKeyDown);
var
  ShiftState: TShiftState;
begin
  Inherited;
  if GetSkinControlType<>nil then
  begin
    ShiftState:=KeyDataToShiftState(Message.KeyData);
    TSkinControlType(GetSkinControlType).KeyDown(Message.CharCode,ShiftState);
  end;
end;


procedure {$I Source\Controls\INC\Common\ISkinComponent_Skin_Impl_ClassName.inc}.CNKeyUp(var Message:TWMKeyUp);
var
  ShiftState: TShiftState;
begin
  Inherited;
  if GetSkinControlType<>nil then
  begin
    ShiftState:=KeyDataToShiftState(Message.KeyData);
    TSkinControlType(GetSkinControlType).KeyUp(Message.CharCode,ShiftState);
  end;
end;



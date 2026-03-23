//convert pas to utf8 by ￥
//控件属性实现


function {$I Source\Controls\INC\Common\ISkinComponent_Skin_Impl_ClassName.inc}.GetProperties: TSkinControlProperties;
begin
  Result:=Self.FProperties;
end;

procedure {$I Source\Controls\INC\Common\ISkinComponent_Skin_Impl_ClassName.inc}.SetProperties(const Value: TSkinControlProperties);
begin
  FProperties.Assign(Value);
end;

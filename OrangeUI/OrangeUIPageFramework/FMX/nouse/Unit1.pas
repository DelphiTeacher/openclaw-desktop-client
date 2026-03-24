unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uListPageFrame,
  uTimerTask,
  XSuperObject,
//  uSkinSuperObject,
  uPageStructure,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyControl,
  uSkinScrollControlType, uSkinCustomListType, uSkinVirtualListType,
  uSkinListBoxType, uSkinFireMonkeyListBox;



type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SkinFMXListBox1: TSkinFMXListBox;
    SkinFMXItemDesignerPanel1: TSkinFMXItemDesignerPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FEditPageLayoutSetting:TPageLayoutSetting;
    FEditFieldControlList: TFieldControlList;
  private
    FItemPageLayoutSetting:TPageLayoutSetting;
    FItemFieldControlList: TFieldControlList;
    { Private declarations }
  public
//    FTestListPageFrame:TListPageFrame;
    procedure DoOnGetDataListClass(Sender:TTimerTask;AClass:TBaseListClass);
    procedure DoOnLoadDataInThread(Sender:TTimerTask);
    procedure DoOnLoadDataEndInUI(Sender:TTimerTask);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  AFieldControlSetting:TFieldControlSetting;
begin

  //布局设置
  FEditPageLayoutSetting:=TPageLayoutSetting.Create;
  FEditPageLayoutSetting.name:='login';
  FEditPageLayoutSetting.layout_type:='edit';
  FEditPageLayoutSetting.align_type:=Const_PageLayoutAlignType_Auto;
  FEditPageLayoutSetting.item_col_count:=2;//3;
  FEditPageLayoutSetting.item_col_width:=200;
  FEditPageLayoutSetting.item_height:=40;

  FEditPageLayoutSetting.hint_label_width:=60;
  FEditPageLayoutSetting.control_margins_top:=8;
  FEditPageLayoutSetting.control_height:=26;


  //控件设置
  AFieldControlSetting:=TFieldControlSetting.Create;
  AFieldControlSetting.fid:=0;
  AFieldControlSetting.control_type:='SkinEdit';
  AFieldControlSetting.name:='username';
  AFieldControlSetting.input_help_text:='请输入用户名';
  AFieldControlSetting.pic_path:='';
  AFieldControlSetting.value:='';
  AFieldControlSetting.has_hint_label:=1;
  AFieldControlSetting.hint_label_caption:='用户名';
  AFieldControlSetting.is_custom_position:=0;
  AFieldControlSetting.left:=0;
  AFieldControlSetting.top:=0;
  AFieldControlSetting.width:=-1;
  AFieldControlSetting.height:=-1;
  AFieldControlSetting.anchors:='';
  AFieldControlSetting.align:='';
  AFieldControlSetting.visible:=1;
  AFieldControlSetting.hittest:=1;
  AFieldControlSetting.enabled:=1;
  AFieldControlSetting.orderno:=0;
  FEditPageLayoutSetting.FieldControlSettingList.Add(AFieldControlSetting);


  //控件设置
  AFieldControlSetting:=TFieldControlSetting.Create;
  AFieldControlSetting.fid:=1;
  AFieldControlSetting.control_type:='SkinComboBox';
  AFieldControlSetting.name:='sex';
  AFieldControlSetting.input_help_text:='';
  AFieldControlSetting.pic_path:='';
  AFieldControlSetting.value:='';
  AFieldControlSetting.items:='[''男'',''女'',''保密'']';
  AFieldControlSetting.has_hint_label:=1;
  AFieldControlSetting.hint_label_caption:='性别';
  AFieldControlSetting.is_custom_position:=0;
  AFieldControlSetting.left:=0;
  AFieldControlSetting.top:=0;
  AFieldControlSetting.width:=-1;
  AFieldControlSetting.height:=-1;
  AFieldControlSetting.anchors:='';
  AFieldControlSetting.align:='';
  AFieldControlSetting.visible:=1;
  AFieldControlSetting.hittest:=1;
  AFieldControlSetting.enabled:=1;
  AFieldControlSetting.orderno:=1;
  FEditPageLayoutSetting.FieldControlSettingList.Add(AFieldControlSetting);



  FEditFieldControlList.CreateFieldControls(
    Self.Panel1,
    Self.FEditPageLayoutSetting
    );

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ADataJson:ISuperObject;
  ADataJsonArray:ISuperArray;
  AFieldControlSetting:TFieldControlSetting;
begin

  //布局设置
  FItemPageLayoutSetting:=TPageLayoutSetting.Create;
  FItemPageLayoutSetting.name:='listbox';
  FItemPageLayoutSetting.layout_type:='item_designer_panel';
  FItemPageLayoutSetting.align_type:=Const_PageLayoutAlignType_Auto;
  FItemPageLayoutSetting.item_col_count:=2;//3;
  FItemPageLayoutSetting.item_col_width:=200;
  FItemPageLayoutSetting.item_height:=40;

  FItemPageLayoutSetting.hint_label_width:=60;
  FItemPageLayoutSetting.control_margins_top:=8;
  FItemPageLayoutSetting.control_height:=26;


  //控件设置
  AFieldControlSetting:=TFieldControlSetting.Create;
  AFieldControlSetting.fid:=0;
  AFieldControlSetting.control_type:='SkinLabel';
  AFieldControlSetting.name:='username';
  AFieldControlSetting.input_help_text:='';
  AFieldControlSetting.pic_path:='';
  AFieldControlSetting.value:='';
  AFieldControlSetting.items:='';
  AFieldControlSetting.has_hint_label:=1;
  AFieldControlSetting.hint_label_caption:='用户名:';
  AFieldControlSetting.is_custom_position:=0;
  AFieldControlSetting.left:=0;
  AFieldControlSetting.top:=0;
  AFieldControlSetting.width:=-1;
  AFieldControlSetting.height:=-1;
  AFieldControlSetting.anchors:='';
  AFieldControlSetting.align:='';
  AFieldControlSetting.visible:=1;
  AFieldControlSetting.hittest:=0;
  AFieldControlSetting.enabled:=1;
  AFieldControlSetting.orderno:=0;
  AFieldControlSetting.bind_listitem_data_type:='ItemSubItems';
  AFieldControlSetting.field_name:='name';
  FItemPageLayoutSetting.FieldControlSettingList.Add(AFieldControlSetting);


  //控件设置
  AFieldControlSetting:=TFieldControlSetting.Create;
  AFieldControlSetting.fid:=1;
  AFieldControlSetting.control_type:='SkinLabel';
  AFieldControlSetting.name:='sex';
  AFieldControlSetting.input_help_text:='';
  AFieldControlSetting.pic_path:='';
  AFieldControlSetting.value:='';
  AFieldControlSetting.items:='';
  AFieldControlSetting.has_hint_label:=1;
  AFieldControlSetting.hint_label_caption:='性别:';
  AFieldControlSetting.is_custom_position:=0;
  AFieldControlSetting.left:=0;
  AFieldControlSetting.top:=0;
  AFieldControlSetting.width:=-1;
  AFieldControlSetting.height:=-1;
  AFieldControlSetting.anchors:='';
  AFieldControlSetting.align:='';
  AFieldControlSetting.visible:=1;
  AFieldControlSetting.hittest:=0;
  AFieldControlSetting.enabled:=1;
  AFieldControlSetting.orderno:=1;
  AFieldControlSetting.bind_listitem_data_type:='ItemSubItems';
  AFieldControlSetting.field_name:='sex';
  FItemPageLayoutSetting.FieldControlSettingList.Add(AFieldControlSetting);

  //控件设置
  AFieldControlSetting:=TFieldControlSetting.Create;
  AFieldControlSetting.fid:=2;
  AFieldControlSetting.control_type:='SkinImage';
  AFieldControlSetting.name:='head';
  AFieldControlSetting.input_help_text:='';
  AFieldControlSetting.pic_path:='https://avatar.csdn.net/7/9/6/3_delphiteacher.jpg';
  AFieldControlSetting.value:='';
  AFieldControlSetting.items:='';
  AFieldControlSetting.has_hint_label:=0;
  AFieldControlSetting.hint_label_caption:='';
  AFieldControlSetting.is_custom_position:=0;
  AFieldControlSetting.left:=0;
  AFieldControlSetting.top:=0;
  AFieldControlSetting.width:=100;
  AFieldControlSetting.height:=100;
  AFieldControlSetting.anchors:='';
  AFieldControlSetting.align:='';
  AFieldControlSetting.visible:=1;
  AFieldControlSetting.hittest:=0;
  AFieldControlSetting.enabled:=1;
  AFieldControlSetting.orderno:=2;
  AFieldControlSetting.bind_listitem_data_type:='ItemIcon';
  AFieldControlSetting.field_name:='head';
  FItemPageLayoutSetting.FieldControlSettingList.Add(AFieldControlSetting);



  FItemFieldControlList.CreateFieldControls(
    Self.SkinFMXItemDesignerPanel1,
    Self.FItemPageLayoutSetting
    );
//  FItemFieldControlList.AlignControls(
//    Self.SkinFMXItemDesignerPanel1,
//    Self.FItemPageLayoutSetting
//    );


  ADataJsonArray:=TSuperArray.Create;

  ADataJson:=TSuperObject.Create;
  ADataJson.S['name']:='王能';
  ADataJson.S['sex']:='男';
  ADataJson.S['head']:='https://avatar.csdn.net/7/9/6/3_delphiteacher.jpg';
  ADataJsonArray.O[ADataJsonArray.Length]:=ADataJson;

  ADataJson:=TSuperObject.Create;
  ADataJson.S['name']:='傅应文';
  ADataJson.S['sex']:='女';
  ADataJson.S['head']:='https://avatar.csdn.net/8/9/2/3_kongxingxing.jpg';
  ADataJsonArray.O[ADataJsonArray.Length]:=ADataJson;



  Self.SkinFMXListBox1.Prop.Items.Clear();


  //给Item赋值
  LoadDataJsonArrayToItems(
          ADataJsonArray,
          Self.SkinFMXListBox1.Prop.Items,
          FItemFieldControlList
          );

end;

procedure TForm1.DoOnGetDataListClass(Sender: TTimerTask; AClass: TBaseListClass);
begin
//  AClass:=
end;

procedure TForm1.DoOnLoadDataEndInUI(Sender: TTimerTask);
//var
//  I:Integer;
//  ASuperObject:ISuperObject;
//  ACardTemplate:TCardTemplate;
//  ACardTemplateList:TCardTemplateList;
//  AListBoxItem:TSkinListBoxItem;
begin
//  try
//    if TTimerTask(Sender).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(Sender).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//
//        ACardTemplateList:=TCardTemplateList.Create(ooReference);
//        Self.lbList.Prop.Items.BeginUpdate;
//        try
//
//            if FPageIndex=1 then
//            begin
//              GlobalManager.CardTemplateList.Clear(True);
//              Self.lbList.Prop.Items.Clear;
//            end;
//            ACardTemplateList.ParseFromJsonArray(TCardTemplate,ASuperObject.O['Data'].A['CardTemplateList']);
//
//            for I := 0 to ACardTemplateList.Count-1 do
//            begin
//
//                ACardTemplate:=ACardTemplateList[I];
//                GlobalManager.CardTemplateList.Add(ACardTemplate);
//
//                AListBoxItem:=Self.lbList.Prop.Items.Add;
//                AListBoxItem.Caption:=ACardTemplate.Name;
//                AListBoxItem.Icon.Url:=ACardTemplate.GetPreviewPicUrl(False);
//                AListBoxItem.Icon.PictureDrawType:=TPictureDrawType.pdtUrl;
//                AListBoxItem.Data:=ACardTemplate;
//
//                CalcItemSize(AListBoxItem);
//
//            end;
//        finally
//          Self.lbList.Prop.Items.EndUpdate;
//          FreeAndNil(ACardTemplateList);
//        end;
//
//      end
//      else
//      begin
//        //调用失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(Sender).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(Sender).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//     HideWaitingFrame;
//
//
//      if FPageIndex>1 then
//      begin
//          if ASuperObject.O['Data'].A['CardTemplateList'].Length>0 then
//          begin
//            Self.lbList.Prop.StopPullUpLoadMore('加载成功!',0,True);
//          end
//          else
//          begin
//            Self.lbList.Prop.StopPullUpLoadMore('下面没有了!',600,False);
//          end;
//      end
//      else
//      begin
//          Self.lbList.Prop.StopPullDownRefresh('刷新成功!',600);
//      end;
//  end;

end;

procedure TForm1.DoOnLoadDataInThread(Sender: TTimerTask);
begin
//  //出错
//  TTimerTask(Sender).TaskTag:=1;
//
//  try
//    TTimerTask(Sender).TaskDesc:=
//            SimpleCallAPI('get_user_recv_addr_list',
//                          nil,
//                          'http://www.orangeui.cn:10000/usercenter/',
//                          ['appid',
//                          'user_fid',
//                          'key'
//                          ],
//                          [1002,
//                          64,
//                          ''
//                          ]
//                          );
//    if TTimerTask(Sender).TaskDesc<>'' then
//    begin
//      TTimerTask(Sender).TaskTag:=0;
//    end;
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(Sender).TaskDesc:=E.Message;
//    end;
//  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  FTestListPageFrame:=TListPageFrame.Create(nil);
//  FTestListPageFrame.OnLoadDataInThread:=DoOnLoadDataInThread;
//  FTestListPageFrame.OnLoadDataEndInUI:=DoOnLoadDataEndInUI;
//  FTestListPageFrame.OnGetDataListClass:=DoOnGetDataListClass;
  FEditFieldControlList:=TFieldControlList.Create;

  FItemFieldControlList:=TFieldControlList.Create;



end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FEditFieldControlList);
  FreeAndNil(FItemFieldControlList);

  FreeAndNil(FEditPageLayoutSetting);
  FreeAndNil(FItemPageLayoutSetting);
end;

end.

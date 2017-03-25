unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NxEdit, Menus, NxCollection, ExtCtrls, ComCtrls,
  NxPropertyItems, NxPropertyItemClasses, NxScrollControl, NxInspector,
  NxColumns, NxColumnClasses, NxCustomGridControl, NxCustomGrid, NxGrid,
  TeEngine, Series, TeeProcs, Chart, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, idSync;

type
  TReadingThread = class(TThread)
  protected
    FConn: TIdTCPConnection;
    procedure Execute; override;
  public
    constructor Create(AConn: TIdTCPConnection); reintroduce;
  end;

  TLog = class(TIdSync)
  protected
    FMsg: String;
    procedure DoSynchronize; override;
  public
    constructor Create(const AMsg: String);
    class procedure AddMsg(const AMsg: String);
  end;

type
  TformMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Search1: TMenuItem;
    View1: TMenuItem;
    Setting1: TMenuItem;
    Help1: TMenuItem;
    StatusBar1: TStatusBar;
    NxPanelLeft: TNxPanel;
    NxSplitter1: TNxSplitter;
    NxPanelRight: TNxPanel;
    TreeView1: TTreeView;
    NxPanelTop: TNxPanel;
    NxPanelTopLeft: TNxPanel;
    NxPanelTopRight: TNxPanel;
    NxPanel1: TNxPanel;
    NxFlipPanel1: TNxFlipPanel;
    edSearch: TNxEdit;
    btnSearch: TNxButton;
    btnNext: TNxButton;
    btnBack: TNxButton;
    NextInspector1: TNextInspector;
    NxTextItem1: TNxTextItem;
    NxTextItem2: TNxTextItem;
    NxTextItem3: TNxTextItem;
    NxTextItem4: TNxTextItem;
    NxTextItem5: TNxTextItem;
    NxTextItem6: TNxTextItem;
    NxTextItem7: TNxTextItem;
    NxTextItem8: TNxTextItem;
    NxPanelRightTop: TNxPanel;
    NxSplitter2: TNxSplitter;
    NextGridObject: TNextGrid;
    NxTextColumn1: TNxTextColumn;
    NxTextColumn2: TNxTextColumn;
    NxTextColumn3: TNxTextColumn;
    NxTextColumn4: TNxTextColumn;
    NxHeaderPanel1: TNxHeaderPanel;
    NextGridLog: TNextGrid;
    NxTextColumn6: TNxTextColumn;
    NxTextColumn7: TNxTextColumn;
    Chart1: TChart;
    Series1: TFastLineSeries;
    NxSplitter3: TNxSplitter;
    Login1: TMenuItem;
    Logout1: TMenuItem;
    Exit1: TMenuItem;
    Next1: TMenuItem;
    Back1: TMenuItem;
    N1: TMenuItem;
    ut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    Find1: TMenuItem;
    FindClass1: TMenuItem;
    FindObject1: TMenuItem;
    FindUser1: TMenuItem;
    FindUsername1: TMenuItem;
    FindAddress1: TMenuItem;
    ViewStatus1: TMenuItem;
    ViewLog1: TMenuItem;
    ViewLogChart1: TMenuItem;
    ViewPacketLog1: TMenuItem;
    Schedule1: TMenuItem;
    Rule1: TMenuItem;
    User1: TMenuItem;
    Manual1: TMenuItem;
    About1: TMenuItem;
    NxTextColumn5: TNxIncrementColumn;
    IdTCPClient1: TIdTCPClient;
    ObjectSimulatorIPAddress1: TMenuItem;
    NxTextColumn8: TNxTextColumn;
    N2: TMenuItem;
    All1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Refresh1: TMenuItem;
    N3: TMenuItem;
    EditUser1: TMenuItem;
    DeleteUser1: TMenuItem;
    N4: TMenuItem;
    NxTextColumn9: TNxTextColumn;
    NxTextColumn10: TNxTextColumn;
    N5: TMenuItem;
    LimitUsage1: TMenuItem;
    NxTextColumn11: TNxTextColumn;
    AddObject1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure NextGridObjectAfterEdit(Sender: TObject; ACol, ARow: Integer;
      Value: WideString);
    procedure ObjectSimulatorIPAddress1Click(Sender: TObject);
    procedure TreeView1DblClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure NextGridObjectDblClick(Sender: TObject);
    procedure All1Click(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure Refresh1Click(Sender: TObject);
    procedure User1Click(Sender: TObject);
    procedure LimitUsage1Click(Sender: TObject);
    procedure Rule1Click(Sender: TObject);
    procedure AddObject1Click(Sender: TObject);
  private
    procedure UpdateObject(iObjectID, iStatus, iPower: Integer);
    procedure InsertIntoLog(iObjectID, iStatus, iPower: Integer);
    procedure Search(sKey: string);

    { Private declarations }
  public
    { Public declarations }
    __iFlipIndex: Integer;
    procedure ClearTreeView;
    procedure UpdateNextGridObject(iUsrID: Integer; iObjID: Integer);
    procedure UpdateNextGridLog(iUsrID: Integer; iObjID: Integer);
    procedure GetUserData(iUsrID: Integer);
    procedure GetSummary(iUsrID: Integer);
    procedure ClearnextInspector;
    procedure UpdateChart;

  end;

var
  formMain: TformMain;
  rt: TReadingThread = nil;

implementation

uses
  Login, FdtMdl, ObjectSimulatorIP, AddUser, Limit, ListRule, AddRule,
  AddObject;
{$R *.dfm}

constructor TLog.Create(const AMsg: String);
begin
  FMsg := AMsg;
  inherited Create;
end;

procedure TLog.DoSynchronize;
var
  s, sObjectId, sStatus, sPower: string;
  iBaris, iMaxPower, iObjUsrID: Integer;
begin
  s := FMsg;
  if s = 'OK' then
  begin
    formObjectSimulatorIPAddress.btnConnect.Caption := 'Disconnect';

    if formLogin.__iLevel = 0 then
    begin
      dtModul.ExecSQL('SELECT OBJ_ID, OBJ_STATUS'#13 + 'FROM OBJECT', [],
        dtModul.sqlQuery2);
    end
    else
    begin
      dtModul.ExecSQL('SELECT OBJ_ID, OBJ_STATUS'#13 + 'FROM OBJECT'#13 +
          'WHERE OBJ_USR_ID = %d', [formLogin.__iUserId], dtModul.sqlQuery2);
    end;
    dtModul.sqlQuery2.First;
    while not dtModul.sqlQuery2.Eof do
    begin
      formMain.IdTCPClient1.Socket.WriteLn
        ('@' + dtModul.sqlQuery2.Fields[0].AsString + '$' +
          dtModul.sqlQuery2.Fields[1].AsString);
      dtModul.sqlQuery2.Next;
    end;

  end
  else
  begin
    sObjectId := Copy(s, pos('#', s) + 1, pos('*', s) - (pos('#', s) + 1));
    sStatus := Copy(s, pos('*', s) + 1, pos('&', s) - (pos('*', s) + 1));
    sPower := Copy(s, pos('&', s) + 1, MaxInt);
    // tempat untuk eksekusi rule

    dtModul.ExecSQL('SELECT RULE_OBJ_OUT, RULE_OBJ_OUT_STATUS FROM RULE'#13 +
        'WHERE'#13 + 'RULE_OBJ_IN = %d'#13 + 'AND RULE_OBJ_IN_STATUS = %d',
      [StrToInt(sObjectId), StrToInt(sStatus)], dtModul.sqlQuery1);

    if not dtModul.sqlQuery1.IsEmpty then
    begin
      while not dtModul.sqlQuery1.Eof do
      begin
        formMain.IdTCPClient1.Socket.WriteLn
          ('#' + dtModul.sqlQuery1.Fields[0].AsString + '*' +
            dtModul.sqlQuery1.Fields[1].AsString);
        dtModul.sqlQuery1.Next;
      end;
    end;

    dtModul.ExecSQL('SELECT max_power.max_power FROM max_power'#13 +
        'JOIN user'#13 + 'ON max_power.cluster = user.usr_cluster'#13 +
        'JOIN object'#13 + 'ON user.usr_id = object.obj_usr_id'#13 +
        'WHERE object.obj_id = %d', [StrToInt(sObjectId)], dtModul.sqlQuery1);
    iMaxPower := dtModul.sqlQuery1.Fields[0].AsInteger;

    dtModul.ExecSQL('SELECT OBJ_USR_ID FROM OBJECT'#13 + 'WHERE OBJ_ID = %d',
      [StrToInt(sObjectId)], dtModul.sqlQuery1);
    iObjUsrID := dtModul.sqlQuery1.Fields[0].AsInteger;

    dtModul.ExecSQL('SELECT SUM(OBJ_POWER) FROM OBJECT'#13 +
        'WHERE OBJ_USR_ID = %d'#13 + 'AND OBJ_ID != %d',
      [iObjUsrID, StrToInt(sObjectId)], dtModul.sqlQuery1);

    if iMaxPower < (dtModul.sqlQuery1.Fields[0].AsInteger + StrToInt(sPower))
      then
    begin
      ShowMessage('The total power is exceed the limit!');
      dtModul.ExecSQL('SELECT OBJ_STATUS FROM OBJECT'#13 + 'WHERE OBJ_ID = %d',
        [StrToInt(sObjectId)], dtModul.sqlQuery1);
      formMain.IdTCPClient1.Socket.WriteLn
        ('#' + sObjectId + '*' + dtModul.sqlQuery1.Fields[0].AsString);
      Exit;
    end
    else
    begin
      formMain.UpdateObject(StrToInt(sObjectId), StrToInt(sStatus), StrToInt
          (sPower));
      formMain.InsertIntoLog(StrToInt(sObjectId), StrToInt(sStatus), StrToInt
          (sPower));
    end;
    if formLogin.__iLevel = 0 then
    begin
      formMain.UpdateNextGridObject(0, 0);
      formMain.UpdateNextGridLog(0, 0);
    end
    else
    begin
      formMain.UpdateNextGridObject(formLogin.__iUserId, 0);
      formMain.UpdateNextGridLog(formLogin.__iUserId, 0);
      formMain.GetSummary(formLogin.__iUserId);
    end;
  end;
end;

class procedure TLog.AddMsg(const AMsg: String);
begin

  with Create(AMsg) do
    try
      Synchronize;
    finally
      Free;
    end;
end;

constructor TReadingThread.Create(AConn: TIdTCPConnection);
begin
  FConn := AConn;
  inherited Create(False);
end;

procedure TReadingThread.Execute;
begin
  while not Terminated and FConn.Connected do
  begin
    // refer to my earlier message for this code...
    TLog.AddMsg(FConn.IOHandler.ReadLn);
  end;
end;

procedure TformMain.UpdateNextGridObject(iUsrID: Integer; iObjID: Integer);
var
  iBaris: Integer;
begin
  if iObjID <> 0 then
  begin
    dtModul.ExecSQL(
      'SELECT OBJ_ID, OBJ_NAME, OBJ_STATUS, OBJ_POWER, OBJ_CLASS, OBJ_IP'#13 +
        'FROM OBJECT'#13 + 'WHERE OBJ_ID = %d', [iObjID], dtModul.sqlQuery2);
  end
  else if iUsrID <> 0 then
  begin
    dtModul.ExecSQL(
      'SELECT OBJ_ID, OBJ_NAME, OBJ_STATUS, OBJ_POWER, OBJ_CLASS, OBJ_IP'#13 +
        'FROM OBJECT'#13 + 'WHERE OBJ_USR_ID = %d', [iUsrID],
      dtModul.sqlQuery2);
  end
  else
  begin
    dtModul.ExecSQL(
      'SELECT OBJ_ID, OBJ_NAME, OBJ_STATUS, OBJ_POWER, OBJ_CLASS, OBJ_IP'#13 +
        'FROM OBJECT', [], dtModul.sqlQuery2);
  end;

  dtModul.sqlQuery2.First;
  iBaris := 0;
  formMain.NextGridObject.ClearRows;
  while not dtModul.sqlQuery2.Eof do
  begin
    formMain.NextGridObject.AddRow(1);
    formMain.NextGridObject.Cell[0, iBaris].AsInteger :=
      dtModul.sqlQuery2.Fields[0].AsInteger;
    formMain.NextGridObject.Cell[1, iBaris].AsString := dtModul.sqlQuery2.Fields
      [1].AsString;
    formMain.NextGridObject.Cell[2, iBaris].AsInteger :=
      dtModul.sqlQuery2.Fields[2].AsInteger;
    formMain.NextGridObject.Cell[3, iBaris].AsInteger :=
      dtModul.sqlQuery2.Fields[3].AsInteger;
    formMain.NextGridObject.Cell[4, iBaris].AsString := dtModul.sqlQuery2.Fields
      [5].AsString;
    dtModul.sqlQuery2.Next;
    Inc(iBaris);
  end;
end;

Procedure TformMain.UpdateNextGridLog(iUsrID: Integer; iObjID: Integer);
var
  iBaris: Integer;
begin
  if iObjID <> 0 then
  begin
    dtModul.ExecSQL('SELECT LOG_OBJ_ID, LOG_TIME, LOG_STATUS, LOG_POWER'#13 +
        'FROM LOG'#13 + 'WHERE LOG_OBJ_ID = %d', [iObjID], dtModul.sqlQuery2);
  end
  else if iUsrID <> 0 then
  begin
    dtModul.ExecSQL(
      'SELECT LOG.LOG_OBJ_ID, LOG.LOG_TIME, LOG.LOG_STATUS, LOG.LOG_POWER'#13 +
        'FROM LOG'#13 + 'JOIN OBJECT'#13 +
        'ON LOG.LOG_OBJ_ID = OBJECT.OBJ_ID'#13 +
        'WHERE OBJECT.OBJ_USR_ID = %d', [iUsrID], dtModul.sqlQuery2);
  end
  else
  begin
    dtModul.ExecSQL('SELECT LOG_OBJ_ID, LOG_TIME, LOG_STATUS, LOG_POWER'#13 +
        'FROM LOG', [], dtModul.sqlQuery2);
  end;
  dtModul.sqlQuery2.First;
  iBaris := 0;
  formMain.NextGridLog.ClearRows;
  while not dtModul.sqlQuery2.Eof do
  begin
    formMain.NextGridLog.AddRow(1);
    formMain.NextGridLog.Cell[1, iBaris].AsString := dtModul.sqlQuery2.Fields[0]
      .AsString;
    formMain.NextGridLog.Cell[2, iBaris].AsString := dtModul.sqlQuery2.Fields[1]
      .AsString;
    formMain.NextGridLog.Cell[3, iBaris].AsString := dtModul.sqlQuery2.Fields[2]
      .AsString;
    formMain.NextGridLog.Cell[4, iBaris].AsString := dtModul.sqlQuery2.Fields[3]
      .AsString;
    dtModul.sqlQuery2.Next;
    Inc(iBaris);
  end;
  NextGridLog.ScrollToRow(NextGridLog.RowCount - 1);
end;

Procedure TformMain.UpdateObject(iObjectID: Integer; iStatus: Integer;
  iPower: Integer);
begin
  dtModul.ExecSQL('UPDATE OBJECT'#13 +
      'SET OBJ_STATUS = %d, OBJ_POWER = %d'#13 + 'WHERE OBJ_ID = %d',
    [iStatus, iPower, iObjectID], dtModul.sqlQuery1);
end;

procedure TformMain.User1Click(Sender: TObject);
begin
  formAddUser.edName.Text := '';
  formAddUser.edAddress.Text := '';
  formAddUser.edUsername.Text := '';
  formAddUser.edPassword.Text := '';
  formAddUser.cbUserLevel.ItemIndex := -1;
  formAddUser.NextGrid1.ClearRows;
  formAddUser.ShowModal;
end;

Procedure TformMain.InsertIntoLog(iObjectID: Integer; iStatus: Integer;
  iPower: Integer);
begin
  dtModul.ExecSQL(
    'INSERT INTO LOG (LOG_OBJ_ID, LOG_TIME, LOG_STATUS, LOG_POWER)'#13 +
      'VALUES (%d, NOW(), %d, %d)', [iObjectID, iStatus, iPower],
    dtModul.sqlQuery1);
end;

procedure TformMain.Search(sKey: string);
var
  iBaris: Integer;
begin
  if formLogin.__iLevel = 0 then
  begin
    dtModul.ExecSQL(
      'SELECT OBJECT.OBJ_ID, OBJECT.OBJ_NAME, OBJECT.OBJ_STATUS, OBJECT.OBJ_CLASS'#13
        + 'FROM OBJECT'#13 + 'JOIN USER'#13 +
        'ON OBJECT.OBJ_USR_ID = USER.USR_ID'#13 +
        'WHERE OBJECT.OBJ_ID = %d'#13 + 'OR OBJECT.OBJ_NAME LIKE "%s"'#13 +
        'OR USER.USR_NAME LIKE "%s"', [StrToIntDef(sKey, 0), '%' + sKey + '%',
      '%' + sKey + '%'], dtModul.sqlQuery2);
  end
  else
  begin
    dtModul.ExecSQL(
      'SELECT OBJECT.OBJ_ID, OBJECT.OBJ_NAME, OBJECT.OBJ_STATUS, OBJECT.OBJ_CLASS'#13
        + 'FROM OBJECT'#13 + 'JOIN USER'#13 +
        'ON OBJECT.OBJ_USR_ID = USER.USR_ID'#13 +
        'WHERE (OBJECT.OBJ_ID = %d'#13 + 'OR OBJECT.OBJ_NAME LIKE "%s")'#13 +
        'AND USER.USR_ID = %d', [StrToIntDef(sKey, 0), '%' + sKey + '%',
      formLogin.__iUserId], dtModul.sqlQuery2);
  end;
  dtModul.sqlQuery2.First;
  iBaris := 0;
  formMain.NextGridObject.ClearRows;
  while not dtModul.sqlQuery2.Eof do
  begin
    formMain.NextGridObject.AddRow(1);
    formMain.NextGridObject.Cell[0, iBaris].AsInteger :=
      dtModul.sqlQuery2.Fields[0].AsInteger;
    formMain.NextGridObject.Cell[1, iBaris].AsString := dtModul.sqlQuery2.Fields
      [1].AsString;
    formMain.NextGridObject.Cell[2, iBaris].AsInteger :=
      dtModul.sqlQuery2.Fields[2].AsInteger;
    dtModul.sqlQuery2.Next;
    Inc(iBaris);
  end;
end;

procedure TformMain.GetUserData(iUsrID: Integer);
begin
  dtModul.ExecSQL('SELECT USR_REALNAME, USR_ADDRESS FROM USER'#13 +
      'WHERE USR_ID = %d', [iUsrID], dtModul.sqlQuery2);
  NextInspector1.Items[1].Value := dtModul.sqlQuery2.Fields[0].AsString;
  NextInspector1.Items[2].Value := dtModul.sqlQuery2.Fields[1].AsString;

end;

procedure TformMain.GetSummary(iUsrID: Integer);
var
  iNumOfObj, iOn, iOff, iStatus: Integer;
  sStatus: string;
begin
  dtModul.ExecSQL('SELECT USR_STATUS FROM USER'#13 + 'WHERE USR_ID = %d',
    [iUsrID], dtModul.sqlQuery2);
  iStatus := dtModul.sqlQuery2.Fields[0].AsInteger;
  if iStatus = 1 then
    sStatus := 'Online'
  else
    sStatus := 'Offline';

  dtModul.ExecSQL('SELECT COUNT(OBJ_ID) FROM OBJECT'#13 +
      'WHERE OBJ_USR_ID = %d', [iUsrID], dtModul.sqlQuery2);
  iNumOfObj := dtModul.sqlQuery2.Fields[0].AsInteger;

  dtModul.ExecSQL('SELECT COUNT(OBJ_STATUS) FROM OBJECT'#13 +
      'WHERE OBJ_USR_ID = %d AND OBJ_STATUS = 0', [iUsrID], dtModul.sqlQuery2);
  iOff := dtModul.sqlQuery2.Fields[0].AsInteger;

  iOn := iNumOfObj - iOff;

  NextInspector1.Items[4].Value := sStatus;
  NextInspector1.Items[5].Value := IntToStr(iNumOfObj);
  NextInspector1.Items[6].Value := IntToStr(iOn);
  NextInspector1.Items[7].Value := IntToStr(iOff);
end;

procedure TformMain.ClearnextInspector;
begin
  NextInspector1.Items.ClearValues;
end;

procedure TformMain.ClearTreeView;
var
  i, x: Integer;
begin
  x := TreeView1.Items.Count;
  for i := 0 to x - 1 do
    TreeView1.Items[x - 1 - i].Delete;
end;

procedure TformMain.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Search(edSearch.Text);
end;

procedure TformMain.AddObject1Click(Sender: TObject);
begin
  formAddObject.ShowModal;
end;

procedure TformMain.All1Click(Sender: TObject);
begin
  if formLogin.__iLevel = 0 then
  begin
    UpdateNextGridObject(0, 0);
    UpdateNextGridLog(0, 0);
  end
  else
  begin
    UpdateNextGridObject(formLogin.__iUserId, 0);
    UpdateNextGridLog(formLogin.__iUserId, 0);
  end;
end;

procedure TformMain.btnSearchClick(Sender: TObject);
begin
  Search(edSearch.Text);
end;

procedure TformMain.Button3Click(Sender: TObject);
begin
  ClearTreeView;
end;

procedure TformMain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  __iFlipIndex := 1;
end;

procedure TformMain.FormShow(Sender: TObject);
begin
  formLogin.ShowModal;
end;

procedure TformMain.IdTCPClient1Connected(Sender: TObject);
begin
  rt := TReadingThread.Create(IdTCPClient1);
end;

procedure TformMain.IdTCPClient1Disconnected(Sender: TObject);
begin
  if rt <> nil then
  begin
    rt.Terminate;
    rt.WaitFor;
    FreeAndNil(rt);
  end;
end;

procedure TformMain.LimitUsage1Click(Sender: TObject);
begin
  formUsageLimit.ShowModal;
end;

procedure TformMain.Login1Click(Sender: TObject);
begin
  formLogin.edUsername.Text := '';
  formLogin.edPassword.Text := '';
  formLogin.ShowModal;
end;

procedure TformMain.Logout1Click(Sender: TObject);
begin
  formLogin.__bLogin := False;
  NextGridObject.ClearRows;
  NextGridLog.ClearRows;
  ClearTreeView;
end;

procedure TformMain.NextGridObjectAfterEdit
  (Sender: TObject; ACol, ARow: Integer; Value: WideString);
begin
  IdTCPClient1.Socket.WriteLn('#' + NextGridObject.Cell[0,
    NextGridObject.SelectedRow].AsString + '*' + NextGridObject.Cell[2,
    NextGridObject.SelectedRow].AsString);
end;

procedure TformMain.NextGridObjectDblClick(Sender: TObject);
var
  iBaris: Integer;
begin
  UpdateNextGridLog(0, NextGridObject.Cell[0, NextGridObject.SelectedRow]
      .AsInteger);
  UpdateChart;
end;

procedure TformMain.UpdateChart;
var
  iBaris: Integer;
begin
  Chart1.Series[0].Clear;
  for iBaris := 0 to NextGridLog.RowCount - 1 do
  begin
    Chart1.Series[0].AddXY(NextGridLog.Cell[0, iBaris].AsInteger,
      NextGridLog.Cell[4, iBaris].AsInteger, '', clBlue);
  end;
end;

procedure TformMain.ObjectSimulatorIPAddress1Click(Sender: TObject);
begin
  formObjectSimulatorIPAddress.ShowModal;
end;

procedure TformMain.Refresh1Click(Sender: TObject);
begin
  All1Click(nil);
end;

procedure TformMain.Rule1Click(Sender: TObject);
begin
  formListRule.ShowModal
end;

procedure TformMain.TreeView1DblClick(Sender: TObject);
var
  sText: string;
  iUserID, iObjID: Integer;
begin
  sText := TreeView1.Selected.Text;
  if pos('[', sText) > 0 then
  begin
    iUserID := StrToInt(Copy(sText, pos('[', sText) + 1, pos(']', sText) -
          (pos('[', sText) + 1)));
    GetUserData(iUserID);
    GetSummary(iUserID);
    UpdateNextGridObject(iUserID, 0);
    UpdateNextGridLog(iUserID, 0);
  end
  else if pos('(', sText) > 0 then
  begin
    iObjID := StrToInt(Copy(sText, pos('(', sText) + 1, pos(')', sText) -
          (pos('(', sText) + 1)));
    UpdateNextGridObject(0, iObjID);
    UpdateNextGridLog(0, iObjID);
  end;
end;

end.

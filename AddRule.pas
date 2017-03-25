unit AddRule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformAddRule = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbObjIn: TComboBox;
    editObjInStatus: TEdit;
    cbObjOut: TComboBox;
    editObjOutStatus: TEdit;
    tombolCancel: TButton;
    tombolOk: TButton;
    ipObj_in: TEdit;
    ipObj_out: TEdit;
    procedure tombolCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tombolOkClick(Sender: TObject);
    procedure cbObjInChange(Sender: TObject);
    procedure cbObjOutChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAddRule: TformAddRule;

implementation
  uses FdtMdl, Login, ListRule;

{$R *.dfm}

procedure TformAddRule.cbObjInChange(Sender: TObject);
var
  iObjInIdinput : Integer;
begin
iObjInIdinput := StrToInt(Copy( cbObjIn.Text, pos('(', cbObjIn.Text) + 1, pos(')', cbObjIn.Text) - (pos('(', cbObjIn.Text) + 1)));
dtModul.ExecSQL('SELECT OBJ_IP'#13 +
                'FROM OBJECT'#13 +
                'WHERE OBJ_ID = %d',
                [iObjInIdinput],
                dtModul.sqlQuery1);
ipObj_in.Text := dtModul.sqlQuery1.Fields[0].AsString;
end;

procedure TformAddRule.cbObjOutChange(Sender: TObject);
var
  iObjInIdoutput : Integer;
begin
iObjInIdoutput := StrToInt(Copy( cbObjOut.Text, pos('(', cbObjOut.Text) + 1, pos(')', cbObjOut.Text) - (pos('(', cbObjOut.Text) + 1)));
dtModul.ExecSQL('SELECT OBJ_IP'#13 +
                'FROM OBJECT'#13 +
                'WHERE OBJ_ID = %d',
                [iObjInIdoutput],
                dtModul.sqlQuery1);
ipObj_out.Text := dtModul.sqlQuery1.Fields[0].AsString;
end;

procedure TformAddRule.FormShow(Sender: TObject);
begin
  cbObjIn.Items.Clear;
  dtModul.ExecSQL('SELECT OBJ_ID, OBJ_NAME'#13 +
                    'FROM OBJECT'#13 +
                    'WHERE'#13 +
                    'OBJ_USR_ID = %d'#13 +
                    'AND OBJ_CLASS = 0',
                    [formLogin.__iUserId],
                    dtModul.sqlQuery1);

  dtModul.sqlQuery1.First;
  while not dtModul.sqlQuery1.Eof do
  begin
    cbObjIn.Items.Add('(' + dtModul.sqlQuery1.Fields[0].AsString + ') ' + dtModul.sqlQuery1.Fields[1].AsString);
    dtModul.sqlQuery1.Next;
  end;

  cbObjOut.Items.Clear;
  dtModul.ExecSQL('SELECT OBJ_ID, OBJ_NAME'#13 +
                    'FROM OBJECT'#13 +
                    'WHERE'#13 +
                    'OBJ_USR_ID = %d'#13 +
                    'AND OBJ_CLASS = 1',
                    [formLogin.__iUserId],
                    dtModul.sqlQuery1);

  dtModul.sqlQuery1.First;
  while not dtModul.sqlQuery1.Eof do
  begin
    cbObjOut.Items.Add('(' + dtModul.sqlQuery1.Fields[0].AsString + ') ' + dtModul.sqlQuery1.Fields[1].AsString);
    dtModul.sqlQuery1.Next;
  end;

end;

procedure TformAddRule.tombolCancelClick(Sender: TObject);
begin
  cbObjIn.Clear;
  editObjInStatus.Clear;
  cbObjOut.Clear;
  editObjOutStatus.Clear;
  ipObj_in.Clear;
  ipObj_out.Clear;
  formAddRule.Close;
end;
procedure TformAddRule.tombolOkClick(Sender: TObject);

var
  iBaris, iObjInId, iObjOutId : integer;
begin
  iObjInId := StrToInt(Copy( cbObjIn.Text, pos('(', cbObjIn.Text) + 1, pos(')', cbObjIn.Text) - (pos('(', cbObjIn.Text) + 1)));
  iObjOutId := StrToInt(Copy( cbObjOut.Text, pos('(', cbObjOut.Text) + 1, pos(')', cbObjOut.Text) - (pos('(', cbObjOut.Text) + 1)));

  dtModul.ExecSQL('INSERT INTO RULE (RULE_OBJ_IN, RULE_OBJ_IN_IP, RULE_OBJ_IN_STATUS, RULE_OBJ_OUT, RULE_OBJ_OUT_IP, RULE_OBJ_OUT_STATUS, RULE_USR_ID)'#13 +
  'VALUES'#13 +
  '(%d, "%s", %d, %d, "%s", %d, %d)',
  [iObjInId, ipObj_in.Text, StrToInt(editObjInStatus.Text), iObjOutId, ipObj_out.Text, StrToInt(editObjOutStatus.Text), formLogin.__iUserID],
   dtModul.sqlQuery1);
  //akses form schedule untuk update grid
  formListRule.gridListRule.ClearRows;
  dtModul.ExecSQL('SELECT * FROM RULE'#13 +
                     'WHERE'#13 +
                     'RULE_USR_ID = %d',
                     [formLogin.__iUserID],
                     dtModul.sqlQuery1);
     dtModul.sqlQuery1.First;
     iBaris := 0;
     while not dtModul.sqlQuery1.Eof do
     begin
          formListRule.gridListRule.AddRow(1);
          formListRule.gridListRule.Cell[0, iBaris].AsString := dtModul.sqlQuery1.Fields[0].AsString;
          formListRule.gridListRule.Cell[1, iBaris].AsString := dtModul.sqlQuery1.Fields[1].AsString;
          formListRule.gridListRule.Cell[3, iBaris].AsString := dtModul.sqlQuery1.Fields[2].AsString;
          formListRule.gridListRule.Cell[7, iBaris].AsString := dtModul.sqlQuery1.Fields[5].AsString;
          dtModul.ExecSQL('SELECT OBJ_NAME FROM OBJECT'#13 +
                          'WHERE OBJ_ID = %d',
                          [dtModul.sqlQuery1.Fields[1].AsInteger],
                          dtModul.sqlQuery2);

          formListRule.gridListRule.Cell[2, iBaris].AsString := dtModul.sqlQuery2.Fields[0].AsString;
          formListRule.gridListRule.Cell[4, iBaris].AsString := dtModul.sqlQuery1.Fields[3].AsString;
          formListRule.gridListRule.Cell[5, iBaris].AsString := dtModul.sqlQuery1.Fields[4].AsString;

          dtModul.ExecSQL('SELECT OBJ_NAME FROM OBJECT'#13 +
                          'WHERE OBJ_ID = %d',
                          [dtModul.sqlQuery1.Fields[4].AsInteger],
                          dtModul.sqlQuery2);

          formListRule.gridListRule.Cell[6, iBaris].AsString := dtModul.sqlQuery2.Fields[0].AsString;
          formListRule.gridListRule.Cell[8, iBaris].AsString := dtModul.sqlQuery1.Fields[6].AsString;
          dtModul.sqlQuery1.Next;
          Inc(iBaris);
     end;
      close;

      cbObjIn.Clear;
      editObjInStatus.Clear;
      cbObjOut.Clear;
      editObjOutStatus.Clear;
      ipObj_in.Clear;
      ipObj_out.Clear;
end;
end.

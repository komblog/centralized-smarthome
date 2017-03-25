unit UbahRule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformUbahRule = class(TForm)
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
    editIPObj_in: TEdit;
    editIPObj_Out: TEdit;
    procedure tombolOkClick(Sender: TObject);
    procedure tombolCancelClick(Sender: TObject);
    procedure cbObjInChange(Sender: TObject);
    procedure cbObjOutChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    __iScdID : integer;
  end;

var
  formUbahRule: TformUbahRule;

implementation
  uses FdtMdl, ListRule, Login;

{$R *.dfm}

procedure TformUbahRule.cbObjInChange(Sender: TObject);
var
  iObjInIdinput : Integer;
begin
iObjInIdinput := StrToInt(Copy( cbObjIn.Text, pos('(', cbObjIn.Text) + 1, pos(')', cbObjIn.Text) - (pos('(', cbObjIn.Text) + 1)));
dtModul.ExecSQL('SELECT OBJ_IP'#13 +
                'FROM OBJECT'#13 +
                'WHERE OBJ_ID = %d',
                [iObjInIdinput],
                dtModul.sqlQuery1);
editIPObj_in.Text := dtModul.sqlQuery1.Fields[0].AsString;
end;

procedure TformUbahRule.cbObjOutChange(Sender: TObject);
var
  iObjInIdoutput : Integer;
begin
iObjInIdoutput := StrToInt(Copy( cbObjOut.Text, pos('(', cbObjOut.Text) + 1, pos(')', cbObjOut.Text) - (pos('(', cbObjOut.Text) + 1)));
dtModul.ExecSQL('SELECT OBJ_IP'#13 +
                'FROM OBJECT'#13 +
                'WHERE OBJ_ID = %d',
                [iObjInIdoutput],
                dtModul.sqlQuery1);
editIPObj_Out.Text := dtModul.sqlQuery1.Fields[0].AsString;
end;

procedure TformUbahRule.tombolCancelClick(Sender: TObject);
begin
  cbObjIn.Clear;
  editObjInStatus.Clear;
  cbObjOut.Clear;
  editObjOutStatus.Clear;
  editIPObj_in.Clear;
  editIPObj_Out.Clear;
  formUbahRule.Close;
end;

procedure TformUbahRule.tombolOkClick(Sender: TObject);
var
  iObjInId, iObjOutId : integer;

  begin
  iObjInId := StrToInt(Copy( cbObjIn.Text, pos('(', cbObjIn.Text) + 1, pos(')', cbObjIn.Text) - (pos('(', cbObjIn.Text) + 1)));
  iObjOutId := StrToInt(Copy( cbObjOut.Text, pos('(', cbObjOut.Text) + 1, pos(')', cbObjOut.Text) - (pos('(', cbObjOut.Text) + 1)));
  dtModul.ExecSQL('UPDATE RULE'#13 +
                  'SET'#13 +
                  'RULE_OBJ_IN = %d,'#13 +
                  'RULE_OBJ_IN_IP = "%s",'#13 +
                  'RULE_OBJ_IN_STATUS = %d,'#13 +
                  'RULE_OBJ_OUT = %d,'#13 +
                  'RULE_OBJ_OUT_IP = "%s",'#13 +
                  'RULE_OBJ_OUT_STATUS = %d'#13 +
                  'WHERE RULE_ID = %d',
                  [iObjInId, editIPObj_in.Text, StrToInt(editObjInStatus.Text), iObjOutId, editIPObj_Out.Text, StrToInt(editObjOutStatus.Text), __iScdID],
                  dtModul.sqlQuery1);

  formListRule.tampilkanRule;
  close;

  cbObjIn.Clear;
  editObjInStatus.Clear;
  cbObjOut.Clear;
  editObjOutStatus.Clear;
  editIPObj_in.Clear;
  editIPObj_Out.Clear;
end;

end.

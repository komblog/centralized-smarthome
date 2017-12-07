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
    procedure tombolOkClick(Sender: TObject);
    procedure tombolCancelClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    __iScdID: integer;
  end;

var
  formUbahRule: TformUbahRule;

implementation

uses FdtMdl, ListRule, Login;
{$R *.dfm}

procedure TformUbahRule.tombolCancelClick(Sender: TObject);
begin
  cbObjIn.Clear;
  editObjInStatus.Clear;
  cbObjOut.Clear;
  editObjOutStatus.Clear;
  formUbahRule.Close;
end;

procedure TformUbahRule.tombolOkClick(Sender: TObject);
var
  iObjInId, iObjOutId: integer;

begin
  iObjInId := StrToInt(Copy(cbObjIn.Text, pos('(', cbObjIn.Text) + 1, pos
        (')', cbObjIn.Text) - (pos('(', cbObjIn.Text) + 1)));
  iObjOutId := StrToInt(Copy(cbObjOut.Text, pos('(', cbObjOut.Text) + 1, pos
        (')', cbObjOut.Text) - (pos('(', cbObjOut.Text) + 1)));
  dtModul.ExecSQL('UPDATE RULE'#13 + 'SET'#13 + 'RULE_OBJ_IN = %d,'#13 +
      'RULE_OBJ_IN_STATUS = %d,'#13 + 'RULE_OBJ_OUT = %d,'#13 +
      'RULE_OBJ_OUT_STATUS = %d'#13 + 'WHERE RULE_ID = %d',
    [iObjInId, StrToInt(editObjInStatus.Text), iObjOutId, StrToInt
      (editObjOutStatus.Text), __iScdID], dtModul.sqlQuery1);

  formListRule.tampilkanRule;
  Close;

  cbObjIn.Clear;
  editObjInStatus.Clear;
  cbObjOut.Clear;
  editObjOutStatus.Clear;
end;

end.

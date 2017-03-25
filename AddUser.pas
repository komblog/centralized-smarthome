unit AddUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
  NxColumnClasses, NxColumns;

type
  TformAddUser = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edName: TEdit;
    edUsername: TEdit;
    edPassword: TEdit;
    cbUserLevel: TComboBox;
    NextGrid1: TNextGrid;
    btnOK: TButton;
    btnCancel: TButton;
    btnAddObj: TButton;
    NxIncrementColumn1: TNxIncrementColumn;
    NxTextColumn2: TNxTextColumn;
    NxTextColumn3: TNxListColumn;
    NxTextColumn1: TNxTextColumn;
    edAddress: TEdit;
    procedure btnAddObjClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAddUser: TformAddUser;

implementation

uses
     FdtMdl;

{$R *.dfm}

procedure TformAddUser.btnAddObjClick(Sender: TObject);
var
     iBaris : integer;
begin
     NextGrid1.AddRow(1);
     iBaris := NextGrid1.RowCount;
     if iBaris = 1 then
     begin
          dtModul.ExecSQL('SELECT MAX(OBJ_ID) FROM OBJECT',
                          [],
                          dtModul.sqlQuery1);
          NextGrid1.Cell[1, 0].AsInteger := dtModul.sqlQuery1.Fields[0].AsInteger + 1;
     end
     else
     begin
          NextGrid1.Cell[1, iBaris - 1].AsInteger := NextGrid1.Cell[1, iBaris - 2].AsInteger + 1;
     end;
end;

procedure TformAddUser.btnCancelClick(Sender: TObject);
begin
     Close;
end;

procedure TformAddUser.btnOKClick(Sender: TObject);
var
     iUserID, iBaris : integer;
begin
     dtModul.ExecSQL('SELECT MAX(USR_ID) FROM USER',
                     [],
                     dtModul.sqlQuery1);
     iUserID := dtModul.sqlQuery1.Fields[0].AsInteger + 1;

     dtModul.ExecSQL('INSERT INTO USER (USR_ID, USR_NAME, USR_PASSWORD, USR_LEVEL, USR_REALNAME, USR_ADDRESS, USR_STATUS)'#13 +
                     'VALUES'#13 +
                     '(%d, "%s", "%s", %d, "%s", "%s", 1)',
                     [iUserID,
                      edUsername.Text,
                      edPassword.Text,
                      cbUserLevel.ItemIndex,
                      edName.Text,
                      edAddress.Text],
                     dtModul.sqlQuery1);

     for iBaris := 0 to NextGrid1.RowCount - 1 do
     begin
          dtModul.ExecSQL('INSERT INTO OBJECT (OBJ_ID, OBJ_NAME, OBJ_CLASS, OBJ_USR_ID, OBJ_STATUS)'#13 +
                          'VALUES'#13 +
                          '(%d, "%s", %d, %d, 0)',
                          [NextGrid1.Cell[1, iBaris].AsInteger,
                           NextGrid1.Cell[2, iBaris].AsString,
                           NextGrid1.Cell[3, iBaris].AsInteger - 1,
                           iUserID],
                          dtModul.sqlQuery1);
     end;
     close;
end;

end.

unit ListRule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NxColumns, NxColumnClasses, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid;

type
  TformListRule = class(TForm)
    gridListRule: TNextGrid;
    NxTextColumn1: TNxTextColumn;
    NxTextColumn2: TNxTextColumn;
    tombolTambah: TButton;
    NxComboBoxColumn1: TNxTextColumn;
    NxComboBoxColumn2: TNxTextColumn;
    tombolHapus: TButton;
    tombolEdit: TButton;
    NxIncrementColumn1: TNxTextColumn;
    NxTextColumn3: TNxTextColumn;
    NxTextColumn4: TNxTextColumn;
    tombolKirimRule: TButton;
    NxTextColumn5: TNxTextColumn;
    NxTextColumn6: TNxTextColumn;
    procedure tombolTambahClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tombolHapusClick(Sender: TObject);
    procedure tombolEditClick(Sender: TObject);
    procedure tombolKirimRuleClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure tampilkanRule;
    { Public declarations }
  end;

var
  formListRule: TformListRule;

implementation
  uses AddRule, Main, Login, FdtMdl, UbahRule;

{$R *.dfm}

procedure TformListRule.FormShow(Sender: TObject);
begin
  tampilkanRule;
end;

procedure TformListRule.tampilkanRule;
var
    iBaris : integer;
begin

    formListRule.gridListRule.ClearRows;
    dtModul.ExecSQL('SELECT RULE_ID, RULE_OBJ_IN, RULE_OBJ_IN_IP, RULE_OBJ_IN_STATUS, RULE_OBJ_OUT, RULE_OBJ_OUT_IP, RULE_OBJ_OUT_STATUS, RULE_USR_ID FROM RULE'#13 +
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

end;

procedure TformListRule.tombolEditClick(Sender: TObject);
var
  iBaris : Integer;
begin
  formUbahRule.cbObjIn.Clear;
  dtModul.ExecSQL('SELECT OBJ_ID, OBJ_NAME'#13 +
                    'FROM OBJECT'#13 +
                    'WHERE OBJ_USR_ID = %d'#13 +
                    'AND OBJ_CLASS = 0',
                    [formLogin.__iUserId],
                    dtModul.sqlQuery1);

  dtModul.sqlQuery1.First;
  while not dtModul.sqlQuery1.Eof do
  begin
    formUbahRule.cbObjIn.Items.Add('(' + dtModul.sqlQuery1.Fields[0].AsString + ') ' + dtModul.sqlQuery1.Fields[1].AsString);
    dtModul.sqlQuery1.Next;
  end;

  formUbahRule.cbObjOut.Items.Clear;
  dtModul.ExecSQL('SELECT OBJ_ID, OBJ_NAME'#13 +
                    'FROM OBJECT'#13 +
                    'WHERE OBJ_USR_ID = %d'#13 +
                    'AND OBJ_CLASS = 1',
                    [formLogin.__iUserId],
                    dtModul.sqlQuery1);

  dtModul.sqlQuery1.First;
  while not dtModul.sqlQuery1.Eof do
  begin
    formUbahRule.cbObjOut.Items.Add('(' + dtModul.sqlQuery1.Fields[0].AsString + ') ' + dtModul.sqlQuery1.Fields[1].AsString);
    dtModul.sqlQuery1.Next;
  end;

     iBaris := gridListRule.SelectedRow;
     formUbahRule.__iScdID := gridListRule.Cell[0, iBaris].AsInteger;
     formUbahRule.cbObjIn.Text := '(' + gridListRule.Cell[1, iBaris].AsString + ') ' + gridListRule.Cell[2, iBaris].AsString;
     formUbahRule.editObjInStatus.Text := gridListRule.Cell[4, iBaris].AsString;
     formUbahRule.cbObjOut.Text := '(' + gridListRule.Cell[5, iBaris].AsString + ') ' + gridListRule.Cell[6, iBaris].AsString;
     formUbahRule.editObjOutStatus.Text := gridListRule.Cell[8, iBaris].AsString;
     formUbahRule.ShowModal;
end;

procedure TformListRule.tombolHapusClick(Sender: TObject);
var
  iBaris, iNo : Integer;
  waktu : string;
begin
     if(application.MessageBox('Apakah Anda Yakin Ingin Menghapus Rule Ini?','Konfirmasi',MB_YesNo)=ID_yes) then
     begin
          iBaris := gridListRule.SelectedRow;
          iNo := gridListRule.Cell[0,iBaris].AsInteger;

               dtModul.ExecSQL('DELETE FROM RULE'#13 +
                              'WHERE RULE_ID = %d',
                              [iNo],
                              dtModul.sqlQuery1);

          tampilkanRule;
     end;
end;

procedure TformListRule.tombolKirimRuleClick(Sender: TObject);
var
  iBaris : Integer;
  sObj_In_Name, sObj_Out_Name : string;
begin
    dtModul.ExecSQL('SELECT RULE_ID, RULE_OBJ_IN, RULE_OBJ_IN_IP, RULE_OBJ_IN_STATUS, RULE_OBJ_OUT, RULE_OBJ_OUT_IP, RULE_OBJ_OUT_STATUS, RULE_USR_ID FROM RULE'#13 +
                  'WHERE RULE_USR_ID = %d',
                  [formLogin.__iUserID],
                  dtModul.sqlQuery1);

  if not dtModul.sqlQuery1.IsEmpty then
    begin
      dtModul.sqlQuery1.First;
      iBaris := 0;
      while not dtModul.sqlQuery1.Eof do
        begin
          sObj_In_Name := gridListRule.Cell[2,iBaris].AsString;
          sObj_Out_Name := gridListRule.Cell[6,iBaris].AsString;
          formMain.IdTCPClient1.Socket.WriteLn('@' + dtModul.sqlQuery1.Fields[0].AsString + '#' + dtModul.sqlQuery1.Fields[1].AsString + '(' + dtModul.sqlQuery1.Fields[2].AsString + '^' + sObj_In_Name + '$' + dtModul.sqlQuery1.Fields[3].AsString + '%' + dtModul.sqlQuery1.Fields[4].AsString + '+' + sObj_Out_Name + ')' + dtModul.sqlQuery1.Fields[5].AsString + '*' + dtModul.sqlQuery1.Fields[6].AsString + '&' + dtModul.sqlQuery1.Fields[7].AsString);
          dtModul.sqlQuery1.Next;
          Inc(iBaris);
        end;
    end;

    Application.MessageBox('Rule berhasil dikirim', 'Berhasil', MB_OK)

end;

procedure TformListRule.tombolTambahClick(Sender: TObject);
begin
  formAddRule.showmodal;
end;

end.

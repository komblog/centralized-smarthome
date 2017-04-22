unit AddObject;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, INIFiles;

type
  TformAddObject = class(TForm)
    namaObject: TLabel;
    tipeObject: TLabel;
    powerObject: TLabel;
    IP: TLabel;
    editNamaObject: TEdit;
    cbTipeObject: TComboBox;
    editPower: TEdit;
    editIP: TEdit;
    objId: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure cbTipeObjectChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAddObject: TformAddObject;

implementation
  uses FdtMdl, Login;

{$R *.dfm}



procedure TformAddObject.Button1Click(Sender: TObject);
begin
  editNamaObject.Clear;
  cbTipeObject.Clear;
  editPower.Clear;
  editIP.Clear;
  objId.Clear;
  formAddObject.Close;
end;

procedure TformAddObject.Button2Click(Sender: TObject);
var
  i : Integer;
  dir : string;
  myObj : TIniFile;
  indexObjectList : TStringList;
begin
  dir := ExtractFileDir(GetCurrentDir)+'\Object_Simulator\';
  myObj := TIniFile.Create( dir + 'Settings.ini' );

  dtModul.ExecSQL('SELECT COUNT(OBJ_ID) FROM OBJECT',[],dtModul.sqlQuery1);
  i := dtModul.sqlQuery1.Fields[0].AsInteger;

  myObj.WriteString('SETTINGS', IntToStr(i+1), IntToStr(i+1));
  myObj.WriteString('SETTINGS', 'name'+IntToStr(i+1), editNamaObject.Text);
  myObj.WriteInteger('SETTINGS', 'power'+IntToStr(i+1), StrToInt(editPower.Text));
  myObj.WriteString('SETTINGS', 'IP'+IntToStr(i+1), editIP.Text);
  myObj.WriteInteger('SETTINGS', 'status'+IntToStr(i+1), 0);
  myObj.WriteInteger('SETTINGS', 'USR_ID'+IntToStr(i+1), formLogin.__iUserID);
  myObj.Free;


  dtModul.ExecSQL('INSERT INTO OBJECT (OBJ_ID, OBJ_NAME, OBJ_CLASS, OBJ_USR_ID, OBJ_POWER, OBJ_IP)'#13 +
                  'VALUES'#13 +
                  '(%d, "%s", %d, %d, %d, "%s")',
                  [i+1 ,editNamaObject.Text, StrToInt(objId.Text), formLogin.__iUserID, StrToInt(editPower.Text), editIP.Text],
                  dtModul.sqlQuery1);
 close;

 editNamaObject.Clear;
 cbTipeObject.Clear;
 editPower.Clear;
 editIP.Clear;
 objId.Clear;
end;

procedure TformAddObject.cbTipeObjectChange(Sender: TObject);
begin
  if cbTipeObject.Text = 'Input' then
    begin
      objId.Text := IntToStr(0) ;
    end
  else
    begin
      objId.Text := IntToStr(1);
    end;
end;

end.

unit Limit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformUsageLimit = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cbCluster: TComboBox;
    edMaxPower: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbClusterChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formUsageLimit: TformUsageLimit;

implementation

uses
     FdtMdl;

{$R *.dfm}

procedure TformUsageLimit.btnCancelClick(Sender: TObject);
begin
     close;
end;

procedure TformUsageLimit.btnOKClick(Sender: TObject);
begin
     if cbCluster.ItemIndex = 0 then
     begin
          dtModul.ExecSQL('UPDATE MAX_POWER'#13 +
                          'SET MAX_POWER = %d',
                          [StrToInt(edMaxPower.Text)],
                          dtModul.sqlQuery1);
     end
     else
     begin
          dtModul.ExecSQL('UPDATE MAX_POWER'#13 +
                          'SET MAX_POWER = %d'#13 +
                          'WHERE CLUSTER = %d',
                          [StrToInt(edMaxPower.Text), StrToInt(cbCluster.Text)],
                          dtModul.sqlQuery1);
     end;
     close;
end;

procedure TformUsageLimit.cbClusterChange(Sender: TObject);
begin
     if cbCluster.ItemIndex <> 0 then
     begin
          dtModul.ExecSQL('SELECT MAX_POWER FROM MAX_POWER'#13 +
                          'WHERE CLUSTER = %d',
                          [StrToInt(cbCluster.Text)],
                          dtModul.sqlQuery1);
          edMaxPower.Text := dtModul.sqlQuery1.Fields[0].AsString;
     end
     else
          edMaxPower.Text := '';
end;

procedure TformUsageLimit.FormShow(Sender: TObject);
begin
     cbCluster.Items.Clear;
     cbCluster.Items.Add('All');
     dtModul.ExecSQL('SELECT CLUSTER FROM MAX_POWER',
                     [],
                     dtModul.sqlQuery1);
     while not dtModul.sqlQuery1.Eof do
     begin
          cbCluster.Items.Add(dtModul.sqlQuery1.Fields[0].AsString);
          dtModul.sqlQuery1.Next;
     end;
end;

end.

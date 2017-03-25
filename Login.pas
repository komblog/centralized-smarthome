unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NxCollection, StdCtrls, NxEdit;

type
  TformLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edUsername: TNxEdit;
    edPassword: TNxEdit;
    btnCancel: TNxButton;
    btnOK: TNxButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    __bLogin : boolean;
    __iUserID : integer;
    __iLevel : integer;
  end;

var
  formLogin: TformLogin;

implementation

uses
     FdtMdl, Main;

{$R *.dfm}

procedure TformLogin.btnCancelClick(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TformLogin.btnOKClick(Sender: TObject);
var
     iBaris, iNode : integer;
begin
     if (edUsername.Text = '') or (edPassword.Text = '') then
     begin
          ShowMessage('Please insert your username and password!');
     end
     else
     begin
          dtModul.ExecSQL('SELECT USR_ID, USR_PASSWORD, USR_LEVEL'#13 +
                          'FROM USER'#13 +
                          'WHERE USR_NAME = "%s"',
                          [edUsername.Text],
                          dtModul.sqlQuery1);
          __iUserID := dtModul.sqlQuery1.Fields[0].AsInteger;
          __iLevel := dtModul.sqlQuery1.Fields[2].AsInteger;
          if dtModul.sqlQuery1.Fields[1].AsString = edPassword.Text then
          begin
               if dtModul.sqlQuery1.Fields[2].AsInteger = 0 then //if admin
               begin
                    dtModul.ExecSQL('SELECT USR_ID, USR_NAME'#13 +
                                    'FROM USER'#13 +
                                    'WHERE USR_LEVEL = 1',
                                    [],
                                    dtModul.sqlQuery2);
                    dtModul.sqlQuery2.First;
                    iBaris := 0;
                    formMain.ClearTreeView;
                    while not dtModul.sqlQuery2.Eof do
                    begin
                         formMain.TreeView1.Items.AddChild(nil, '[' + dtModul.sqlQuery2.Fields[0].AsString + ']' + dtModul.sqlQuery2.Fields[1].AsString);
                         iNode := formMain.TreeView1.Items.Count - 1;
                         dtModul.ExecSQL('SELECT OBJ_ID, OBJ_NAME'#13 +
                                         'FROM OBJECT'#13 +
                                         'WHERE OBJ_USR_ID = %d',
                                         [dtModul.sqlQuery2.Fields[0].AsInteger],
                                         dtModul.sqlQuery3);
                         dtModul.sqlQuery3.First;
                         while not dtModul.sqlQuery3.Eof do
                         begin
                              formMain.TreeView1.Items.AddChild(formMain.TreeView1.Items[iNode], '(' + dtModul.sqlQuery3.Fields[0].AsString + ') ' + dtModul.sqlQuery3.Fields[1].AsString);
                              dtModul.sqlQuery3.Next;
                         end;
                         dtModul.sqlQuery2.Next;
                    end;

                    formMain.ClearnextInspector;
                    formMain.UpdateNextGridObject(0, 0);
                    formMain.UpdateNextGridLog(0, 0);

                    formMain.User1.Visible := True;
                    formMain.DeleteUser1.Visible := True;
                    formMain.EditUser1.Visible := True;
                    formMain.LimitUsage1.Visible := True;

                    __bLogin := True;
                    Close;
               end
               else //not admin
               begin
                    dtModul.ExecSQL('SELECT OBJ_ID, OBJ_NAME'#13 +
                                    'FROM OBJECT'#13 +
                                    'WHERE OBJ_USR_ID = %d',
                                    [__iUserID],
                                    dtModul.sqlQuery3);
                    dtModul.sqlQuery3.First;
                    while not dtModul.sqlQuery3.Eof do
                    begin
                         formMain.TreeView1.Items.AddChild(nil, '(' + dtModul.sqlQuery3.Fields[0].AsString + ') ' + dtModul.sqlQuery3.Fields[1].AsString);
                         dtModul.sqlQuery3.Next;
                    end;

                    formMain.GetUserData(__iUserID);
                    formMain.GetSummary(__iUserID);
                    formMain.UpdateNextGridObject(__iUserID, 0);
                    formMain.UpdateNextGridLog(__iUserID, 0);

                    formMain.User1.Visible := False;
                    formMain.DeleteUser1.Visible := False;
                    formMain.EditUser1.Visible := False;
                    formMain.LimitUsage1.Visible := False;

                    __bLogin := True;
                    Close;
               end;
               formMain.Caption := 'Kontrol dan Monitoring - ' + edUsername.Text;
          end
          else
          begin
               __bLogin := False;
               ShowMessage('Your username or password is wrong!');
          end;
     end;
end;

procedure TformLogin.edPasswordKeyPress(Sender: TObject; var Key: Char);
begin
     if Key = #13 then
     btnOKClick(nil);
end;

end.

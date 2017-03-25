unit ObjectSimulatorIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NxCollection, StdCtrls, NxEdit;

type
  TformObjectSimulatorIPAddress = class(TForm)
    edIP: TNxEdit;
    Label1: TLabel;
    btnConnect: TNxButton;
    Label2: TLabel;
    edPort: TNxEdit;
    NxButton1: TNxButton;
    procedure btnConnectClick(Sender: TObject);
    procedure NxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    __bConnect : boolean;
  end;

var
  formObjectSimulatorIPAddress: TformObjectSimulatorIPAddress;

implementation

uses
     Main, Login;

{$R *.dfm}

procedure TformObjectSimulatorIPAddress.btnConnectClick(Sender: TObject);
begin
     formMain.IdTCPClient1.Port := StrToInt(edPort.Text);
     if not __bConnect then
     begin
          formMain.IdTCPClient1.Host := trim( edIP.Text );
          try
             formMain.IdTCPClient1.Connect;
             formMain.IdTCPClient1.Socket.WriteLn('!CON'+'@'+IntToStr(formLogin.__iUserID));
             __bConnect := True;
          except
                Application.MessageBox( 'Can not connect to Object Simulator!',
                                        'Error', MB_OK + MB_ICONSTOP );
                exit;
          end;
     end
     else
     begin
          formMain.IdTCPClient1.Disconnect;
          btnConnect.Caption := 'Connect';
          __bConnect := False;
     end;
end;

procedure TformObjectSimulatorIPAddress.NxButton1Click(Sender: TObject);
begin
     Close;
end;

end.

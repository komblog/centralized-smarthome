program Central_Smarthome;

uses
  Forms,
  Main in 'Main.pas' {formMain},
  FdtMdl in 'FdtMdl.pas' {dtModul: TDataModule},
  Login in 'Login.pas' {formLogin},
  ObjectSimulatorIP in 'ObjectSimulatorIP.pas' {formObjectSimulatorIPAddress},
  AddUser in 'AddUser.pas' {formAddUser},
  Limit in 'Limit.pas' {formUsageLimit},
  ListRule in 'ListRule.pas' {formListRule},
  AddRule in 'AddRule.pas' {formAddRule},
  UbahRule in 'UbahRule.pas' {formUbahRule},
  AddObject in 'AddObject.pas' {formAddObject};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtModul, dtModul);
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformObjectSimulatorIPAddress, formObjectSimulatorIPAddress);
  Application.CreateForm(TformAddUser, formAddUser);
  Application.CreateForm(TformUsageLimit, formUsageLimit);
  Application.CreateForm(TformListRule, formListRule);
  Application.CreateForm(TformAddRule, formAddRule);
  Application.CreateForm(TformUbahRule, formUbahRule);
  Application.CreateForm(TformAddObject, formAddObject);
  Application.Run;
end.

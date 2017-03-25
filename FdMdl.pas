unit FdMdl;

interface

uses
  SysUtils, Classes, UniProvider, MySQLUniProvider, DB, DBAccess, Uni, MemDS;

type
  TDataModule1 = class(TDataModule)
    UniConnection1: TUniConnection;
    MySQLUniProvider1: TMySQLUniProvider;
    UniQuery1: TUniQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.

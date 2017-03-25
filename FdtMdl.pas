unit FdtMdl;

interface

uses
  SysUtils, Classes, Dialogs, StrUtils, Forms, Clipbrd, NxGrid, Mask,
  OleServer, DB, DBTables, SQLServerUniProvider, Uni, DBAccess, MemDS, Variants,
  Word2000, INIFiles, Windows, Controls, Graphics, ComCtrls, UniProvider,
  MySQLUniProvider;

type
  TdtModul = class(TDataModule)
    Database1: TUniConnection;
    sqlQuery1: TUniQuery;
    sqlQuery2: TUniQuery;
    MySQLUniProvider1: TMySQLUniProvider;
    sqlQuery3: TUniQuery;
    function ExecSQL(const sSQL: String; const Args: array of const;
      oQuery: TUniQuery; sPesan : string = ''): Boolean;
    function ValidSQLString(sSQL: String): String;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure Database1Error(Sender: TObject; E: EDAError;
      var Fail: Boolean);
    function OpenConnection: boolean;
   { Private declarations }
  public
    { Public declarations }
    __sServerName : string;
    __sUserName : string;
    __sPassword : string;
    __sDatabase : string;
    __iErrorCode : integer;
end;

var
  dtModul: TdtModul;

implementation

{$R *.dfm}


function TdtModul.ExecSQL(const sSQL: String;
  const Args: array of const; oQuery: TUniQuery; sPesan : string = '' ): Boolean;
var
   bActive : Boolean;
begin
     if oQuery = nil then
        oQuery := sqlQuery1;

     oQuery.Close;

     if Length(Args) = 0 then
        oQuery.SQL.Text := ValidSQLString( sSQL )
     else
         oQuery.SQL.Text := ValidSQLString( Format( sSQL, Args ) );

     oQuery.SQL.Text := oQuery.SQL.Text;

     bActive := True;

     try
        If UpperCase( Copy( sSQL, 1, 4 ) ) = 'SELE' then
        begin
             oQuery.Open;
             bActive := (oQuery.Active and not oQuery.IsEmpty);
        end
        else
        begin
             oQuery.Execute;
        end;
     except
           on E:Exception do
           begin
                Application.MessageBox( PChar( E.Message + #13#13 +
                                               oQuery.SQL.Text + #13#13 +
                                               ifThen( sPesan = '',
                                                       '',
                                                       '( ada masalah saat mengeksekusi variabel berikut : ' + sPesan + ' )' ) +
                                               #13#13 +
                                               'Catat dan kirim pesan kesalahan di atas ke administrator aplikasi ...' ),
                                        'SQL Error', MB_OK + MB_ICONSTOP );
                bActive := False;
           end;
     end;

     Result := bActive;
end;

function TdtModul.ValidSQLString(sSQL: String): String;
begin
     Result := StringReplace(StringReplace(StringReplace(sSQL,'""','" "',[rfReplaceAll,rfIgnoreCase]),
                                                #39,#39+#39,[rfReplaceAll,rfIgnoreCase]),
                                  '"',#39,[rfReplaceAll,rfIgnoreCase] );
end;

procedure TdtModul.Database1Error(Sender: TObject; E: EDAError;
  var Fail: Boolean);
begin
     case E.ErrorCode of
     18456 : //login failed for user xxx
     begin
          Application.MessageBox( 'Sepertinya nama user / password koneksi database anda tidak benar, silahkan coba isi User Name = sa dan password dikosongi kemudian klik Test, jika tidak bisa isi password dengan peradilan, kemudian klik Test lagi.',
                                  'Password', MB_OK + MB_ICONWARNING );
          __iErrorCode := E.ErrorCode;
          Fail := false;
     end;
     4060 : //Cannot open database requested in login 'siadpaWinxx'. Login fails.
     begin
          Application.MessageBox( 'Sepertinya Database belum terinstall, silahkan install database menggunakan aplikasi DatabaseTools',
                                  'Database', MB_OK + MB_ICONWARNING );
          __iErrorCode := E.ErrorCode;
          Fail := false;
     end;
     17 : //[DBNETLIB][ConnectionOpen (Connect()).]SQL Server does not exist or access denied.
     begin
          Application.MessageBox( 'Sepertinya Server belum aktif, atau MSSQLSERVER belum terinstall di server atau belum jalan atau nama server anda salah, silahkan dicek...',
                                  'Server', MB_OK + MB_ICONWARNING );
          __iErrorCode := E.ErrorCode;
          Fail := false;
     end
     else
          Application.MessageBox( PChar( 'Koneksi tidak berhasil dengan pesan error sebagai berikut :'#13#13 +
                                         E.Message), 'Error', MB_OK + MB_ICONSTOP );
         __iErrorCode := 0;
     end;
end;

procedure TdtModul.DataModuleCreate(Sender: TObject);
var
   myReg : TIniFile;
begin
     myReg := TIniFile.Create( ExtractFilePath( Application.ExeName ) + 'SettingDB.ini' );

     __sServerName := MyReg.ReadString( 'SETTING', 'SERVER', 'localhost' );
     __sUserName := MyReg.ReadString( 'SETTINGS', 'USERNAME', 'root' );
     __sPassword := MyReg.ReadString( 'SETTINGS', 'PASSWORD', '' );

     __sDatabase := MyReg.ReadString( 'SETTINGS', 'DATABASE', 'smarthome' );

     OpenConnection;

     myReg.Free;
end;

function TdtModul.OpenConnection : boolean;
begin
     Database1.Disconnect;
     Database1.Server := __sServerName;
     Database1.Username := __sUserName;
     Database1.Password := __sPassword;
     Database1.Database := __sDatabase;

     Result := true;

     try
        dtModul.Database1.Connect;
     except
           on E:Exception do
           begin
                if __iErrorCode = 4060 then
                begin
                     exit;
                end;
                exit;
{
                Application.CreateForm( TformSetSQL, formSetSQL );
                if formSetSQL.ShowModal <> mrOk then
                begin
                     Result := false;
                     formSetSQL.Free;
                     exit;
                end
                else
                begin
                     formSetSQL.Free;
                     Result := OpenConnection;
                end;
                }
           end;
     end;
end;

end.


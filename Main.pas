unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, INIFiles, NxColumnClasses, NxColumns, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, IdContext, IdBaseComponent,
  IdComponent, IdCustomTCPServer, IdTCPServer, StdCtrls, NxCollection, Menus;

type
  TformMain = class(TForm)
    NextGrid1: TNextGrid;
    NxTextColumn1: TNxTextColumn;
    NxTextColumn2: TNxTextColumn;
    IdTCPServer1: TIdTCPServer;
    NxButton1: TNxButton;
    NxPanel1: TNxPanel;
    edPort: TEdit;
    NxButton2: TNxButton;
    NxTextColumn3: TNxTextColumn;
    NxProgressColumn1: TNxProgressColumn;
    NxTextColumn4: TNxTextColumn;
    NxTextColumn5: TNxTextColumn;
    NxIncrementColumn1: TNxIncrementColumn;
    PopupMenu1: TPopupMenu;
    Refresh2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure IdTCPServer1Disconnect(AContext: TIdContext);
    procedure NxButton2Click(Sender: TObject);
    procedure NxButton1Click(Sender: TObject);
    procedure NextGrid1AfterEdit(Sender: TObject; ACol, ARow: Integer;
      Value: WideString);
    procedure btnRefreshClick(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure Refresh2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iUsr_ID : Integer;
    __bEof : boolean;
    procedure tampilkanObjek;
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.btnRefreshClick(Sender: TObject);
begin
  tampilkanObjek;
end;

procedure TformMain.FormShow(Sender: TObject);

begin
     //tampilkanObjek;
end;

procedure TformMain.tampilkanObjek;
var
   myReg : TIniFile;
   i, iObject, iUsr_idRule, posisi : integer;
begin
     myReg := TIniFile.Create( ExtractFilePath( Application.ExeName ) + 'Settings.ini' );
     i := 1;
     posisi := 0;
     NextGrid1.ClearRows;
     __bEof := false;
     while not __bEof do
     begin
          iObject := myReg.ReadInteger('SETTINGS', IntToStr(i), 0);
          iUsr_idRule := myReg.ReadInteger('SETTINGS', 'USR_ID'+IntToStr(i),0);
          if iObject <> 0 then
          begin
            if iUsr_ID = iUsr_idRule then
              begin
                NextGrid1.AddRow(1);
                Inc(posisi);
                NextGrid1.Cell[1, posisi - 1].AsInteger := iObject;
                NextGrid1.Cell[2, posisi - 1].AsString := myReg.ReadString('SETTINGS', 'name' + IntToStr(i), 'Object_' + IntToStr(i));
                NextGrid1.Cell[4, posisi - 1].AsFloat := myReg.ReadInteger('SETTINGS', 'power' + IntToStr(i), 0) * NextGrid1.Cell[3, posisi - 1].AsInteger / 100;
                NextGrid1.Cell[5, posisi - 1].AsString := myReg.ReadString('SETTINGS', 'IP' + IntToStr(i), 'Object_' + IntToStr(i));
              end
            else if iUsr_ID = 0 then
              begin
                NextGrid1.AddRow(1);
                NextGrid1.Cell[1, i - 1].AsInteger := iObject;
                NextGrid1.Cell[2, i - 1].AsString := myReg.ReadString('SETTINGS', 'name' + IntToStr(i), 'Object_' + IntToStr(i));
                NextGrid1.Cell[4, i - 1].AsFloat := myReg.ReadInteger('SETTINGS', 'power' + IntToStr(i), 0) * NextGrid1.Cell[3, i - 1].AsInteger / 100;
                NextGrid1.Cell[5, i - 1].AsString := myReg.ReadString('SETTINGS', 'IP' + IntToStr(i), 'Object_' + IntToStr(i));
            end;
          Inc(i);
     end
     else
        __bEof := True;
     end;
     myReg.Free;

end;

procedure TformMain.IdTCPServer1Disconnect(AContext: TIdContext);
var
     iBaris : integer;
begin
     for iBaris := 0 to NextGrid1.RowCount - 1 do
     begin
          NextGrid1.Cell[3, iBaris].AsInteger := 0;
     end;
end;

procedure TformMain.IdTCPServer1Execute(AContext: TIdContext);
var
     myReg, myRule : TIniFile;
     iBaris  : integer;
     sMsg, sObj_Id, sData : string;
     sRule_Id, sRule_Obj_In, sRule_Obj_In_Name, sRule_Obj_In_Status, sRule_Obj_Out, sRule_Obj_Out_Name, sRule_Obj_Out_Status, sRule_User_Id, sRule_Obj_In_IP, sRule_Obj_Out_IP : string;
     bFound : boolean;
begin
     myRule := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Rule.ini');
     myReg := TIniFile.Create( ExtractFilePath( Application.ExeName ) + 'Settings.ini' );
     sMsg := AContext.Connection.IOHandler.ReadLn;
     if Pos('!', sMsg) > 0 then
     begin
          iUsr_ID := StrToInt(Copy(sMsg, pos('@', sMsg) + 1, MaxInt));
          //ShowMessage('USR ID Setelah login '+IntToStr(iUsr_ID));
          AContext.Connection.IOHandler.WriteLn('OK');
          tampilkanObjek;
     end
     else if Pos('@', sMsg) > 0 then
     //menerima rule dari base station
     begin
          sRule_Id := Copy( sMsg, pos('@', sMsg) + 1, pos('#',sMsg) - (pos('@',sMsg) + 1));
          sRule_Obj_In := Copy( sMsg, pos('#', sMsg) + 1, pos('(',sMsg) - (pos('#',sMsg)+ 1));
          sRule_Obj_In_IP := Copy( sMsg, pos('(', sMsg) + 1, pos('^',sMsg) - (pos('(',sMsg)+ 1));
          sRule_Obj_In_Name := Copy(sMsg, Pos('^', sMsg) + 1, Pos('$', sMsg) - (Pos('^', sMsg) + 1));
          sRule_Obj_In_Status := Copy(sMsg, pos('$',sMsg)+1, pos('%',sMsg) - (pos('$',sMsg)+1));
          sRule_Obj_Out := Copy( sMsg, pos('%', sMsg) + 1, pos('+',sMsg) - (pos('%',sMsg)+1));
          sRule_Obj_Out_Name := Copy(sMsg, Pos('+', sMsg) + 1, Pos(')', sMsg) - (Pos('+', sMsg) + 1));
          sRule_Obj_Out_IP := Copy( sMsg, pos(')', sMsg) + 1, pos('*',sMsg) - (pos(')',sMsg)+ 1));
          sRule_Obj_Out_Status := Copy( sMsg, pos('*', sMsg) + 1, pos('&',sMsg) - (pos('*',sMsg) + 1));
          sRule_User_Id := Copy(sMsg, pos('&', sMsg) + 1, MaxInt);

          if sRule_Obj_In_Status = '100' then
          begin
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_ID', sRule_Id);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_In', sRule_Obj_in);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_In_IP', sRule_Obj_In_IP);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_In_Name', sRule_Obj_In_Name );
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_In_Status', sRule_Obj_In_Status);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_Out', sRule_Obj_Out);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_Out_Name', sRule_Obj_Out_Name);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_Out_IP', sRule_Obj_Out_IP);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_Obj_Out_Status', sRule_Obj_Out_Status);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_ON@'+sRule_Id, 'Rule_User_Id', sRule_User_Id);
          end
          else if sRule_Obj_In_Status = '0' then
          begin
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_ID', sRule_Id);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_In', sRule_Obj_in);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_In_IP', sRule_Obj_In_IP);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_In_Name', sRule_Obj_In_Name );
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_In_Status', sRule_Obj_In_Status);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_Out', sRule_Obj_Out);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_Out_Name', sRule_Obj_Out_Name);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_Out_IP', sRule_Obj_Out_IP);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_Obj_Out_Status', sRule_Obj_Out_Status);
            myRule.WriteString('!'+sRule_Obj_In_Name+'_OFF@'+sRule_Id, 'Rule_User_Id', sRule_User_Id);
          end;
          //akhir kode untk menerima rule dari base station
     end
     else
     begin
          if Pos('#', sMsg) > 0 then
          begin
               sObj_Id := Copy( sMsg, pos('#', sMsg) + 1, pos('*', sMsg) - (pos('#', sMsg) + 1));
               sData := Copy( sMsg, pos('*', sMsg) + 1, MaxInt );

               iBaris := 0;

               while not bFound do
               begin
                    if NextGrid1.Cell[1, iBaris].AsInteger = StrToInt(sObj_Id) then
                    begin
                         bFound := True;
                         NextGrid1.Cell[3, iBaris].AsInteger := StrToInt(sdata);
                         NextGrid1.Cell[4, iBaris].AsFloat := myReg.ReadInteger('SETTINGS', 'power' + IntToStr(iBaris + 1), 0) * NextGrid1.Cell[3, iBaris].AsInteger / 100;
                         AContext.Connection.IOHandler.WriteLn('#' + sObj_Id + '*' + sData + '&' + NextGrid1.Cell[4, iBaris].AsString);
                    end
                    else
                         Inc(iBaris);
               end;
          end
          else
          begin
               sObj_Id := Copy( sMsg, pos('@', sMsg) + 1, pos('$', sMsg) - (pos('@', sMsg) + 1));
               sData := Copy( sMsg, pos('$', sMsg) + 1, MaxInt );

               iBaris := 0;

               while not bFound do
               begin
                    if NextGrid1.Cell[1, iBaris].AsInteger = StrToInt(sObj_Id) then
                    begin
                         bFound := True;
                         NextGrid1.Cell[3, iBaris].AsInteger := StrToInt(sdata);
                         NextGrid1.Cell[4, iBaris].AsFloat := myReg.ReadInteger('SETTINGS', 'power' + IntToStr(iBaris + 1), 0) * NextGrid1.Cell[3, iBaris].AsInteger / 100;

                    end
                    else
                         Inc(iBaris);
               end;
          end;
     end;
     myRule.Free;
     myReg.Free;


end;

procedure TformMain.NextGrid1AfterEdit(Sender: TObject; ACol, ARow: Integer;
  Value: WideString);
var
  myRule : TIniFile;
  ruleSectionList : TStringList;
  sObj_In_Name, sRule_Id_Obj_Out, sRule_Obj_Out_Status : string;
  iBaris, iNo : Integer;
  sNamaRule, sIdRule : string;
  i, iObj_in, iObj_in_status : Integer;

begin

  myRule := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Rule.ini');
  iBaris := NextGrid1.SelectedRow;
  iObj_in := NextGrid1.Cell[1,iBaris].AsInteger;
  iObj_in_status := NextGrid1.Cell[6,iBaris].AsInteger;
  sObj_in_name := NextGrid1.Cell[2,iBaris].AsString;
  ruleSectionList := TStringList.Create;
  myRule.ReadSections(ruleSectionList);

  if iObj_in_status = 100 then
  //eksekusi rule sensor ON
  begin
      i := 0;
      while i < ruleSectionList.Count do
      begin
        sNamaRule := Copy(ruleSectionList[i], Pos('!',ruleSectionList[i])+1, Pos('@',ruleSectionList[i])-2);
        sIdRule := Copy(ruleSectionList[i], Pos('@',ruleSectionList[i])+1, MaxInt);
        if sNamaRule = sObj_In_Name+'_ON' then
        begin
          sRule_Id_Obj_Out := myRule.ReadString('!'+sObj_In_Name+'_ON@'+sIdRule, 'Rule_Obj_Out', '0');
          sRule_Obj_Out_Status := myRule.ReadString('!'+sObj_In_Name+'_ON@'+sIdRule, 'Rule_Obj_Out_Status', '0');
        end
        else
        begin
          sRule_Id_Obj_Out := '0';
          sRule_Obj_Out_Status := '0';
        end;

        iNo := 0;
        while NextGrid1.Cell[1,iNo].AsInteger < NextGrid1.RowCount do
          begin
            if NextGrid1.Cell[1,iNo].AsInteger = StrToInt(sRule_Id_Obj_Out) then
              begin
                NextGrid1.Cell[3,iNo].AsInteger := StrToInt(sRule_Obj_Out_Status);
              end;
        Inc(iNo);
        end;
        Inc(i);
      end;
  end;

  if iObj_in_status = 0 then
  //eksekusi rule sensor OFF
  begin
    i := 0;
    while i < ruleSectionList.Count do
    begin
      sNamaRule := Copy(ruleSectionList[i], Pos('!',ruleSectionList[i])+1, Pos('@',ruleSectionList[i])-2);
      sIdRule := Copy(ruleSectionList[i], Pos('@',ruleSectionList[i])+1, MaxInt);

      if sNamaRule = sObj_In_Name+'_OFF' then
        begin
          sRule_Id_Obj_Out := myRule.ReadString('!'+sObj_In_Name+'_OFF@'+sIdRule, 'Rule_Obj_Out', '0');
          sRule_Obj_Out_Status := myRule.ReadString('!'+sObj_In_Name+'_OFF@'+sIdRule, 'Rule_Obj_Out_Status', '0');
        end
        else
        begin
          sRule_Id_Obj_Out := '0';
          sRule_Obj_Out_Status := '0';
        end;

      iNo := 0;
        while NextGrid1.Cell[1,iNo].AsInteger < NextGrid1.RowCount do
          begin
            if NextGrid1.Cell[1,iNo].AsInteger = StrToInt(sRule_Id_Obj_Out) then
              begin
                NextGrid1.Cell[3,iNo].AsInteger := StrToInt(sRule_Obj_Out_Status);
              end;
          Inc(iNo);
        end;
          Inc(i);
    end;
  end;

    NextGrid1.cell[3,iBaris].AsInteger := NextGrid1.Cell[6,iBaris].AsInteger;
    myRule.Free;
end;

procedure TformMain.NxButton1Click(Sender: TObject);
begin
     NxPanel1.Visible := True;
end;

procedure TformMain.NxButton2Click(Sender: TObject);
begin
     IdTCPServer1.DefaultPort := StrToInt(edPort.Text);
     NxPanel1.Visible := false;
end;

procedure TformMain.Refresh1Click(Sender: TObject);
begin
  tampilkanObjek;
end;

procedure TformMain.Refresh2Click(Sender: TObject);
begin
  tampilkanObjek
end;

end.
